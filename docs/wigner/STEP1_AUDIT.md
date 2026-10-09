# Independent Wigner Step 1 audit — 2026-10-09

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Historical milestone snapshot. Current sealed-theorem status and closure evidence
are in [FINAL_AUDIT.md](FINAL_AUDIT.md); the original findings below are retained.

Independent reviewer tag: `wigner-step1-audit`.

## Verdict and scope

PASS for the internal combined Step 1 implementation `GraduateQM.Wigner.exists_basis_unitary_normalization` and the supporting algebraic lemmas at their stated scopes. The four coordinate lemmas and image-basis lemma are CONDITIONAL relative to the full Step 1 source boundary; their basis/fixed-basis inputs are not accepted as root premises. The final producer supplies them internally. This is not a seal, a manifest-bound source-node promotion, or Wigner theorem completion.

Root `wigner_exists_unitary_or_antiunitary_v1`, `GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean`, export `GraduateQM.Wigner.exists_unitary_or_antiunitary`, remains DRAFT_SORRY / FROZEN_UNPROVED. Its expected provider is `GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary`; no new module imports either. Guard verifies approved prefix/suffix and ABI snapshot. Root proof/axiom closure is deliberately NOT claimed.

DECLARATION_FIDELITY: PASS (unchanged approved exact root, independently reread)
DRAFT_ALLOWLIST: PASS (guard)
PROOF_STATUS: FROZEN_UNPROVED

## Source-first reconstruction

Before inspecting new implementation, read pinned primary PDF Simon et al. arXiv:0808.0779v2, printed p2 II2.1–2.4,2.8–2.14 and printed p3 III3.1–3.6, plus PROOF_SOURCE normalized_correspondence L18–20, orthonormal_basis L38–40, image_basis L42–44, basis_normalization L46–48, coordinate_magnitudes L50–52. PDF hash `59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228`, bytes172646, and transcription hash `8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632` match source-lock. No previous helper audit verdict was used as evidence.

Expected mathematics: choose a finite ON basis internally; independently choose unit representatives of its image rays; probability zero implies their orthogonality; cardinal equals dimension makes the family complete. Construct one actual complex-linear isometric equivalence sending that image basis back to the original. Postcompose its ray action with f; retain bijection and exact all-representative normalized probability, fix basis rays, and test arbitrary unit input/output representatives against each basis ray. Nonnegative coordinate norms are equal, so zeros and supports coincide. The basis/unitary witnesses precede all state quantifiers. No coherent phases, arbitrary-state lift, continuity, full support, or positive dimension is assumed. Unit representatives correspond to phase classes; normalized Born probability agrees with the unit-vector source convention.

## Semantic closure and definitions

The five new modules export only 14 theorems, no new public semantic definitions or Prop packages. Types use Mathlib Projectivization, OrthonormalBasis, LinearIsometryEquiv, and literal inline probability. Projectivization is nonzero scalar-orbit rays; no zero/default probability on rays is created. `probability_unitary` is a raw algebraic identity also true for zero vectors under field division; it does not extend the ray carrier.

Mathlib ONBasis is a coordinate isometry and its repr coefficients equal inner products `⟪b i,x⟫` (PiL2.repr_apply_apply); `b.toBasis` certifies completeness. `c.equiv b (Equiv.refl _)` is an actual linear isometric equivalence, mapping c i to b i by equiv_apply_basis. All internal choices are existential proof witnesses, not a newly exported choice-defined semantic object. Definition audit: BODY_MATCH/PUBLIC_CARRIER/WELL_DEFINEDNESS/CHARACTERIZATION/CHOICE_INDEPENDENCE = N/A (no new definitions); DEFINITION_VERDICT = N/A.

ImageBasis handles empty index without a nonempty hypothesis, then the nonempty branch uses `basisOfOrthonormalOfCardEqFinrank` and `Module.finrank_eq_card_basis`. No finite-dimensional instance is required in its declaration because a finite basis already carries finite dimension. Combined Step1 uses standard ON basis on Fin(finrank), including dimension0 and dimension1. Orthogonality and representative equality are proved before constructing image basis; independent phase choices are allowed.

## Binder audit convention

Tables enumerate direct explicit, implicit, and instance binders, expanding the inline h_probability quantified premise into its nested binders as well. There are no project-owned assumption aliases, gates, structures, or typeclasses to expand. SOURCE references are the particular helper's source claim unless marked EXCESS relative to the combined Step1 boundary. No standing-assumption boundary exists: STANDING=0 throughout. In particular finite dimensionality is SOURCE, not STANDING. NormedAddCommGroup and InnerProductSpace implement the source's Hilbert-space typing; their standard Mathlib fields are not project-owned proof assumptions. h_bijective is the conjunction of injectivity and surjectivity in II2.8, not an added witness. EXCESS rows in conditional helpers prohibit treating those helpers themselves as a full Step1 theorem; they are discharged in the final producer and not reclassified by producer existence. Unit-operator U in the separate action lemmas is the explicit operator under discussion in II2.11, not an asserted lift of f.

The second universal group in probability_preserving_unitary_postcomp is the conclusion, not additional input assumptions on f. Likewise final output unit-state/coordinate quantifiers are conclusions beneath the existential b,U, not outer premises.

### `exists_unit_representative`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| p | explicit | TYPING | II2.2 ray carrier |

Counts: SOURCE=0, STANDING=0, TYPING=4, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `probability_eq_of_mk_eq`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| x | explicit | TYPING | II 2.1 carrier |
| y | explicit | TYPING | II 2.1 carrier |
| x' | explicit | TYPING | II 2.1 carrier |
| y' | explicit | TYPING | II 2.1 carrier |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hxx′ | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |
| hyy′ | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |

Counts: SOURCE=6, STANDING=0, TYPING=7, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `mk_eq_mk_iff_exists_unit_phase`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| x | explicit | TYPING | II 2.1 carrier |
| y | explicit | TYPING | II 2.1 carrier |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hnormx | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |
| hnormy | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |

Counts: SOURCE=4, STANDING=0, TYPING=5, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `probability_eq_norm_inner_sq`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| x | explicit | TYPING | II 2.1 carrier |
| y | explicit | TYPING | II 2.1 carrier |
| hx | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |
| hy | explicit | SOURCE | II 2.1-2.4; PROOF_SOURCE L18-20 |

Counts: SOURCE=2, STANDING=0, TYPING=5, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `projectivization_map_symm_apply`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| U | explicit | SOURCE | II 2.11; conditional unitary-action lemma, not Wigner input |
| p | explicit | TYPING | II2.11 ray carrier |

Counts: SOURCE=1, STANDING=0, TYPING=4, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `projectivization_map_bijective`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| U | explicit | SOURCE | II 2.11; conditional unitary-action lemma, not Wigner input |

Counts: SOURCE=1, STANDING=0, TYPING=3, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `probability_unitary`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| U | explicit | SOURCE | II 2.11; conditional unitary-action lemma, not Wigner input |
| x | explicit | TYPING | II 2.1 carrier |
| y | explicit | TYPING | II 2.1 carrier |

Counts: SOURCE=1, STANDING=0, TYPING=5, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `probability_preserving_unitary_postcomp`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| U | explicit | SOURCE | II 2.11; conditional unitary-action lemma, not Wigner input |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |

Counts: SOURCE=8, STANDING=0, TYPING=8, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `exists_image_orthonormalBasis`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| ι | implicit | TYPING | III Step1 finite basis indexing |
| Fintype ι | instance | TYPING | III Step1 finite basis indexing |
| b | explicit | EXCESS | III3.2 internal basis choice; discharged by stdOrthonormalBasis in combined producer |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |

Counts: SOURCE=7, STANDING=0, TYPING=10, RULED=0, EXCESS=1.
CONDITIONAL; not eligible alone for source closure.

### `exists_basis_unitary_normalization`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| FiniteDimensional ℂ E | instance | SOURCE | Approved finite-dimensional specialization; PROOF_SOURCE conventions |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_bijective | explicit | SOURCE | II2.8 one-to-one onto |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |

Counts: SOURCE=9, STANDING=0, TYPING=8, RULED=0, EXCESS=0.
No excess input at this stated boundary.

### `coordinate_norm_sq_eq_of_fixed_basis`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| ι | implicit | TYPING | III Step1 finite basis indexing |
| Fintype ι | instance | TYPING | III Step1 finite basis indexing |
| b | explicit | EXCESS | III3.2 internal basis choice; discharged by stdOrthonormalBasis in combined producer |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_basis | explicit | EXCESS | III3.5 intermediate result; combined producer proves it |
| h_basis.i | explicit | TYPING | III3.5 universal basis index |
| x | implicit | TYPING | III3.6 arbitrary unit input |
| y | implicit | TYPING | III3.6 arbitrary unit output |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hx_unit | explicit | SOURCE | III3.1 and 3.6 unit state |
| hy_unit | explicit | SOURCE | III3.1 and 3.6 unit output representative |
| h_image | explicit | SOURCE | III3.1 and 3.6 output ray |
| i | explicit | TYPING | III3.6 arbitrary coordinate |

Counts: SOURCE=12, STANDING=0, TYPING=14, RULED=0, EXCESS=2.
CONDITIONAL; not eligible alone for source closure.

### `coordinate_norm_eq_of_fixed_basis`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| ι | implicit | TYPING | III Step1 finite basis indexing |
| Fintype ι | instance | TYPING | III Step1 finite basis indexing |
| b | explicit | EXCESS | III3.2 internal basis choice; discharged by stdOrthonormalBasis in combined producer |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_basis | explicit | EXCESS | III3.5 intermediate result; combined producer proves it |
| h_basis.i | explicit | TYPING | III3.5 universal basis index |
| x | implicit | TYPING | III3.6 arbitrary unit input |
| y | implicit | TYPING | III3.6 arbitrary unit output |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hx_unit | explicit | SOURCE | III3.1 and 3.6 unit state |
| hy_unit | explicit | SOURCE | III3.1 and 3.6 unit output representative |
| h_image | explicit | SOURCE | III3.1 and 3.6 output ray |
| i | explicit | TYPING | III3.6 arbitrary coordinate |

Counts: SOURCE=12, STANDING=0, TYPING=14, RULED=0, EXCESS=2.
CONDITIONAL; not eligible alone for source closure.

### `coordinate_eq_zero_iff_of_fixed_basis`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| ι | implicit | TYPING | III Step1 finite basis indexing |
| Fintype ι | instance | TYPING | III Step1 finite basis indexing |
| b | explicit | EXCESS | III3.2 internal basis choice; discharged by stdOrthonormalBasis in combined producer |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_basis | explicit | EXCESS | III3.5 intermediate result; combined producer proves it |
| h_basis.i | explicit | TYPING | III3.5 universal basis index |
| x | implicit | TYPING | III3.6 arbitrary unit input |
| y | implicit | TYPING | III3.6 arbitrary unit output |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hx_unit | explicit | SOURCE | III3.1 and 3.6 unit state |
| hy_unit | explicit | SOURCE | III3.1 and 3.6 unit output representative |
| h_image | explicit | SOURCE | III3.1 and 3.6 output ray |
| i | explicit | TYPING | III3.6 arbitrary coordinate |

Counts: SOURCE=12, STANDING=0, TYPING=14, RULED=0, EXCESS=2.
CONDITIONAL; not eligible alone for source closure.

### `coordinate_support_eq_of_fixed_basis`

| Binder | Form | Bin | Source or discharge |
|---|---|---|---|
| E | implicit type | TYPING | II 2.1 complex Hilbert carrier |
| NormedAddCommGroup E | instance | TYPING | II 2.1 normed additive carrier |
| InnerProductSpace ℂ E | instance | TYPING | II 2.1 complex inner product |
| ι | implicit | TYPING | III Step1 finite basis indexing |
| Fintype ι | instance | TYPING | III Step1 finite basis indexing |
| b | explicit | EXCESS | III3.2 internal basis choice; discharged by stdOrthonormalBasis in combined producer |
| f | explicit | TYPING | II 2.8 ray self-map |
| h_probability | explicit | SOURCE | II 2.8; approved all-representative statement |
| h_probability.x | explicit | TYPING | II 2.1 carrier |
| h_probability.y | explicit | TYPING | II 2.1 carrier |
| h_probability.x' | explicit | TYPING | II 2.1 carrier |
| h_probability.y' | explicit | TYPING | II 2.1 carrier |
| h_probability.hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hx' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.hy' | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| h_probability.image_x | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_probability.image_y | anonymous arrow | SOURCE | II 2.8 representative equality |
| h_basis | explicit | EXCESS | III3.5 intermediate result; combined producer proves it |
| h_basis.i | explicit | TYPING | III3.5 universal basis index |
| x | implicit | TYPING | III3.6 arbitrary unit input |
| y | implicit | TYPING | III3.6 arbitrary unit output |
| hx | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hy | explicit | SOURCE | II 2.2-2.4 nonzero representative convention |
| hx_unit | explicit | SOURCE | III3.1 and 3.6 unit state |
| hy_unit | explicit | SOURCE | III3.1 and 3.6 unit output representative |
| h_image | explicit | SOURCE | III3.1 and 3.6 output ray |

Counts: SOURCE=12, STANDING=0, TYPING=13, RULED=0, EXCESS=2.
CONDITIONAL; not eligible alone for source closure.

## Witness and output audit

Combined order is E / carrier instances / finite dimensionality / f / bijection / exact h_probability, then ∃ b ∃ U, let g=map(U)∘f, followed by bijection, full probability, fixed basis, and ∀ x,y,hx,hy,unit norms,ray relation. Thus U depends on f and its original data, never on a later state. The output basis spans the complete original E. U is E≃ₗᵢ[ℂ]E, not merely an arbitrary endomorphism. Magnitudes concern every coordinate and all unit representatives, not an existential favorable output, and zeros are biconditional. Support uses repr with proved inner-product coordinate convention. Dimension0 state conclusions are vacuous; dimension1 needs no exclusion.

## Proof dependencies and consumption

Freshly inspected RayProbability.lean rather than relying on its prior audit: scalar invariance cancels the positive nonzero scalar norm factors; probability-zero equivalence cancels nonzero vector norms; image orthogonality applies the original h_probability and both zero equivalences. UnitRepresentatives consumes scalar invariance for representative independence, and normalization arithmetic for existence and phase relation. RayIsometries consumes representative independence, actual U.inner_map_map/U.norm_map, quotient representatives, and inverse action; no vector lift hypothesis. ImageBasis consumes unit representative existence and image_inner_eq_zero, then ordinary finite-dimensional cardinal completeness. CoordinateMagnitudes consumes the literal all-representative premise against b i,x,b i,y, simplifies unit norms, removes squares by nonnegativity, and converts zero norm to zero and repr to inner products. Combined producer consumes every constructed ingredient and applies all four coordinate exports to the produced g,h_prob,h_basis.

Allowed external mathematics is ordinary quotient/projective linear action, complex norm arithmetic, finite basis existence/completeness and ON-basis equivalence. No Wigner theorem, semilinear reconstruction theorem, or source black box is imported or used. No Parseval theorem is needed explicitly here.

## Independent validation

`./scripts/lake env lean .state/wigner-step1-audit.lean > .state/wigner-step1-audit.log 2>&1` final run exit0, no errors or warnings. The audit probe supplies separately stated exact-type examples for all14 exports (final full proposition with renamed binders), #check @export and #print axioms for all14. It also proves a producer-consumer example starting with only f,hbij,hprob: extracts one b,U; for every ray p obtains unit u representing p and unit v representing g p; applies the produced all-state conclusion and separately invokes the conditional support lemma using produced hprob/hfix. This demonstrates actual inhabitation and consumption, including arbitrary rays and sparse states, not mere name reachability.

Each exact axiom list was individually inspected in the final log; all14 are exactly `[propext, Classical.choice, Quot.sound]`. No sorryAx/custom axiom. `python3 scripts/check_infrastructure.py` exit0 after final Step1 inspection: FROZEN-ANCHOR GUARD OK; 11 modules,12 pinned skills. Text scan finds only registered frozen `by sorry`; "admits" in prose is not admit. Builds never exceeded the one auditor slot allocation. No tracked files, dependency pins, or caches were edited by auditor. The exact scratch probe source and its pre-deletion SHA256 are appended to the audit log between reproducibility markers. The transient .lean probe was then deleted as required by lean-statement-audit; no Lean rerun or audited-code change occurred during this housekeeping.

## Exact file hashes at audit

- `GraduateQM/Wigner/UnitRepresentatives.lean`: `49ce5827b2d2b67fbaedfa8c6826e8e118250d34fe1ed8042203d61fb2266ef5`
- `GraduateQM/Wigner/RayIsometries.lean`: `3b7a7b354b7713d30b59137c8b592f0f1a229d2ef478b854a40fa3b4c2952a54`
- `GraduateQM/Wigner/CoordinateMagnitudes.lean`: `b2bdd6ad7ea93184a6ecf1c2814fffd3cdd32bfeae2fe052de7e81b84d1a1861`
- `GraduateQM/Wigner/ImageBasis.lean`: `61c90a5ea23c58d59e09c5c49a134c5809b637ad6ab1bdfb9c955851e3717836`
- `GraduateQM/Wigner/BasisNormalization.lean`: `321a211b9cc0407d347149aaa083ca4f0a2c89a2df1e53bc359c009e793a1dd0`
- `GraduateQM/Wigner/RayProbability.lean`: `2fe5606c3235600c43dcfbbbe3026344e1948113c54c2127d8a2f9c692f7e14a`
- `GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean`: `857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902`
- `docs/wigner/frozen-anchors.json`: `ec4ac72d880a5b7c560df00fcda1695165a2a792988e3ac86bddce6351ba1deb`
- `.state/wigner-step1-audit.lean` (deleted after recording; exact source archived in log): `3a2c70047ba7764c5bacddbe38224ad3e4d0f1335027cda139b0c4741b3d87ff`
- `.state/wigner-step1-audit.log`: `74dcda0eecacd6a35ccbc8d2d4be78eba1a08d02e248c386c48c53724bd7b372`

## Limitations and handoff

This checks internal Step1 implementation, not root/source-node sealing. Remaining Wigner obligations include pair-circle classification, diagonal phase normalization, all-pair products, triple sign consistency, one global branch, sparse-state reconstruction, antiunitary construction, and denormalization. Root still has its registered hole. No publication or commit performed. No standalone public definition was added.

DRAFT_ANCHORS: 1 — GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean
UNREGISTERED_SORRIES: 0 — guard and project scan
DRAFT_IMPORT_VIOLATIONS: 0 — guard
SEALED_THIS_TURN: 0 — no exports sealed
