#!/usr/bin/env python3
"""Check bootstrap pins and configuration; not a semantic proof audit."""
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tomllib

ROOT = Path(__file__).resolve().parent.parent

def require(condition, message):
    if not condition:
        raise SystemExit(message)

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
    sources = [ROOT / 'GraduateQM.lean', *sorted((ROOT / 'GraduateQM').rglob('*.lean'))]
    for source in sources:
        content = source.read_text()
        require(content.startswith('module\n'), f'Module header missing: {source}')
        # Deliberately conservative lexical tripwire; exact-export axiom checks
        # and independent semantic/source review are separate obligations.
        require(not re.search(r'\b(sorry|admit|axiom|unsafe)\b', content),
                f'Forbidden bootstrap token: {source}')
    print(f'Infrastructure configuration passed: {len(sources)} modules, {len(links)} pinned skills.')

if __name__ == '__main__':
    main()
