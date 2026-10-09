# Graduate QM in Lean

An experimental graduate quantum mechanics learning project with AI-assisted,
kernel-checked Lean proofs. **The approved finite-dimensional Wigner theorem is
proved and independently audited.** Every bijection of complex pure-state rays
preserving all Born transition probabilities is induced by one global unitary
or antiunitary equivalence. The proof includes dimensions zero and one, handles
states with zero coordinates, and uses only standard Lean axioms. The argument
follows the direct proof in Simon et al., arXiv:0808.0779v2, Section III, with
the intermediate constructions made explicit. This is a formalization of a
known theorem, using Mathlib's standard mathematical foundations.

## Start here

| Interest | Entry point |
|---|---|
| Physics and scope | [Project overview](docs/wigner/PROJECT.md) |
| Exact formal statement | [Wigner theorem](GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean) |
| How the proof works | [Mathematical outline](docs/wigner/PROOF_SOURCE.md) and [Lean modules](GraduateQM/Wigner/) |
| How the result was checked | [Final source audit](docs/wigner/FINAL_AUDIT.md), [separate verification](docs/wigner/ORCHESTRATOR_VERIFICATION.md), and [release notes](docs/wigner/RELEASE.md) |
| Current status | [Milestone ledger](docs/progress.json) |

The intended textbook audience is physics graduate students learning the
mathematical foundations. Physics and mathematical proofs will form the main
text; Lean declarations and technical notes will be optional companion material.
The chapter structure is being designed with the author. This release provides
the verified proof library and its technical documentation; it is not yet a
finished textbook chapter.

## Local setup

- Lean **4.34.1**, the latest stable release checked on 2026-10-09.
- Mathlib **4.34.1**, pinned to an exact commit and a committed Lake manifest.
- All 12 Scott Armstrong skills, pinned with original licenses and provenance.
- A high-level physics orchestrator, a separate **gpt-6-astra / xhigh** lead,
  and **gpt-6-astra / medium** workers and independent auditors.
- A requested ceiling of **20 workers**, subject to the actual session limit.
  Agent settings do not establish that all 20 slots are available.

Lean, elan, build outputs, and caches live inside this checkout. No global Lean
installation or shell-profile edits are required. Use Python 3.12+ and Git:

```sh
python3 scripts/bootstrap.py
./scripts/lean --version
./scripts/check
```

Use `./scripts/lake` and `./scripts/lean` for every project command. The wrappers
select the local environment even if other Lean versions are installed.
Bootstrap needs network access. Routine builds can reuse the downloaded cache.
The check builds this library, including the sealed Wigner export, and audits
the exact axiom dependencies of both the infrastructure smoke theorem and
Wigner's theorem. Source fidelity is assessed separately by independent review.

## Working with the agents

Keep talking to the orchestrator in Codex. It passes approved work to the lead,
which prepares bounded worker packets, integrates results, and arranges an
independent audit. Start with a small team and increase parallelism only when
the proof has independent parts. At most two build jobs run concurrently.

Project skills are discovered through `.agents/skills`; they become available
on the next turn/new chat. Agent roles and defaults are in `.codex/`. Existing
sessions may retain their old limits. The desktop's effective runtime settings
always take precedence over a requested ceiling.

The [exact Wigner declaration](GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean)
was approved on 2026-10-09 and sealed by changing only its proof body. The
[final audit](docs/wigner/FINAL_AUDIT.md) verifies source fidelity, all-state
quantifiers, low-dimensional cases, actual dependency consumption, and the
standard axioms `propext`, `Classical.choice`, and `Quot.sound`. Kernel checks
were run by the lead, inspected by a fresh auditor, and rerun separately by the
orchestrator. Fresh-checkout release validation is recorded in the
[release notes](docs/wigner/RELEASE.md). Earlier milestone audits remain as historical
evidence. Read [the project scope](docs/wigner/PROJECT.md),
[the sources](docs/wigner/SOURCES.md), [the workflow](docs/WORKFLOW.md), and
[agent rules](AGENTS.md).
The pinned skill workflow requires independent statement review and explicit
approval of exact source-facing declarations before proof campaigns begin.

## Provenance

[Scott Armstrong's skills](https://github.com/scottnarmstrong/LeanAutoformalizationSkills)
are vendored at commit `05a07311f16bc581729e52f3e73647b95fa9bef1`. The snapshot is
unmodified, and project-local links are portable. Its original
[license](vendor/LeanAutoformalizationSkills/LICENSE),
[provenance](vendor/LeanAutoformalizationSkills/PROVENANCE.md), and
[third-party notices](vendor/LeanAutoformalizationSkills/THIRD_PARTY_NOTICES.md)
remain with it. Hashes in `docs/skills-checksums.json` detect accidental edits.

[Dependency pins](docs/dependencies.json) record versions;
[the milestone ledger](docs/progress.json) records scope.

## License and verification records

Project-owned code and documentation are licensed under [Apache-2.0](LICENSE),
matching the existing source headers. Vendored skills retain their own licenses
and notices; the project license does not replace them. Mathlib remains a
separately licensed dependency. The cited papers are not redistributed here.

Historical audit reports refer to private local `.state/` execution logs. Those
logs and conversations are not distributed. Readers can run the shipped checks
from a fresh checkout; see [release verification](docs/wigner/RELEASE.md).
