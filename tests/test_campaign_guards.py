"""Regression checks on disposable copied source roots; never invoke Lean/Lake."""
import contextlib
import hashlib
import importlib.util
import io
import json
from pathlib import Path
import shutil
import tempfile
import unittest

ROOT = Path(__file__).resolve().parents[1]
spec = importlib.util.spec_from_file_location('infrastructure', ROOT / 'scripts/check_infrastructure.py')
infra = importlib.util.module_from_spec(spec)
spec.loader.exec_module(infra)
ANCHOR = 'GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean'
PROVIDER = 'GraduateQM/Wigner/Provider.lean'
PREFIX = '''/- Ordinary copyright /- nested -/ comment. -/
-- Header comment
module
public import GraduateQM.Wigner.Provider
public section
namespace GraduateQM.Wigner
-- FROZEN_ANCHOR_PREFIX_BEGIN
theorem exists_unitary_or_antiunitary : True :=
-- FROZEN_ANCHOR_PROOF_BEGIN
'''
SUFFIX = '''-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN
end GraduateQM.Wigner
-- FROZEN_ANCHOR_SUFFIX_END
'''


class CampaignGuards(unittest.TestCase):
    """Synthetic anchors are isolated fixtures, never project approvals."""

    def setUp(self):
        self.temporary = tempfile.TemporaryDirectory(prefix='campaign-guard-test-')
        self.addCleanup(self.temporary.cleanup)
        self.root = Path(self.temporary.name)
        target = self.root / infra.FROZEN_CHECKER
        target.parent.mkdir(parents=True)
        shutil.copyfile(ROOT / infra.FROZEN_CHECKER, target)
        self.write('GraduateQM.lean', 'module\npublic import GraduateQM.Infrastructure\n')
        self.write('GraduateQM/Infrastructure.lean', 'module\npublic theorem smoke : True := by trivial\n')
        self.write(PROVIDER, 'module\n-- No provider proof claimed.\n')
        self.write(ANCHOR, PREFIX + 'by sorry\n' + SUFFIX)
        # Snapshot for this synthetic True proposition; not campaign ABI evidence.
        abi_text = 'True\n'
        self.write(infra.ABI_SNAPSHOTS[ANCHOR], abi_text)
        digest = lambda text: hashlib.sha256(text.encode()).hexdigest()
        anchor = dict(id='fixture', kind='theorem', state='DRAFT_SORRY', path=ANCHOR,
                      export='GraduateQM.Wigner.exists_unitary_or_antiunitary',
                      author_approval=dict(approved_by='TEST ONLY', approved_at='TEST ONLY',
                                           approval_ref='TEST ONLY', approval_version='TEST ONLY'),
                      source=dict(revision='TEST ONLY', range='TEST ONLY'),
                      contract=dict(id='TEST ONLY', version='TEST ONLY'),
                      abi_sha256=digest(abi_text), definition_closure=[],
                      split_policy=dict(source_group='TEST ONLY', mode='NOT_SPLIT', ruling_ref='TEST ONLY'),
                      implementation=dict(module='GraduateQM.Wigner.Provider',
                                          export='GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary'),
                      prefix_sha256=digest(PREFIX), suffix_sha256=digest(SUFFIX),
                      draft_allowlist=dict(frozen_paths=[], audit_paths=[]))
        self.manifest = dict(schema_version=1, manifest_state='AUTHOR_APPROVED',
                             seal_limits=dict(max_body_lines=3, max_body_bytes=512), anchors=[anchor])
        self.save_manifest()

    def write(self, path, text):
        target = self.root / path
        target.parent.mkdir(parents=True, exist_ok=True)
        target.write_text(text)

    def save_manifest(self):
        self.write(infra.CAMPAIGN_MANIFEST, json.dumps(self.manifest))

    def check(self):
        with contextlib.redirect_stdout(io.StringIO()):
            return infra.check_campaign(self.root)

    def reject(self, fragment):
        with self.assertRaisesRegex(SystemExit, fragment):
            self.check()

    def test_registered_draft_and_comment_header_pass(self):
        self.assertEqual(self.check(), 4)

    def test_extra_sorry_in_new_project_folder_rejected(self):
        self.write('Unexpected/Extra.lean', 'module\npublic theorem extra : True := by sorry\n')
        self.reject('unauthorized `sorry`')

    def test_changed_target_prefix_rejected(self):
        self.write(ANCHOR, PREFIX.replace(': True :=', ': False :=') + 'by sorry\n' + SUFFIX)
        self.reject('frozen prefix hash drift')

    def test_draft_and_provider_direct_and_transitive_imports_rejected(self):
        for module, message in [('GraduateQM.Wigner.Frozen.ExistsUnitaryOrAntiunitary', 'DRAFT_SORRY imported'),
                                ('GraduateQM.Wigner.Provider', 'DRAFT provider imported')]:
            for qualifier in ['import', 'public import', 'meta import', 'public meta import', 'import all']:
                with self.subTest(module=module, qualifier=qualifier):
                    self.write('GraduateQM/Bridge.lean', f'module\n{qualifier} {module}\n')
                    self.write('GraduateQM/Consumer.lean', 'module\npublic import GraduateQM.Bridge\n')
                    with self.assertRaises(SystemExit) as raised:
                        self.check()
                    text = str(raised.exception)
                    self.assertIn(message, text)
                    self.assertIn('GraduateQM/Bridge.lean', text)
                    self.assertIn('GraduateQM/Consumer.lean', text)

    def test_missing_manifest_rejected(self):
        (self.root / infra.CAMPAIGN_MANIFEST).unlink()
        self.reject('campaign manifest missing')

    def test_missing_abi_snapshot_rejected(self):
        (self.root / infra.ABI_SNAPSHOTS[ANCHOR]).unlink()
        self.reject('ABI snapshot missing')

    def test_altered_abi_snapshot_rejected(self):
        self.write(infra.ABI_SNAPSHOTS[ANCHOR], 'False\n')
        self.reject('ABI snapshot hash drift')

    def test_altered_manifest_abi_digest_rejected(self):
        self.manifest['anchors'][0]['abi_sha256'] = '0' * 64
        self.save_manifest()
        self.reject('ABI snapshot hash drift')

    def test_empty_manifest_rejected(self):
        self.manifest['anchors'] = []
        self.save_manifest()
        self.reject('exactly one manifest owner')

    def test_zero_anchor_declarations_rejected(self):
        prefix = PREFIX.replace('theorem exists_unitary_or_antiunitary : True :=\n', '')
        self.write(ANCHOR, prefix + 'by sorry\n' + SUFFIX)
        self.manifest['anchors'][0]['prefix_sha256'] = hashlib.sha256(prefix.encode()).hexdigest()
        self.save_manifest()
        self.reject('exactly one top-level declaration')

    def test_orphan_frozen_file_rejected(self):
        self.write('GraduateQM/Wigner/Frozen/Orphan.lean', 'module\npublic theorem orphan : True := by trivial\n')
        self.reject('exactly one manifest owner')

    def test_forbidden_tokens_rejected(self):
        for code in ['theorem bad : True := by admit', 'axiom bad : True',
                     'constant bad : True', 'unsafe def bad : Nat := 0']:
            with self.subTest(code=code):
                self.write('GraduateQM/Bad.lean', 'module\npublic ' + code + '\n')
                self.reject('Forbidden project token')

    def test_doc_comment_before_module_rejected(self):
        for comment in ['/-- Documentation -/', '/-! Module documentation -/']:
            with self.subTest(comment=comment):
                self.write(PROVIDER, comment + '\nmodule\n')
                self.reject('Module header missing')

    def test_comments_and_strings_are_not_code(self):
        self.write('GraduateQM/Prose.lean', 'module\n-- sorry admit axiom unsafe\npublic def prose : String := "sorry admit axiom unsafe"\n')
        self.assertEqual(self.check(), 5)

    def test_provider_reverse_import_rejected(self):
        self.write(PROVIDER, 'module\npublic import GraduateQM.Wigner.Frozen.ExistsUnitaryOrAntiunitary\n')
        self.reject('implementation module reverse-imports frozen anchor')

    def test_directory_symlink_rejected(self):
        (self.root / 'HiddenModules').symlink_to(self.root / 'GraduateQM', target_is_directory=True)
        self.reject('Project directory symlink forbidden')

    def test_transient_probe_excluded(self):
        self.write('.state/probe.lean', 'example : False := by sorry\n')
        self.assertEqual(self.check(), 4)


if __name__ == '__main__':
    unittest.main()
