# Wigner v1 frozen statement audit

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Historical milestone snapshot. Current sealed-theorem status and closure evidence
are in [FINAL_AUDIT.md](FINAL_AUDIT.md); the original findings below are retained.

Audit date: 2026-10-09. Independent reviewer: wigner-frozen-audit, Astra medium, separate from the declaration author/technical integrator. The reviewer read the primary source, approved review block, frozen declaration, manifest, ABI output and relevant Mathlib definitions. Read-only review; no independent Lean execution by this reviewer. Lead and orchestrator separately compiled the exact named frozen module successfully, with the expected registered placeholder warning only.

DECLARATION_FIDELITY: PASS
DRAFT_ALLOWLIST: PASS
PROOF_STATUS: FROZEN_UNPROVED

## Binder review

| Expanded input | Bin | Reason |
|---|---|---|
| E | TYPING | Ambient carrier |
| NormedAddCommGroup E | TYPING | Normed additive carrier |
| InnerProductSpace complex E | SOURCE | Source Section II Hilbert structure |
| FiniteDimensional complex E | RULED | Author-approved finite-dimensional specialization |
| f | SOURCE | Ray transformation |
| h_bijective, injectivity | SOURCE | Equation (2.8), one-to-one |
| h_bijective, surjectivity | SOURCE | Equation (2.8), onto |
| h_probability | SOURCE | All pair probabilities, (2.4), (2.8) |
| x | TYPING | Input representative |
| y | TYPING | Input representative |
| x' | TYPING | Output representative |
| y' | TYPING | Output representative |
| hx | TYPING | Nonzero ray domain |
| hy | TYPING | Nonzero ray domain |
| hx' | TYPING | Nonzero ray domain |
| hy' | TYPING | Nonzero ray domain |
| First image equality | SOURCE | First output representative |
| Second image equality | SOURCE | Second output representative |

Expanded-row counts: SOURCE 7, STANDING 0, TYPING 10, RULED 1, EXCESS 0. This count expands bijectivity into two inputs, unlike the earlier 17-syntactic-binder intake table. Universe level is typing metadata. The zero-dimensional extension and inclusive alternative in dimension one are explicitly approved; dimension two is included without weakening to orthogonality-only preservation.

## Definitions and exact identity

No project-owned semantic definition occurs in the root. Existing Projectivization is the quotient of nonzero vectors by nonzero scalars; normalized squared overlap agrees with the source unit-ray formula. The map constructor acts by the witness on rays. LinearIsometryEquiv contains invertibility, additivity, scalar compatibility and norm preservation; starRingEnd on complex numbers is conjugation. Existential witnesses implement the whole ray function, so no vector-dependent branch or given lift is hidden.

Approved block/frozen file SHA256: 857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902.
Prefix: 95fdab26e69e359d221b95dc5dc44908326ff85c21e230a2bfa3b6d61fe6b4e5.
Suffix: 2d8a36cbcd95a30d76492d0d647263e062399449f093949160c5651e63ec554d.
Elaborated type snapshot: 393a6d05da209da8453b5fcc43a3972c578d3ea4c031b2843b86c79929dd5727.

The reviewer verified the snapshot is the complete printed proposition up to `: Prop`, not truncated or a proof. Its honest text-snapshot method is in APPROVAL.md. A later addendum verified primary PDF SHA256 59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228 against both the actual ignored artifact and manifest/source-lock metadata. Initial source-pinning and compilation reservations were thereby resolved. The guard subsequently gained ongoing ABI-snapshot hash enforcement, with 17 regression tests passing; this is lead/guard-worker execution evidence, not a claim the read-only reviewer ran tests.

## Registered draft axiom evidence

Lead command: `./scripts/lake env lean --stdin` importing only the frozen module and printing its exact export axioms. Output: `[propext, sorryAx, Classical.choice, Quot.sound]`. The single registered draft intentionally depends on `sorryAx`; this is why it cannot count as a proved theorem or be imported by production. No custom project axiom was reported.

## Scope and remaining work

Exactly one registered `by sorry` is permitted. The root and provider are quarantined from production. This audit stops at faithful frozen-unproved status: it certifies neither a mathematical proof nor a sorry-free axiom closure. The implementation export is not yet present. Source graph and meaningful helper proofs remain campaign obligations.

DRAFT_ANCHORS: 1, GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean
UNREGISTERED_SORRIES: 0 observed
DRAFT_IMPORT_VIOLATIONS: 0 observed
SEALED_THIS_TURN: 0
