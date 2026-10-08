#!/usr/bin/env bash
# Source this from a project wrapper; never change a user's shell profile.
QM_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
export ELAN_HOME="$QM_ROOT/.tooling/elan"
export XDG_CACHE_HOME="$QM_ROOT/.cache"
export MATHLIB_CACHE_DIR="$QM_ROOT/.cache/mathlib"
export PATH="$ELAN_HOME/bin:$PATH"
cd "$QM_ROOT"
