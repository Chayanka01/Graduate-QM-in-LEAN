# Independent audit of the first Wigner helper milestone

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Historical milestone snapshot. Current sealed-theorem status and closure evidence
are in [FINAL_AUDIT.md](FINAL_AUDIT.md); the original findings below are retained.

Date: 2026-10-09. Reviewer: `wigner-helpers-audit`, independent of both
proof workers and the integrating lead.

Verdict: **PASS for compiled and independently audited internal helpers**. This is not frozen-root certification, source-node PROVED status, or a proof of arbitrary-dimensional Wigner. The sole manifest-bound root remains DRAFT_SORRY / FROZEN_UNPROVED.

## Source-first reconstruction and pinned evidence

Before inspecting either implementation, the auditor read the locked primary PDF, Section II (2.1)–(2.4) and (2.8), Section III (3.2), the author ruling in `docs/wigner/APPROVAL.md`, and `docs/wigner/PROOF_SOURCE.md` sections scalar_invariance, zero_probability, image_orthogonality, dimension_zero, dimension_one. The PDF was extracted with bundled Python/pypdf; no network copy replaced it. Recomputed SHA256 values matched `docs/wigner/source-lock.json`:

- PDF: `59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228`.
- Transcription: `8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632`.

Independently expected mathematics: physical states are nonzero complex scalar orbits; with first-slot conjugate linear inner product, the normalized expression is `‖inner x y‖²/(‖x‖²*‖y‖²)`. Nonzero scalar rescaling preserves it. For nonzero representatives its vanishing is equivalent to orthogonality. The root's all-representative preservation condition therefore carries orthogonal pairs to orthogonal pairs without a lift, finite dimensionality, or bijection. In dimension zero rays are empty (explicit author-approved extension); in dimension one any two rays coincide. An arbitrary self-map in either case equals the identity-induced ray map, so the identity unitary supplies the root's left existential branch without probability preservation or bijectivity.

Only after that reconstruction, stable files were inspected:

| File | SHA256 |
|---|---|
| `GraduateQM/Wigner/RayProbability.lean` | `2fe5606c3235600c43dcfbbbe3026344e1948113c54c2127d8a2f9c692f7e14a` |
| `GraduateQM/Wigner/LowDimensional.lean` | `4f5e630e3b77bc53bc249294f99be872c00753d4f8bc2c163cc1d61ad1219a01` |

## Binder audit

Counts include implicit and instance arguments and recursively enumerate the binders inside `h_probability`; universes are type formation, not logical premises. No project-owned assumption aliases, classes, gates, or witness bundles occur. The following common rows apply independently to **each of the seven exports**; they must be included once in each export's counts.

| Binder | Bin | Justification |
|---|---|---|
| `{E : Type*}` | TYPING | Carrier of the complex inner-product space, source II conventions |
| `[NormedAddCommGroup E]` | TYPING | Mathlib carrier structure implementing vector norms, source II (2.1)–(2.4) |
| `[InnerProductSpace ℂ E]` | TYPING | Complex scalar action and positive-definite inner product, source II (2.1)–(2.4) |

`GraduateQM.Wigner.probability_smul_smul` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `(x : E)` | SOURCE | First representative, scalar_invariance |
| `(y : E)` | SOURCE | Second representative, scalar_invariance |
| `{a : ℂ}` | SOURCE | First rescaling scalar, scalar_invariance |
| `{b : ℂ}` | SOURCE | Second rescaling scalar, scalar_invariance |
| `(ha : a ≠ 0)` | SOURCE | Nonzero first rescaling, scalar_invariance |
| `(hb : b ≠ 0)` | SOURCE | Nonzero second rescaling, scalar_invariance |

Counts: SOURCE 6, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 9. Its algebraic identity also allows zero x/y, a genuine strengthening with no extra premise. The physically meaningful source specialization with x/y nonzero was separately compiled, including proofs that the scaled vectors remain nonzero. This theorem does not define ray probability at zero, and no such meaning is assigned.

`GraduateQM.Wigner.probability_eq_zero_iff` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `{x : E}` | SOURCE | First representative, zero_probability |
| `{y : E}` | SOURCE | Second representative, zero_probability |
| `(hx : x ≠ 0)` | SOURCE | Physical representative domain, zero_probability |
| `(hy : y ≠ 0)` | SOURCE | Physical representative domain, zero_probability |

Counts: SOURCE 4, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 7. The real denominator is nonzero by the two nonzero-vector premises; the full equivalence, not only one direction, is proved.

`GraduateQM.Wigner.image_inner_eq_zero` additionally has the following expanded rows. Names prefixed `h_probability.` refer to nested quantification, not additional top-level arguments.

| Binder | Bin | Justification |
|---|---|---|
| `f : Projectivization ℂ E → Projectivization ℂ E` | SOURCE | Ray map, image_orthogonality / source II (2.8) |
| `h_probability` | SOURCE | Exact approved all-representative preservation premise |
| `h_probability.x : E` | SOURCE | Universally quantified first source representative |
| `h_probability.y : E` | SOURCE | Universally quantified second source representative |
| `h_probability.x' : E` | SOURCE | Universally quantified first output representative |
| `h_probability.y' : E` | SOURCE | Universally quantified second output representative |
| `h_probability.hx : x ≠ 0` | SOURCE | First source representative domain |
| `h_probability.hy : y ≠ 0` | SOURCE | Second source representative domain |
| `h_probability.hx' : x' ≠ 0` | SOURCE | First output representative domain |
| `h_probability.hy' : y' ≠ 0` | SOURCE | Second output representative domain |
| `h_probability` first unnamed image equality | SOURCE | `f [x] = [x']`, conditional representative relation |
| `h_probability` second unnamed image equality | SOURCE | `f [y] = [y']`, conditional representative relation |
| `x : E` | SOURCE | Chosen first source representative, image_orthogonality |
| `y : E` | SOURCE | Chosen second source representative, image_orthogonality |
| `x' : E` | SOURCE | Chosen first output representative, image_orthogonality |
| `y' : E` | SOURCE | Chosen second output representative, image_orthogonality |
| `hx : x ≠ 0` | SOURCE | First source representative domain |
| `hy : y ≠ 0` | SOURCE | Second source representative domain |
| `hx' : x' ≠ 0` | SOURCE | First output representative domain |
| `hy' : y' ≠ 0` | SOURCE | Second output representative domain |
| `hfx : f [x] = [x']` | SOURCE | Specified first output ray |
| `hfy : f [y] = [y']` | SOURCE | Specified second output ray |
| `hxy : inner x y = 0` | SOURCE | Chosen input orthogonal pair, source III (3.2) expansion |

Counts including nested preservation binders: SOURCE 23, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 26. The nested formula and implication order exactly match the root input. This is an internal conditional consequence: it consumes the genuine root assumption `h_probability`, representative identities, and input orthogonality. It does not assume a basis, a vector lift, bijectivity, or finite dimensionality.

For **each of the four low-dimensional exports**, add the following common row to the three shared typing rows:

| Binder | Bin | Justification |
|---|---|---|
| `[FiniteDimensional ℂ E]` | SOURCE | Explicit finite-dimensional premise of the chosen helper/source statements; PROOF_SOURCE conventions. No separate audited standing-assumption boundary is asserted. |

`GraduateQM.Wigner.isEmpty_projectivization_of_finrank_eq_zero` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `h : Module.finrank ℂ E = 0` | RULED | Explicit empty-state dimension-zero extension, APPROVAL 2026-10-09 and dimension_zero |

Counts: SOURCE 1, STANDING 0, TYPING 3, RULED 1, EXCESS 0; total 5.

`GraduateQM.Wigner.subsingleton_projectivization_of_finrank_le_one` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `h : Module.finrank ℂ E ≤ 1` | SOURCE | Conditional union of dimension_zero and dimension_one subcases; zero endpoint authorized by APPROVAL |

Counts: SOURCE 2, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 5.

`GraduateQM.Wigner.eq_projectivization_map_refl_of_finrank_le_one` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `h : Module.finrank ℂ E ≤ 1` | SOURCE | Same local degenerate subcase restriction |
| `f : Projectivization ℂ E → Projectivization ℂ E` | SOURCE | Arbitrary ray self-map, dimension_zero/dimension_one |

Counts: SOURCE 3, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 6.

`GraduateQM.Wigner.exists_unitary_of_finrank_le_one` additionally has:

| Binder | Bin | Justification |
|---|---|---|
| `h : Module.finrank ℂ E ≤ 1` | SOURCE | Same local degenerate subcase restriction |
| `f : Projectivization ℂ E → Projectivization ℂ E` | SOURCE | Arbitrary ray self-map, dimension_zero/dimension_one |

Counts: SOURCE 3, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 6.

The dimension premises are genuine premises of these explicitly conditional internal helpers. They would be EXCESS if appended to the arbitrary-dimension frozen root. No such alteration is made. There is no inference of a proof for dimension at least two.

## Semantic closure and proof inspection

All seven exports are theorems. Neither file introduces a project-owned semantic definition, quotient, probability function, typeclass, or fallback construction. Definition-body characterization checks are therefore N/A for new definitions. Public carrier and normalization match: Mathlib `Projectivization ℂ E` is the nonzero scalar-orbit carrier; probability remains inline; `LinearIsometryEquiv` supplies the genuine unitary witness and its injective linear map induces the ray action.

Scalar cancellation uses sesquilinearity, multiplicativity of norms, and nonzero scalar norm squares. The zero-probability equivalence uses denominator nonvanishing and vanishing norm squares. Image orthogonality explicitly rewrites by `h_probability` and consumes both directions of the zero-probability equivalence. In dimension zero, finrank zero gives a subsingleton vector space, contradicting any nonzero ray representative. In dimension one, standard finite-dimensional scalar-multiple existence and projective equality make rays subsingleton. Function equality to the identity-induced ray action follows on that subsingleton carrier; the final existential is witnessed by the actual identity linear isometric equivalence. No Wigner black box, phase section, or chosen coherent lift is used.

The root inputs are consumed as follows: `E` and its inner-product structure throughout; finite dimensionality only in lowdim; `f` in image and lowdim map claims; `h_probability` in image orthogonality; `h_bijective` unnecessary for these restricted claims. The general root is not imported or consumed as a theorem.

## Independent Lean evidence

Command: `./scripts/lake env lean .state/wigner-helper-audit.lean > .state/wigner-helper-audit.log 2>&1`, exit **0**, with no errors or warnings. The probe imported only the two helper modules, never the frozen root or provider. It independently checked:

1. Exact types of all seven exports with term applications and `pp.all` type output.
2. Scalar invariance specialized to nonzero physical representatives, also proving both scaled vectors nonzero.
3. A producer-consumer composition from source-pair probability zero, through source orthogonality and image orthogonality, to output-pair probability zero; the exact reconstructed all-representative root premise supplies preservation.
4. The complete root-shaped unitary-or-antiunitary disjunction, separately for finrank zero and finrank one, using the lowdim producer and `Or.inl` with the identity unitary witness supplied by that producer. These stronger restricted examples need no unused preservation/bijection assumptions.
5. `#print axioms` on every actual public export.

Each of all seven exports has exactly the reported axioms `[propext, Classical.choice, Quot.sound]`; none has `sorryAx` or a custom axiom. Probe SHA256 before deletion: `563a2aea555a659ad484c90f30ee1bf9f7b451a800072fd79825e58c9edeba37`.

The transient `.lean` probe was deleted after recording. Its complete source is retained between `REPRODUCIBLE_AUDIT_PROBE_SOURCE_BEGIN` and `REPRODUCIBLE_AUDIT_PROBE_SOURCE_END` in the ignored `.state/wigner-helper-audit.log`, together with exact types, axiom output, and recorded exit status. These historical local logs are not distributed. For public reproducibility, run the shipped checks described in RELEASE.md; no access to private logs is required.

Independently ran `python3 scripts/check_infrastructure.py`, exit **0**: `FROZEN-ANCHOR GUARD OK`; configuration passed with 6 project modules and 12 pinned skills. Full `./scripts/check` was run by the lead, not independently rerun by this auditor. The guard is a mechanical tripwire; it is not this semantic audit's substitute.

## Scope and remaining work

No finding requires helper correction. Remaining obligations include the nondegenerate Wigner proof, its exact frozen assembly, and subsequent independent root source/dependency/axiom audit. The helper milestone does not certify normalization correspondence or any dimension-at-least-two source node. Audit identity depends on the hashes above; meaning-changing edits require renewed review.

DRAFT_ANCHORS: 1 — `GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean`, unchanged registered root, FROZEN_UNPROVED.

UNREGISTERED_SORRIES: 0 — independently scanned project scope; none in either audited helper.

DRAFT_IMPORT_VIOLATIONS: 0 — independently checked guard; neither helper nor audit probe imports frozen root/provider.

SEALED_THIS_TURN: 0 — no frozen export sealed. Seven ordinary internal helper exports compiled and independently audited.
