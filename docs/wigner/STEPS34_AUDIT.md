# Independent Wigner Steps 3–4 and coordinate-product audit

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Historical milestone snapshot. Current sealed-theorem status and closure evidence
are in [FINAL_AUDIT.md](FINAL_AUDIT.md); the original findings below are retained.

Reviewer: independent `wigner_offsets_audit`. Final integrated packet: seven modules, eleven exports.

## Identity and source-first reconstruction

Auditor read repository workflow and statement-audit skill, then source lock, anchor manifest, frozen declaration, transcription and raw pinned PDF before inspecting implementation. Local PDF verified SHA256 `59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228`; transcription verified `8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632`. PDF was extracted with bundled pypdf (ambient pdftotext and pymupdf unavailable). Source III (3.12)-(3.24), printed pp.3-4, and transcription L58-68 govern this packet; L78-80 supplies reconstruction context only.

Independent reconstruction: after basis normalization, fix a reference index r. Each (r,k) circle has one unit offset and one orientation valid for every circle parameter. Choose one diagonal unitary with reference phase 1 and kth phase the inverse offset. This single operator precedes all pairs/states. Construct one positive real full-support unit vector internally. Reference-pair probability tests yield its coordinate products; their reference row reconstructs its ray, so this test ray is fixed. On each arbitrary pair, either circle orientation applied to this fixed real test gives s=conj(a)s for nonzero real s; cancel s to obtain a=1. Finally pair probes determine Re/Im of arbitrary-state coordinate products; no state coordinate is divided by. Pair orientations may still differ. Global sign coherence and final sparse reconstruction remain unproved here.

Root: `wigner_exists_unitary_or_antiunitary_v1`, `GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean`, export `GraduateQM.Wigner.exists_unitary_or_antiunitary`, manifest `DRAFT_SORRY`. Whole-file hash before audit `857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902`. No root promotion or source-graph closure claim.

## Stable helper findings

All five files below were declared stable before inspection. No new public definitions. Private PairProducts helpers expand norm squares, recover complex equality from probes 1 and i, cancel only a unit-circle scalar, and derive probability cross terms using coordinate magnitudes. ReferenceNormalization chooses witness offsets existentially on {k | r≠k}; these choices implement an existential unitary, not a purported unique public characterized definition. There is no choice-independence requirement for its existential output. The piecewise reference coefficient equals 1 at r and the proved inverse offset elsewhere, precisely the source construction, not an off-domain fallback. FullSupportVector constructs and normalizes the all-ones coordinate vector, proving nonzero from a supplied nonempty index type. RayReconstruction divides only by the proved nonzero output reference coordinate for this particular x, not by a globally fixed coordinate for arbitrary states.

## Binder tables (relative to full source closure)

These are conditional helpers, not exact frozen source exports. EXCESS records genuine produced prerequisites relative to the entire source claim; it is not waived by having a producer. Each consumer must discharge them. STANDING=0 and RULED=0 throughout helper tables. Inner binders of the probability premise are expanded separately below. Pure value arguments specifying the conditional algebraic object are TYPING unless they import a proof construction.

### exists_diagonal_unitary

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | chosen orthonormal basis; internal source construction III Step 1 |
| d | TYPING | specified unit-circle coefficients III (3.12) |

Counts: SOURCE=0, STANDING=0, TYPING=6, RULED=0, EXCESS=1. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### diagonal_unitary_apply

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | internally chosen basis |
| d | TYPING | specified phases |
| D | TYPING | specified unitary |
| hD (∀ i) | EXCESS | diagonal action must be produced |
| x | TYPING | arbitrary vector |

Counts: SOURCE=0, STANDING=0, TYPING=8, RULED=0, EXCESS=2. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### diagonal_unitary_map_basis_ray

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | internally chosen basis |
| d | TYPING | specified phases |
| D | TYPING | specified unitary |
| hD (∀ i) | EXCESS | diagonal action must be produced |
| i | TYPING | basis index |

Counts: SOURCE=0, STANDING=0, TYPING=8, RULED=0, EXCESS=2. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### exists_positive_unit_vector

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| Nonempty ι | EXCESS | source test exists only after nonempty dimension case |
| b | EXCESS | internally chosen basis |

Counts: SOURCE=0, STANDING=0, TYPING=5, RULED=0, EXCESS=2. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### exists_reference_unitary_normalization

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | internally chosen basis |
| f | SOURCE | ray transformation II (2.8) |
| h_bijective | SOURCE | WS bijective |
| h_probability | SOURCE | SC II (2.10), fully expanded below |
| h_basis (∀ i) | EXCESS | output of basis normalization III (3.5) |
| r | EXCESS | internally selected reference index III (3.15) |

Counts: SOURCE=3, STANDING=0, TYPING=5, RULED=0, EXCESS=3. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### coordinate_product_of_pair_rotation / coordinate_product_of_pair_reflection (same binder table independently checked for each)

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | internally chosen basis |
| f | SOURCE | ray transformation |
| h_probability | SOURCE | SC, expanded below |
| h_basis (∀ i) | EXCESS | basis normalization output |
| j | TYPING | pair index |
| k | TYPING | pair index |
| hjk | TYPING | distinct-pair domain |
| x | TYPING | arbitrary input state representative |
| y | TYPING | arbitrary output representative |
| hx | TYPING | nonzero ray domain |
| hy | TYPING | nonzero ray domain |
| hx_unit | TYPING | unit input convention III (3.23) |
| hy_unit | TYPING | unit output convention III (3.23) |
| h_image | TYPING | representative of f[x] |
| a | TYPING | specified circle offset |
| h_action (∀ z : Circle) | EXCESS | circle classification / zero-offset theorem must produce this |

Counts: SOURCE=2, STANDING=0, TYPING=16, RULED=0, EXCESS=3. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### mk_eq_of_reference_products

| Binder | Bin | Source/role |
|---|---|---|
| ι | TYPING | finite coordinate index carrier |
| E | TYPING | complex inner-product carrier |
| Fintype ι | TYPING | finite-dimensional coordinate notation |
| NormedAddCommGroup E | TYPING | normed vector carrier |
| InnerProductSpace ℂ E | TYPING | complex inner product convention |
| b | EXCESS | internally chosen basis |
| x | TYPING | nonzero vector |
| y | TYPING | nonzero vector |
| hx | TYPING | ray domain |
| hy | TYPING | ray domain |
| r | EXCESS | per-vector reference coordinate must be selected |
| hxr | EXCESS | reference coordinate nonzero must be proved |
| h_products (∀ i) | EXCESS | reference row products must be proved |

Counts: SOURCE=0, STANDING=0, TYPING=9, RULED=0, EXCESS=4. Internal helper status CONDITIONAL, full-source closure FAIL (unconsumed prerequisites at this boundary).

### Recursive probability-premise binders

For every probability premise above, no project Prop alias/structure is hidden. Its complete argument is literally universal normalized transition-probability preservation:

| Binder | Bin | Role |
|---|---|---|
| x | TYPING | arbitrary source representative |
| y | TYPING | arbitrary source representative |
| x' | TYPING | arbitrary image representative |
| y' | TYPING | arbitrary image representative |
| hx | TYPING | x nonzero |
| hy | TYPING | y nonzero |
| hx' | TYPING | x' nonzero |
| hy' | TYPING | y' nonzero |
| first ray-image equality | TYPING | x' represents f[x] |
| second ray-image equality | TYPING | y' represents f[y] |

Expansion counts SOURCE=0, STANDING=0, TYPING=10, RULED=0, EXCESS=0. The quantified conclusion is the SOURCE equality itself. OrthonormalBasis is a proof-bearing witness (linear isometric coordinate equivalence); classifying b as EXCESS explicitly accounts for basis existence, spanning, orthogonality and normalization rather than concealing these as standing assumptions. D is an actual linear isometric equivalence, never a generic operator promised to become unitary later.

## Initial validation history

`.state/wigner-offsets-audit.log` preserves exact initial probe text, complete elaborated types and axiom output. All eight stable public exports have exactly `[propext, Classical.choice, Quot.sound]`, no sorryAx or custom axiom. Independently written exact-type examples for diagonal-unitary existence, positive test-vector existence and reference-product reconstruction compile. Command `./scripts/lake env lean .state/wigner-offsets-audit.lean` exited 0. Initial direct `./scripts/lean` invocation failed only because it lacked Lake's project search path; this failure remains in the log. No dependency artifacts changed or cleared.

At this initial checkpoint PhaseOffsets and the original-input assembly were awaiting stable notices. The final audit below supersedes that temporary limitation. The root remains FROZEN_UNPROVED.

## Audited helper hashes

- `GraduateQM/Wigner/DiagonalUnitary.lean`: `cccac6affb2124fac4484e7ac5b15c99d8f37864627766b57c6c20d6ed882e8f`
- `GraduateQM/Wigner/FullSupportVector.lean`: `d04f7321485cd91ca09f63cb8186d2eb2a04785a61d55b56d76ee1ecce7ead2c`
- `GraduateQM/Wigner/ReferenceNormalization.lean`: `6cd5a21beeae50079680c030f16f810c30b71df0bc9e9cff1a6c37f03341ada2`
- `GraduateQM/Wigner/PairProducts.lean`: `fa30ec3576879e7a43c04ccb6bcca5e668ce57cb689a6e376a9db32204f5face`
- `GraduateQM/Wigner/RayReconstruction.lean`: `74f448eb47fe00821c3cb96a784b94bb46bd8ef965274cc113abc0bf56a7951a`

## Final stable packet and consumer audit

PhaseOffsets and ZeroOffsetNormalization were inspected only after the lead's explicit STABLE notice. `pair_action_without_offsets` constructs t inside the proof, proves all coordinates positive real, obtains a unit image representative y, proves the full reference row including the diagonal entry from coordinate magnitude equality, and consumes `mk_eq_of_reference_products` to prove f[t]=[t]. Each pair's original circle offset is then cancelled against the nonzero product of t's real coordinates. The same t precedes all pair choices. `exists_zero_offset_unitary_normalization` consumes the reference-unitary producer and feeds every output into this proof.

`exists_basis_zero_offset_normalization` consumes the prior original-input basis-normalization producer. In rank zero it eliminates the empty Fin index; no dummy reference index is invented. In positive rank it selects Fin index zero internally and consumes the conditional offset-normalization result. Rank one is naturally included with no distinct pairs. The combined operator is U.trans D, and quotient induction checks that its ray action is the nested postcomposition. Thus there is one actual U and one b outside every pair and every state. No global orientation conclusion is asserted.

### pair_action_without_offsets

| Binder | Bin | Source/role |
|---|---|---|
| E | TYPING | complex vector carrier |
| ι | TYPING | coordinate carrier |
| NormedAddCommGroup E | TYPING | normed carrier |
| InnerProductSpace ℂ E | TYPING | inner product convention |
| Fintype ι | TYPING | finite coordinates |
| b | EXCESS | basis construction must be supplied |
| f | SOURCE | ray symmetry |
| h_probability | SOURCE | SC; ten internal binders expanded above |
| h_basis | EXCESS | basis normalization conclusion |
| r | EXCESS | reference coordinate chosen internally at consumer |
| h_reference | EXCESS | zero-offset reference-circle result, all k≠r, one branch for all z |

Counts SOURCE=2, STANDING=0, TYPING=5, RULED=0, EXCESS=4. CONDITIONAL, not full-source closure at this helper boundary. In h_basis, i is a TYPING coordinate; in h_reference, k and hrk are TYPING pair-domain binders and z is a TYPING Circle parameter in each branch; no hidden premise.

### exists_zero_offset_unitary_normalization

| Binder | Bin | Source/role |
|---|---|---|
| E | TYPING | complex vector carrier |
| ι | TYPING | coordinate carrier |
| NormedAddCommGroup E | TYPING | normed carrier |
| InnerProductSpace ℂ E | TYPING | inner product convention |
| Fintype ι | TYPING | finite coordinates |
| b | EXCESS | basis construction supplied by consumer |
| f | SOURCE | ray symmetry |
| h_probability | SOURCE | SC; ten internal binders expanded above |
| h_basis | EXCESS | basis normalization conclusion |
| h_bijective | SOURCE | original bijectivity retained under postcomposition |
| r | EXCESS | internal reference coordinate |

Counts SOURCE=3, STANDING=0, TYPING=5, RULED=0, EXCESS=3. CONDITIONAL. Both this theorem's basis/index premises and its normalized-map premises are actually discharged in the final assembly.

### exists_basis_zero_offset_normalization

| Binder | Bin | Source/role |
|---|---|---|
| E | TYPING | approved finite complex inner-product carrier |
| NormedAddCommGroup E | TYPING | carrier |
| InnerProductSpace ℂ E | TYPING | source inner-product convention |
| FiniteDimensional ℂ E | SOURCE | author-approved finite-dimensional specialization |
| f | SOURCE | ray transformation II (2.8) |
| h_bijective | SOURCE | bijective ray transformation II (2.8) |
| h_probability | SOURCE | II (2.10), exact all-representative premise, expanded above |

Counts SOURCE=4, STANDING=0, TYPING=3, RULED=0, EXCESS=0. Its conclusion is the bounded III Step 3-4 normalization result, not the full Wigner root. FiniteDimensional is standard Mathlib finite-dimensionality, not a project bundle. Its b,U are existential outputs. No standing assumption structure or project-owned Prop alias exists in the types. The approved zero-dimensional convention is respected by empty pair quantification.

## Final independent validation and verdict

- `./scripts/lake build GraduateQM.Wigner.ZeroOffsetNormalization`: exit 0, warning-free, covering all seven packet modules.
- `./scripts/lake env lean .state/wigner-offsets-audit.lean`: final exact-type and producer-to-consumer probe exit 0, warning-free. The probe obtains b,U and all retained premises from original f/h_bijective/h_probability, then case-splits each produced pair action and consumes rotation/reflection product lemmas at a=1. Its derived statement quantifies all x,y and nonzero/unit/image conditions *inside* a single pair branch; no coordinate support assumption. This checks arbitrary-state consumption, including sparse vectors.
- All eleven public exports: precisely propext, Classical.choice, Quot.sound. Private helper closure is included transitively; no custom axiom or sorryAx.
- `python3 scripts/check_infrastructure.py`: exit 0, FROZEN-ANCHOR GUARD OK, configuration passed (22 modules, 12 pinned skills at this snapshot).
- Exact probes archived verbatim in `.state/wigner-offsets-audit.log`, then `.state/wigner-offsets-audit.lean` deleted.
- No tracked files edited by auditor. Prior dirty/untracked project work preserved.

BOUNDARY_VERDICT: PASS for the eleven claimed bounded exports and the final original-input normalization assembly; ten helper exports retain explicit conditional/algebraic contexts at their own interfaces, and one final assembly has zero EXCESS. Source graph and root are not promoted. No source-facing frozen theorem was sealed. Triple consistency, global branch, conjugation implementation, full sparse reconstruction, and denormalization remain outside this audit.

DECLARATION_FIDELITY: root unchanged; existing author-approved target retained (no fresh root-source review claimed).
DRAFT_ALLOWLIST: PASS via guard.
PROOF_STATUS: FROZEN_UNPROVED.
DRAFT_ANCHORS: 1 — GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean
UNREGISTERED_SORRIES: 0
DRAFT_IMPORT_VIOLATIONS: 0
SEALED_THIS_TURN: 0

### Final additional hashes

- `GraduateQM/Wigner/PhaseOffsets.lean`: `41b57f798a8614a117bf8e58d0d08f917ba532cf7633d5ba758ab86813b14498`
- `GraduateQM/Wigner/ZeroOffsetNormalization.lean`: `9e4658180061211f9fef7a50cf8afe32a652aaefd4030fbc2cd7beed4518ff3d`
- Root after audit: `857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902` (identical).
