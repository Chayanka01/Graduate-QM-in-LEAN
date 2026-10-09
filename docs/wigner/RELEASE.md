# Finite-dimensional Wigner theorem: public release

This release contains the completed theorem and its supporting library,
verification scripts, pinned dependencies, source references and audit reports.
The textbook chapter structure remains under discussion with the author.

## Scope and provenance

The exact result is `GraduateQM.Wigner.exists_unitary_or_antiunitary` in
[the frozen declaration](../../GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean).
It classifies bijections of pure-state rays preserving all normalized Born
transition probabilities, in every finite-dimensional complex inner-product
space, by a single unitary or antiunitary implementation. Its original approved
statement is unchanged. The proof uses Mathlib foundations and the direct
Section III route of Simon et al., arXiv:0808.0779v2; it does not import an
existing Wigner theorem. No novelty or priority claim is made.

The root has no proof holes or custom axioms. Its exact axiom closure is
`propext`, `Classical.choice`, `Quot.sound`. Uniqueness, infinite-dimensional
spaces, and coherent phases for a symmetry group are outside this theorem.

The publication is an additive update of the existing public main branch after
setup commit `0f4a0f30b90c3e417e6f1d651ee9a49fcc2e4ecf`, explicitly authorized
on 2026-10-09. This is the maintained project repository, not a history rewrite.
No registry submission or external archive is part of this release.

## Reproduce the checks

On supported macOS or Linux systems, with Python 3.12+ and Git installed:

```sh
git clone https://github.com/Chayanka01/Graduate-QM-in-LEAN.git
cd Graduate-QM-in-LEAN
python3 scripts/bootstrap.py
```

Bootstrap installs the pinned Lean toolchain inside the checkout, restores the
public pinned dependencies and caches needed by all direct Mathlib imports,
then runs `./scripts/check`. Subsequent checks use:

```sh
./scripts/check
```

This checks the dependency/skill pins, frozen-statement and manifest integrity,
17 guard regressions, the default project build, and the exact axiom closure of
the main Wigner theorem and infrastructure smoke theorem. It generates its own
temporary probes; no private execution log or AI account is required.

The semantic review is separate from compilation: [FINAL_AUDIT.md](FINAL_AUDIT.md)
and [ORCHESTRATOR_VERIFICATION.md](ORCHESTRATOR_VERIFICATION.md) record source,
quantifier, dependency and proof-only-change checks. Historical reports retain
their original scope and may mention logs kept in ignored local state. Those
logs, conversations, the downloaded source PDF and local tooling are not shipped.
Source URLs and hashes are public in [SOURCES.md](SOURCES.md) and source-lock.json.

## Release validation

On 2026-10-09, the documented bootstrap completed successfully on macOS arm64
in a separate checkout containing the release sources and no pre-existing local
toolchain, dependency packages or build artifacts. It installed Lean 4.34.1,
restored the pinned public dependencies, downloaded 2,410 Mathlib cache files,
and built the project, including the sealed Wigner theorem. All 17 guard
regressions passed. Both named export axiom audits returned exactly
`propext`, `Classical.choice`, and `Quot.sound`.

All 26 project Lean modules and 12 pinned skills passed the infrastructure
checks. The strict source dependency-graph checks also passed. The final
release sources were compared against the checked snapshot; only release
documentation and status records were finalized after the build. Linux and
Intel macOS bootstrap paths were not exercised in this release check.

## Licensing

Project-owned code and documentation use the root Apache-2.0 [license](../../LICENSE),
consistent with the source headers. Vendored Scott Armstrong skills retain their
original licenses and attribution. Mathlib is a separately licensed dependency;
the scholarly papers are cited rather than redistributed.
