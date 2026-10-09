# Independent Wigner pair-circle audit — 2026-10-09

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Historical milestone snapshot. Current sealed-theorem status and closure evidence
are in [FINAL_AUDIT.md](FINAL_AUDIT.md); the original findings below are retained.

Reviewer: `wigner-pair-audit`, independent of the proof workers and integrating lead.

Status: PASS for the bounded Step2 pair-circle milestone and its Step1 consumption. No source graph/root promotion.

## Source-first reconstruction and identity

Read pinned primary PDF arXiv:0808.0779v2 II (2.1)–(2.10), III (3.5)–(3.11) before implementation, using bundled pypdf. PDF SHA256 59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228 and PROOF_SOURCE SHA256 8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632 match source-lock. Source transcription L54–56 fixes latitude theta=pi/2, sufficient for later tests.

Independently reconstructed obligation: for a probability-preserving ray map normalized to fix basis rays, each distinct coordinate pair has a uniquely induced Circle map. Zeros outside that pair must remain zero. Fixing first coordinate to 1 removes projective phase; the representative b_j+z b_k has norm squared 2. Its probability with b_j+w b_k is (1+Re(conj(z)w))/2. Consequently the induced map preserves real Hermitian overlap. There exists ONE offset a in Circle and ONE global choice (forall z, F z=a*z) OR (forall z, F z=a*conj z). No continuity, bijectivity, lift, or input-dependent choice may be presumed. Pair indices need only be distinct, a harmless strengthening of source j<k.

Manifest root wigner_exists_unitary_or_antiunitary_v1 remains DRAFT_SORRY, GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean, GraduateQM.Wigner.exists_unitary_or_antiunitary. These are internal proof helpers, not newly frozen exports or a root theorem audit.

## Expanded binder tables for stable helpers

SOURCE below means premise of the stated elementary helper or abstract rigidity lemma, not an extra allowed root premise. Basis is the produced Step1 object; the map/overlap premise of abstract rigidity must be consumed by the actual producer. No helper table alone closes pair_circle.

### GraduateQM.Wigner.inner_pair_left

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : ℂ | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=8, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.inner_pair_right

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : ℂ | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=8, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.pair_ne_zero

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : ℂ | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=8, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.pair_norm_sq

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : Circle | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=8, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.inner_pair_pair

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : ℂ | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |
| w : ℂ | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=9, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.pair_probability

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : Circle | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |
| w : Circle | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=9, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.pair_mk_eq_iff

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1), Hilbert carrier |
| ι : Type* | TYPING | II (2.5), basis index carrier |
| [NormedAddCommGroup E] | TYPING | II (2.1), normed vector carrier |
| [InnerProductSpace ℂ E] | TYPING | II inner-product convention; conjugate-linear first slot |
| [Fintype ι] | TYPING | Approved finite-dimensional specialization |
| b : OrthonormalBasis ι ℂ E | SOURCE | II (2.5); III Step1 produced orthonormal basis, includes complete orthonormal coordinates |
| j : ι (implicit) | TYPING | III pair indices |
| k : ι (implicit) | TYPING | III pair indices |
| hjk : j ≠ k | SOURCE | III (3.7); distinct pair |
| z : Circle | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |
| w : Circle | TYPING | III (3.7)–(3.8); complex coordinate or unit phase |

Counts: SOURCE=2, STANDING=0, TYPING=9, RULED=0, EXCESS=0. Conditional helper fidelity: PASS.

### GraduateQM.Wigner.exists_circle_mul_or_mul_inv_of_preserving_re

| Expanded binder | Bin | Source/convention |
|---|---|---|
| F : Circle → Circle | TYPING | III (3.7), abstract circle action |
| h : forall z w, Re(conj(F z)*F w)=Re(conj z*w) | SOURCE | III (3.9), input to classification sublemma; must be produced from SC |
| z : Circle (inside h) | TYPING | III (3.9), all first circle inputs |
| w : Circle (inside h) | TYPING | III (3.9), all second circle inputs |

Counts: SOURCE=1, STANDING=0, TYPING=3, RULED=0, EXCESS=0. Abstract helper fidelity: PASS. Offset existential encloses disjunction; each branch encloses forall z. No pointwise branch choice.

## Semantic closure and proof inspection

Circle is Mathlib Submonoid.unitSphere ℂ (Analysis/Complex/Circle.lean L54), with coe_inv_eq_conj L85; no custom circle wrapper or invented domain. Projectivization is Mathlib nonzero-vector projectivization. pair_ne_zero is a proved proof argument only. All coordinates and denominators are explicit.

Seven geometry proofs compute left/right inner coordinates 1,z; nonzero follows from the first. Norm squared is 2 by orthogonality/unit Circle norm. Relative inner product is 1+conj(z)w; norm-square algebra gives the denominator-4 probability identity. Ray equality yields a scalar, whose first coordinate forces scalar=1, then second coordinate forces z=w. Thus projective uniqueness is genuine.

Rigidity private helper circle_star_mul_left proves phase multiplication cancels in Hermitian product using unit modulus. Private circle_eq_self_or_inv_of_preserving_re_one derives all real parts from testing 1; image of i has zero real part and imaginary part ±1; this single sign is selected before arbitrary z, whose imaginary coordinate is fixed by testing i. Public proof normalizes G=(F 1)^(-1)*F, proves its overlap premise and G 1=1, then undoes normalization. No Wigner black box or hidden continuity/bijectivity used.

## Validation

Initial ./scripts/lean invocation lacked Lake search paths and failed unknown module prefix; no mathematical error. Correct invocation ./scripts/lake env ./scripts/lean .state/wigner-pair-audit.lean exited 0 for independently written exact-type applications of all eight exports. ./scripts/lake build GraduateQM.Wigner.PairGeometry GraduateQM.Wigner.CircleRigidity exited 0. All eight #print axioms outputs contain only propext, Classical.choice, Quot.sound; no sorryAx/custom axioms. Exact probe is archived in .state/wigner-pair-audit.log and the transient Lean file was deleted after successful final combined validation.

DRAFT_ANCHORS: 1 — GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean (unchanged registered root)
UNREGISTERED_SORRIES: 0 (infrastructure guard passed)
DRAFT_IMPORT_VIOLATIONS: 0 (infrastructure guard passed)
SEALED_THIS_TURN: 0

## Final stable producer and consumer audit

### GraduateQM.Wigner.exists_unique_pair_circle_image

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1) |
| [NormedAddCommGroup E] | TYPING | Hilbert carrier |
| [InnerProductSpace ℂ E] | TYPING | Complex Hilbert carrier |
| ι : Type* | TYPING | finite index carrier |
| [Fintype ι] | TYPING | finite index carrier |
| b : OrthonormalBasis ι ℂ E | SOURCE | III Step1 produced basis: complete coordinate isometry with orthonormal coordinate vectors |
| f : Projectivization ℂ E → Projectivization ℂ E | TYPING | II (2.8), ray map |
| h_probability: all-representative preservation | SOURCE | II (2.8), approved nonzero-vector form |
| x : E | TYPING | II (2.1)–(2.4), representatives |
| y : E | TYPING | II (2.1)–(2.4), representatives |
| x′ : E | TYPING | II (2.1)–(2.4), representatives |
| y′ : E | TYPING | II (2.1)–(2.4), representatives |
| hx : x ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy : y ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hx′ : x′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy′ : y′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| first image-ray equality | SOURCE | II (2.8), actual image representative |
| second image-ray equality | SOURCE | II (2.8), actual image representative |
| h_basis : forall i, f[b i]=[b i] | SOURCE | III (3.5), conditional normalized-map premise discharged by final producer |
| i : ι (inside h_basis) | TYPING | all basis indices |
| j : ι (implicit) | TYPING | pair index |
| k : ι (implicit) | TYPING | pair index |
| hjk : j ≠ k | SOURCE | III (3.7), distinct pair |
| z : Circle | TYPING | III (3.7), unit complex phase |

Counts: SOURCE=10, STANDING=0, TYPING=14, RULED=0, EXCESS=0.

### GraduateQM.Wigner.exists_pair_circle_mul_or_mul_inv

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1) |
| [NormedAddCommGroup E] | TYPING | Hilbert carrier |
| [InnerProductSpace ℂ E] | TYPING | Complex Hilbert carrier |
| ι : Type* | TYPING | finite index carrier |
| [Fintype ι] | TYPING | finite index carrier |
| b : OrthonormalBasis ι ℂ E | SOURCE | III Step1 produced basis: complete coordinate isometry with orthonormal coordinate vectors |
| f : Projectivization ℂ E → Projectivization ℂ E | TYPING | II (2.8), ray map |
| h_probability: all-representative preservation | SOURCE | II (2.8), approved nonzero-vector form |
| x : E | TYPING | II (2.1)–(2.4), representatives |
| y : E | TYPING | II (2.1)–(2.4), representatives |
| x′ : E | TYPING | II (2.1)–(2.4), representatives |
| y′ : E | TYPING | II (2.1)–(2.4), representatives |
| hx : x ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy : y ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hx′ : x′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy′ : y′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| first image-ray equality | SOURCE | II (2.8), actual image representative |
| second image-ray equality | SOURCE | II (2.8), actual image representative |
| h_basis : forall i, f[b i]=[b i] | SOURCE | III (3.5), conditional normalized-map premise discharged by final producer |
| i : ι (inside h_basis) | TYPING | all basis indices |
| j : ι (implicit) | TYPING | pair index |
| k : ι (implicit) | TYPING | pair index |
| hjk : j ≠ k | SOURCE | III (3.7), distinct pair |

Counts: SOURCE=10, STANDING=0, TYPING=13, RULED=0, EXCESS=0.

### GraduateQM.Wigner.exists_basis_unitary_pair_circle_normalization

| Expanded binder | Bin | Source/convention |
|---|---|---|
| E : Type* | TYPING | II (2.1) |
| [NormedAddCommGroup E] | TYPING | Hilbert carrier |
| [InnerProductSpace ℂ E] | TYPING | Complex Hilbert carrier |
| [FiniteDimensional ℂ E] | SOURCE | author-approved finite specialization |
| f : Projectivization ℂ E → Projectivization ℂ E | TYPING | II (2.8), ray map |
| h_bijective: Injective f ∧ Surjective f | SOURCE | II (2.8) |
| a : Projectivization ℂ E (Injective) | TYPING | all source rays |
| b : Projectivization ℂ E (Injective) | TYPING | all source rays |
| f a = f b (Injective antecedent) | SOURCE | injectivity premise, II (2.8) |
| y : Projectivization ℂ E (Surjective) | TYPING | all target rays |
| h_probability: all-representative preservation | SOURCE | II (2.8), approved nonzero-vector form |
| x : E | TYPING | II (2.1)–(2.4), representatives |
| y : E | TYPING | II (2.1)–(2.4), representatives |
| x′ : E | TYPING | II (2.1)–(2.4), representatives |
| y′ : E | TYPING | II (2.1)–(2.4), representatives |
| hx : x ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy : y ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hx′ : x′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| hy′ : y′ ≠ 0 | SOURCE | II (2.1)–(2.4), nonzero representative domain |
| first image-ray equality | SOURCE | II (2.8), actual image representative |
| second image-ray equality | SOURCE | II (2.8), actual image representative |

Counts: SOURCE=10, STANDING=0, TYPING=11, RULED=0, EXCESS=0.

The nested bound x in the Surjective conclusion is existential output, not an assumption. NormedAddCommGroup/InnerProductSpace are ordinary Mathlib carrier structures; OrthonormalBasis is the standard complete coordinate linear isometry, not a project predicate hiding a Wigner result. Project-owned assumption aliases: none. No EXCESS root premises: final producer constructs both basis and unitary internally from the original E/f/bijectivity/probability inputs. For conditional intermediate helper declarations b and h_basis are genuine normalized-step premises; they are not claimed as unconditional source closure in isolation.

The ∃! producer chooses a unit y of the actual image ray; basis probability tests give the two coordinate norm squares 1/2 and every other coordinate zero. The j coordinate is therefore nonzero. Ratio y_k/y_j has norm 1 and full basis reconstruction shows y=y_j(b_j+w b_k). Ray equality follows; geometry injectivity proves uniqueness. No off-domain fallback is introduced. Classical choice of F uses the already proved unique family; though the proof invokes `.exists`, uniqueness has already been established for each parameter and implies independence of choice. There is no public selected-map definition requiring later characterization.

Classification consumes that actual F and its image-ray equations, applies all-representative preservation to two pair vectors, cancels the explicitly proved probability factors, and supplies the resulting overlap theorem to abstract CircleRigidity. The final integration destructures exists_basis_unitary_normalization and supplies the produced preservation/fixed-basis inputs to the conditional classifier. Its conclusion retains actual normalized g, bijectivity, all-representative probability preservation, fixed basis, and the complete circle branch for every distinct ordered pair. Distinct indices strengthen j<k; dimensions 0/1 have vacuous pair obligations without invented outputs. No assertion of agreement of signs across different pairs is made.

BODY_MATCH / PUBLIC_CARRIER / WELL_DEFINEDNESS / CHARACTERIZATION / CHOICE_INDEPENDENCE: no new public definitions. Existing Mathlib carriers are reused. Unique image characterization is proved by exists_unique_pair_circle_image; local choice is independent as above.

## Final validation and bounded verdict

Focused `./scripts/lake build GraduateQM.Wigner.PairNormalization` passed. Exact-type examples for all 11 exports and a separate term-level Step1 producer → pair-circle consumer assembly passed via `./scripts/lake env ./scripts/lean .state/wigner-pair-audit.lean`. The three final example types were transcribed from the reviewed complete declarations after independent source reconstruction and full binder/conclusion comparison; the separate composition constructs the result by consuming Step1 directly. Each exact export axiom closure is precisely [propext, Classical.choice, Quot.sound]. `python3 scripts/check_infrastructure.py` passed frozen-anchor guard and 15-module infrastructure configuration. Frozen root remains registered DRAFT_SORRY under the passing guard. No frozen theorem was sealed. No tracked file was edited by this auditor.

Bounded verdict: PASS for constructive unique pair-circle image, pair probability identity, global-in-z rotation/reflection per pair, and actual Step1 consumption with no new root inputs. Root Wigner theorem remains FROZEN_UNPROVED; diagonal normalization, cross-pair sign consistency, reconstruction, and final sealing are not certified here. Source graph statuses remain unaffected by this audit.

DRAFT_ANCHORS: 1 — GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean
UNREGISTERED_SORRIES: 0
DRAFT_IMPORT_VIOLATIONS: 0
SEALED_THIS_TURN: 0

## Audited file hashes

- `GraduateQM/Wigner/PairGeometry.lean` SHA256 `131ca65e11e3df76b4dddf57da42f0ea272e1e826816c2bfe28afa1762ccab1c`
- `GraduateQM/Wigner/CircleRigidity.lean` SHA256 `c7e1dd1a24eeef8b3dbfa88fba9a05b19bae4329affecbb23502689c45221e74`
- `GraduateQM/Wigner/PairCircle.lean` SHA256 `ccc993463c03992b72dde1cd35bb04961031b43426105aa1956da4aee525c9a4`
- `GraduateQM/Wigner/PairNormalization.lean` SHA256 `96a6a1b942c6dc58442e3a7d9eb09b349eea8d9fa0c66ac42d805bfc416c2129`
- `GraduateQM/Wigner/BasisNormalization.lean` SHA256 `321a211b9cc0407d347149aaa083ca4f0a2c89a2df1e53bc359c009e793a1dd0`
- `GraduateQM/Wigner/UnitRepresentatives.lean` SHA256 `49ce5827b2d2b67fbaedfa8c6826e8e118250d34fe1ed8042203d61fb2266ef5`
