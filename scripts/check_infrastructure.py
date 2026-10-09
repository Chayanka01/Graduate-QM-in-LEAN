#!/usr/bin/env python3
"""Check pins and manifest-bound campaign guards; not a semantic proof audit."""
import hashlib
import importlib.util
import json
import os
from pathlib import Path
import re
import subprocess
import shutil
import sys
import tempfile
import tomllib

ROOT = Path(__file__).resolve().parent.parent

def require(condition, message):
    if not condition:
        raise SystemExit(message)

FROZEN_CHECKER = Path('vendor/LeanAutoformalizationSkills/skills/lean-orchestrator/scripts/check_frozen_anchors.py')
CAMPAIGN_MANIFEST = Path('docs/wigner/frozen-anchors.json')
# Independent paths: manifests cannot redirect their ABI evidence to arbitrary files.
ABI_SNAPSHOTS = {
    'GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean':
        Path('docs/wigner/abi/ExistsUnitaryOrAntiunitary.txt'),
}


def check_campaign(root=ROOT):
    """Check a copied production-source view with the unmodified pinned guard.

    Ignored toolchains and transient .state probes are not project modules.
    Copying preserves the guard's complete import graph and exact source bytes
    without traversing or changing dependency artifacts.
    """
    checker = root / FROZEN_CHECKER
    spec = importlib.util.spec_from_file_location('frozen_anchor_guard', checker)
    require(spec is not None and spec.loader is not None, 'Missing frozen-anchor checker')
    upstream = importlib.util.module_from_spec(spec)
    spec.loader.exec_module(upstream)
    excluded = {'.git', '.lake', '.tooling', '.cache', '.state', 'vendor',
                '.agents', '.codex', '__pycache__'}
    sources = []
    for directory, children, files in os.walk(root):
        children[:] = [child for child in children if child not in excluded]
        for child in children:
            require(not (Path(directory) / child).is_symlink(),
                    f'Project directory symlink forbidden: {Path(directory) / child}')
        sources.extend(Path(directory) / name for name in files if name.endswith('.lean'))
    sources.sort()
    require(root / 'GraduateQM.lean' in sources, 'Project root module missing')
    for source in sources:
        require(not source.is_symlink(), f'Project source symlink forbidden: {source}')
        content = source.read_text()
        require(source.name == 'lakefile.lean' or upstream.has_module_header(content), f'Module header missing: {source}')
        code = upstream.Guard.code_mask(content)
        require(not re.search(r'\b(admit|axiom|constant|unsafe)\b', code),
                f'Forbidden project token: {source}')
    manifest_path = root / CAMPAIGN_MANIFEST
    require(manifest_path.is_file(), f'Active Wigner campaign manifest missing: {CAMPAIGN_MANIFEST}')
    manifest = json.loads(manifest_path.read_text())
    entries = manifest.get('anchors', []) if isinstance(manifest, dict) else []
    registered = [entry.get('path') for entry in entries if isinstance(entry, dict)] if isinstance(entries, list) else []
    for source in sources:
        if 'Frozen' in source.relative_to(root).parts:
            relative = source.relative_to(root).as_posix()
            require(registered.count(relative) == 1, f'Frozen file must have exactly one manifest owner: {relative}')
    for anchor_path, snapshot_relative in ABI_SNAPSHOTS.items():
        matches = [entry for entry in entries if isinstance(entry, dict)
                   and entry.get('path') == anchor_path]
        require(len(matches) == 1, f'ABI-bound anchor must have exactly one manifest entry: {anchor_path}')
        snapshot = root / snapshot_relative
        require(snapshot.is_file() and not snapshot.is_symlink(),
                f'ABI snapshot missing or symlinked: {snapshot_relative}')
        require(hashlib.sha256(snapshot.read_bytes()).hexdigest() == matches[0].get('abi_sha256'),
                f'ABI snapshot hash drift: {snapshot_relative}')
    with tempfile.TemporaryDirectory(prefix='graduate-qm-guard-') as directory:
        view = Path(directory)
        for source in [*sources, manifest_path]:
            destination = view / source.relative_to(root)
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, destination)
        result = subprocess.run([sys.executable, str(checker), '--root', str(view),
                                 '--manifest', str(view / CAMPAIGN_MANIFEST)],
                                capture_output=True, text=True)
        require(result.returncode == 0, result.stdout + result.stderr)
    print(result.stdout.strip())
    return len(sources)


def main():
    pins = json.loads((ROOT / 'docs/dependencies.json').read_text())
    require((ROOT / 'lean-toolchain').read_text().strip() == pins['lean'], 'Lean pin drift')
    lake = tomllib.loads((ROOT / 'lakefile.toml').read_text())
    require(lake['require'][0]['rev'] == pins['mathlib']['commit'], 'Mathlib pin drift')
    manifest = json.loads((ROOT / 'lake-manifest.json').read_text())
    mathlib = next(p for p in manifest['packages'] if p['name'] == 'mathlib')
    require(mathlib['rev'] == pins['mathlib']['commit'], 'Mathlib manifest drift')
    agents = tomllib.loads((ROOT / '.codex/config.toml').read_text())['agents']
    require(agents['max_concurrent_threads_per_session'] == 20, 'Agent ceiling drift')
    require(agents['default_subagent_model'] == 'gpt-6-astra', 'Worker model drift')
    require(agents['default_subagent_reasoning_effort'] == 'medium', 'Worker effort drift')
    for role, effort in [('qm_lead', 'xhigh'), ('qm_prover', 'medium'), ('qm_auditor', 'medium')]:
        cfg = tomllib.loads((ROOT / f'.codex/agents/{role}.toml').read_text())
        require(cfg['model'] == 'gpt-6-astra' and cfg['model_reasoning_effort'] == effort,
                f'{role}: model or effort drift')
    vendor = ROOT / pins['skills']['snapshot']
    hashes = json.loads((ROOT / 'docs/skills-checksums.json').read_text())
    for path, digest in hashes.items():
        require(hashlib.sha256((vendor / path).read_bytes()).hexdigest() == digest,
                f'Vendored skill changed: {path}')
    links = list((ROOT / '.agents/skills').iterdir())
    require(len(links) == pins['skills']['count'], 'Skill count mismatch')
    for link in links:
        require(link.is_symlink() and link.resolve() == (vendor / 'skills' / link.name).resolve(),
                f'Broken skill link: {link}')
        require((link / 'SKILL.md').is_file(), f'Missing SKILL.md: {link}')
    source_count = check_campaign()
    print(f'Infrastructure configuration passed: {source_count} modules, {len(links)} pinned skills.')

if __name__ == '__main__':
    main()
