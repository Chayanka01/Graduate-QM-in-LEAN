# Orchestrator verification of the completed Wigner theorem

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Date: 2026-10-09. Executor: the user-facing orchestrator, separate from the
technical lead and the final source auditor. This supplements FINAL_AUDIT.md;
its attribution of the earlier builds to the lead remains historically correct.

Result: PASS for the exact approved finite-dimensional Wigner theorem,
`GraduateQM.Wigner.exists_unitary_or_antiunitary`.

Independently performed after the final lead handoff:

- Compared the sealed file with the exact author-reviewed code block. The sole
  difference is `by sorry` becoming
  `by exact GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary`.
- Verified SEALED manifest state and the five final implementation file hashes
  recorded in FINAL_AUDIT.md.
- Read the complete sign-coherence, global-branch, ray-reconstruction,
  coordinate-conjugation and provider implementations. The coordinate-lift
  premise is produced internally; the global branch precedes all states;
  reconstruction selects a nonzero coordinate for each individual state.
  No extra premise or dimensional lower bound enters the root.
- Reran `./scripts/check`: exit 0; 26 project modules, 12 pinned skills,
  17 guard regression tests, default GraduateQM build, and both named smoke
  and Wigner axiom checks passed. Build output reported 2450 jobs including
  cached dependencies. This is a current-checkout validation, not a clean
  fresh-checkout rebuild.
- Re-elaborated the exact sealed source in a separate transient module, followed
  by a fully explicit proof print and the root axiom query:
  `./scripts/lake env lean .state/orchestrator-wigner-sealed-check.lean`.
  Exit 0, with no warnings or errors. The elaborated proof is the provider
  applied to precisely `E inst inst_1 inst_2 f h_bijective h_probability`.
- The root's exact axiom closure is `propext`, `Classical.choice`, `Quot.sound`.
  It contains neither `sorryAx` nor a custom axiom. `git diff --check` passed.

The complete transient probe source and output are retained in the ignored
`.state/orchestrator-wigner-sealed-output.txt`; the temporary Lean source was
removed after recording. All campaign changes remain local. Only the earlier
seven setup files were published in commit 0f4a0f3.

This completes the approved existence theorem. It does not claim uniqueness,
an infinite-dimensional theorem, or coherent phases for a whole symmetry group.

DRAFT_ANCHORS: 0
UNREGISTERED_SORRIES: 0
DRAFT_IMPORT_VIOLATIONS: 0
SEALED_THIS_TURN: 1 — GraduateQM.Wigner.exists_unitary_or_antiunitary
