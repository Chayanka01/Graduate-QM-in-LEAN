#!/usr/bin/env python3
"""Install the pinned toolchain locally and restore this checkout's dependencies."""
from pathlib import Path
import hashlib
import json
import os
import platform
import subprocess
import tarfile
import urllib.request

ROOT = Path(__file__).resolve().parent.parent
ELAN = ROOT / '.tooling/elan'
ENV = dict(os.environ, ELAN_HOME=str(ELAN),
           XDG_CACHE_HOME=str(ROOT / '.cache'),
           MATHLIB_CACHE_DIR=str(ROOT / '.cache/mathlib'),
           MATHLIB_NO_CACHE_ON_UPDATE='1')
ENV['PATH'] = str(ELAN / 'bin') + os.pathsep + ENV.get('PATH', '')

def run(*args):
    subprocess.run(args, cwd=ROOT, env=ENV, check=True)

def main():
    if not (ELAN / 'bin/elan').is_file():
        platform_key = (platform.system(), platform.machine())
        targets = {('Darwin', 'arm64'): 'aarch64-apple-darwin',
                   ('Darwin', 'x86_64'): 'x86_64-apple-darwin',
                   ('Linux', 'x86_64'): 'x86_64-unknown-linux-gnu',
                   ('Linux', 'aarch64'): 'aarch64-unknown-linux-gnu'}
        if platform_key not in targets:
            raise SystemExit(f'Unsupported bootstrap platform: {platform_key}')
        version = json.loads((ROOT / 'docs/dependencies.json').read_text())['elan']
        name = f'elan-{targets[platform_key]}.tar.gz'
        url = f'https://api.github.com/repos/leanprover/elan/releases/tags/{version}'
        release = json.load(urllib.request.urlopen(url))
        asset = next(a for a in release['assets'] if a['name'] == name)
        digest = asset.get('digest', '')
        if not digest.startswith('sha256:'):
            raise SystemExit('Release asset has no SHA256 digest; refusing unverified install.')
        data = urllib.request.urlopen(asset['browser_download_url']).read()
        if 'sha256:' + hashlib.sha256(data).hexdigest() != digest:
            raise SystemExit('elan checksum mismatch')
        downloads = ROOT / '.tooling/downloads'
        downloads.mkdir(parents=True, exist_ok=True)
        archive = downloads / name
        archive.write_bytes(data)
        with tarfile.open(archive) as tf:
            tf.extractall(downloads, filter='data')
        run(str(downloads / 'elan-init'), '-y', '--no-modify-path',
            '--default-toolchain', 'none')
    toolchain = (ROOT / 'lean-toolchain').read_text().strip()
    run(str(ELAN / 'bin/elan'), 'toolchain', 'install', toolchain)
    # Committed manifests are restored by Lake; update only creates a missing one.
    if not (ROOT / 'lake-manifest.json').exists():
        run(str(ROOT / 'scripts/lake'), 'update')
    run(str(ROOT / 'scripts/lake'), 'exe', 'cache', 'get',
        'Mathlib.Analysis.InnerProductSpace.Basic')
    run(str(ROOT / 'scripts/check'))

if __name__ == '__main__':
    main()
