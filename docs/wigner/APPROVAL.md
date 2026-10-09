# Author approval: Wigner statement v1

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

On 2026-10-09 the author explicitly answered: **“Approve the statement and begin the proof”.**
The orchestrator conveyed that the approval covers the full Lean code block in the local author-review packet, including the provider import and all five frozen-region markers. The code block has been copied verbatim to `GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean`, retaining its final newline. The local conversation references remain in ignored state; no private conversation is published.

Approval includes arbitrary finite complex dimension (the empty-ray dimension-zero convention is explicit), the classical bijective ray symmetry, all-representative normalized Born probabilities, the inclusive global unitary/antiunitary existence conclusion, and the single joint declaration (NOT_SPLIT). It does not assert a proof, uniqueness, branch exclusivity, or authorize a different statement.

The initial body was exactly `by sorry`, registered as DRAFT_SORRY / FROZEN_UNPROVED and quarantined with its provider. It is not a proved dependency. The author also separately authorized publishing the seven setup files; publication of the completed proof was separately authorized on 2026-10-09. Only the orchestrator commits/pushes.

Approved code-block SHA256: `857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902`.
Frozen prefix SHA256: `95fdab26e69e359d221b95dc5dc44908326ff85c21e230a2bfa3b6d61fe6b4e5`.
Frozen suffix SHA256: `2d8a36cbcd95a30d76492d0d647263e062399449f093949160c5651e63ec554d`.

## Elaborated type snapshot

`docs/wigner/abi/ExistsUnitaryOrAntiunitary.txt` stores the complete `pp.all = true` rendering of the elaborated quantified proposition under pinned Lean 4.34.1 / Mathlib d13f23b723b8a846827a245b89c10fc7d3f11612. The generating term preserves every named binder from the approved declaration and changes only the theorem command into `#check (∀ ... , result)`. Command: `./scripts/lake env lean .state/wigner-abi-probe.lean`; exit 0. Two expected unused-hypothesis-name linter warnings follow the type-only check; they are excluded from the snapshot and remain in ignored execution output.

ABI SHA256: `393a6d05da209da8453b5fcc43a3972c578d3ea4c031b2843b86c79929dd5727`.

This is a hash of an explicitly elaborated, fully printed type with fixed toolchain settings; it is not a kernel binary ABI or a proof checksum. It binds the source-facing type, while raw prefix/suffix hashes bind all declaration bytes around the sole mutable proof body. The guard checks raw bytes and quarantine; independent source/binder review supplies mathematical fidelity. No project-owned semantic definitions occur in this root's definition closure. The temporary type probe is removed after recording evidence.
