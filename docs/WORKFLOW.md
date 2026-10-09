# Working arrangement

The user chooses physics and judges whether the exercise improves understanding.
The orchestrator translates that into a small, reviewable mathematical objective.
The lead manages implementation; workers explore disjoint obligations or named
alternative routes. A different worker audits the result. The orchestrator
returns a physics explanation with explicit assumptions and open questions.

The separate lead chat is created with gpt-6-astra at xhigh. Project agent defaults
and prover/auditor roles request gpt-6-astra at medium. The configured ceiling is
20 spawned agents excluding the lead. A session's actual exposed limit takes
precedence. A configuration entry is not evidence of 20 working agents. The
bootstrap records the observed limit and a real delegation test locally.

Only useful independent work is parallelized. Shared definitions and theorem
statements are settled before dependent proofs are distributed. Multiple
approaches to one proof use separate scratch files; none may alter the target.
The lead schedules at most two build jobs at once and reviews every integrated
diff. The user should never need to coordinate workers or resolve file collisions.

## Before the first theorem

1. Select a small problem and a pinned source together with the user.
2. Explain its physical meaning, assumptions, and what formalization will teach.
3. Find existing Mathlib definitions and results. Prepare exact declarations in
   transient, untracked files for elaboration and independent source review.
4. Show the complete declaration and a physics translation for author approval.
5. Activate Scott's frozen-anchor checker and quarantine, then freeze approved
   roots and construct a small dependency graph. The bootstrap contains no
   approved mathematical anchors and intentionally has no fake empty manifest.
6. Delegate bounded packets from the ready frontier, integrate, compile, inspect
   exact axiom dependencies, and obtain independent source/statement review.
7. Report the resulting physics and mathematics, not a count of agent messages.

Scott's full workflow is in
[lean-orchestrator](../vendor/LeanAutoformalizationSkills/skills/lean-orchestrator/SKILL.md).
His requirement to see the exact declarations matters: an agent can prove a
weaker or wrongly translated theorem perfectly. A draft `sorry` is permitted
only through his registered, quarantined workflow and is never proof progress.

## Packet template

- Goal and physics/source context
- Exact frozen target and approved source/version (when applicable)
- Owned files and explicitly allowed dependencies
- Alternative route identifier, if exploring competing approaches
- Validation command and axiom-audit target
- Stop condition and bounded work budget
- Required handoff: changed files, exact exports, checks, assumptions, obstructions

## State and communication

`docs/progress.json` is the small public milestone ledger. `.state/` stores local
chat links, verification logs, and transient packets. The active first problem is finite-dimensional Wigner's theorem. The lead is
preparing source selection, exact declarations, and independent review before
the author-approval and proof-campaign stages.
Both orchestrator and lead may send coordination messages within this authorized
workflow. No recurring background job is configured.

The host's unrelated command-line `codex` launcher is not needed by this workflow;
all conversations and delegation use the working Codex desktop runtime.
