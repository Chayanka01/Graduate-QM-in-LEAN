# Independent final Wigner audit

Publication note: this report records its original verification stage. References
to ignored `.state/` logs describe local evidence, not distributed files. Current
status and public reproduction instructions are in [RELEASE.md](RELEASE.md).

Reviewer: fresh independent wigner_final_audit. Date: 2026-10-09.
Status: FINAL PASS for the exact sealed root, with lead-executed kernel evidence explicitly attributed below.
No implementation, frozen, manifest, public documentation, or dependency files edited. No agents spawned. Build/probe execution is delegated to the lead because this auditor's governing instructions forbid write-requiring builds; any later execution evidence must identify that executor and is not an independently rerun build.

## Authoritative identity and independent source reconstruction

Read AGENTS.md, docs/WORKFLOW.md, lean-workflow and lean-statement-audit before implementation. Independently extracted the actual local pinned PDF with bundled Python/pypdf and read Section II and Section III before inspecting implementation. Ambient pymupdf/pypdf and pdftotext were unavailable; bundled pypdf succeeded. No alternate online source substituted.

Recomputed and matched:
- raw PDF: 59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228.
- PROOF_SOURCE.md: 8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632.
- initial complete draft: 857b7867e5558cf9f845f25f67d14b11175b0635d7e4b1c84bcf2bae293f5902.
- frozen prefix through proof-begin marker: 95fdab26e69e359d221b95dc5dc44908326ff85c21e230a2bfa3b6d61fe6b4e5.
- frozen suffix from proof-end marker: 2d8a36cbcd95a30d76492d0d647263e062399449f093949160c5651e63ec554d.
- stored fully elaborated type snapshot: 393a6d05da209da8453b5fcc43a3972c578d3ea4c031b2843b86c79929dd5727.

Anchor wigner_exists_unitary_or_antiunitary_v1; theorem GraduateQM.Wigner.exists_unitary_or_antiunitary in GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean. Provider GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary. Approval dated 2026-10-09, NOT_SPLIT. Initial state DRAFT_SORRY, exactly one by sorry body. No promotion at this stage.

Independent source mathematics: II (2.1)-(2.4) uses normalized vectors modulo unit phase; II (2.8) requires a bijective ray transformation preserving all pair transition probabilities. Conclusion following (2.14) is existence of one unitary or one antiunitary inducing the map on every ray. Nonzero-vector scalar orbits with probability |<x,y>|^2/(||x||^2||y||^2) are precisely the approved homogeneous presentation. The author explicitly adopted arbitrary finite dimension, including the empty-ray zero-dimensional extension, inclusive alternatives, and no uniqueness. Finite dimensionality is SOURCE for this selected specialization, not an asserted standing-assumption package.

Independently reconstructed III route: images of an ONB form an ONB; a unitary fixes basis rays; basis tests preserve coordinate magnitudes; each equal-weight pair circle has one rotation/reflection; diagonal unitary kills reference offsets; one internally constructed full-support real test kills remaining offsets; arbitrary-state pair tests determine coordinate products; coherent pair signs give one global branch; choose a nonzero coordinate separately for each state to reconstruct sparse rays; build actual coordinate conjugation and undo both unitary normalizations. Section V induction and its questionable compressed scalar-inference step are not needed. Source graph topology and six historical SOURCE_GAP labels are not proof evidence.

## Exact frozen root binder audit

The following rows enumerate every root binder and the nested preservation premise. Universe level is type formation. No project-owned Prop alias, assumption structure, typeclass, gate, or semantic definition occurs. Standard Function.Bijective is expanded below.

| Binder | Bin | Citation/meaning |
|---|---|---|
| E : Type* (explicit) | TYPING | II underlying Hilbert-space carrier |
| NormedAddCommGroup E (instance) | TYPING | II (2.1)-(2.4) vector/norm structure |
| InnerProductSpace ℂ E (instance) | TYPING | II complex positive-definite inner-product structure |
| FiniteDimensional ℂ E (instance) | SOURCE | selected finite-dimensional II setting; author approval |
| f : Projectivization ℂ E → Projectivization ℂ E (explicit) | SOURCE | II (2.8) ray transformation |
| h_bijective : Function.Bijective f (explicit) | SOURCE | II (2.8) one-to-one onto |
| h_probability (explicit) | SOURCE | II (2.8), homogeneous II (2.4) as approved |
| h_probability.x : E | SOURCE | first arbitrary nonzero source representative |
| h_probability.y : E | SOURCE | second arbitrary nonzero source representative |
| h_probability.x' : E | SOURCE | arbitrary first image representative |
| h_probability.y' : E | SOURCE | arbitrary second image representative |
| h_probability.hx : x ≠ 0 | SOURCE | approved ray domain |
| h_probability.hy : y ≠ 0 | SOURCE | approved ray domain |
| h_probability.hx' : x' ≠ 0 | SOURCE | approved image-ray domain |
| h_probability.hy' : y' ≠ 0 | SOURCE | approved image-ray domain |
| h_probability first unnamed image equality | SOURCE | x' represents f[x] |
| h_probability second unnamed image equality | SOURCE | y' represents f[y] |

Counts at root and preservation-expansion level: SOURCE 14, STANDING 0, TYPING 3, RULED 0, EXCESS 0; total 17. The zero-dimensional ruling changes the allowed endpoint, not the binder list. Function.Bijective expands to Injective f ∧ Surjective f: ∀ {p q}, f p=f q → p=q, and ∀ q, ∃ p, f p=q. Its p, q, equality premise, and target q are all SOURCE quantification from II (2.8); they add no independent logical assumption. Nonzero predicates unfold to equality-to-zero implying False. No hidden construction premise appears in these library predicates.

Quantifier audit: E/instances → f → bijectivity → all-representative preservation → inclusive disjunction of existential global operators, each followed by equality of functions on all rays. No basis, phase section, coordinate lift, continuity, dimensional lower bound, full support, already-linear map, global sign or normalizer is an input. Function equality forces one witness for every ray. Positive-definite Hilbert geometry is present; no indefinite-metric extension claimed. Finite dimension supplies completeness, so no extra completeness hypothesis is needed.

Read pinned Mathlib definitions: Projectivization is quotient of nonzero vectors by the unit-group scalar orbit; map uses an injective semilinear map on that quotient. LinearIsometryEquiv extends semilinear equivalence with norm preservation; ≃ₗᵢ⋆ is specifically starRingEnd ℂ, hence actual complex conjugate linearity, not mere real linearity.

## Independent implementation review so far

All hashes listed in HELPER_AUDIT, STEP1_AUDIT, STEP2_AUDIT, STEPS34_AUDIT independently recomputed and matched (including unchanged original root at that time). These prior audited versions supply the earlier semantic foundation; their kernel runs are prior evidence, not runs by this reviewer. Project import graph statically checked acyclic at 25 modules before final provider integration. Only draft root had sorry; no project axiom/admit found in the source scan.

CoordinateConjugation.exists_coordinate_conjugation: actual conjugate-linear coordinate equivalence, norm preserved via coordinate norm formula, transported through b.repr and b.repr.symm; coordinate formula and involution proved. Empty index type allowed. Only conditional construction input is the orthonormal basis, later supplied internally.

SignCoherence.signs_uniform_of_coordinate_lifts: h_lift is substantive and conditional, not an allowed root premise. Given it, test c_j=i and all other entries 1 yields d_k*conj(d_k)=d_k*conj(d_l)=1, forcing row signs equal. Conjugation gives opposite-row consistency. A pair, if one exists, connects all off-diagonal signs; otherwise conclusion is vacuous. This avoids any unjustified three-distinct-index premise in dimension two. It is an elementary algebraic expansion of III Step 6, not a Section V induction.

GlobalBranch.coordinate_products_global_branch: signs selected once from h_pairs before any arbitrary state. Diagonal products come from coordinate magnitudes. h_lift genuinely produced for every c using x=b.repr.symm c. If x=0, all c_i=0 is proved and zero d satisfies the identity. Otherwise x is normalized, a unit representative y of f[x/||x||] is obtained, and d_i=||x||*<b_i,y>; real scale makes conjugated product rescaling valid. The actual h_lift term is passed to SignCoherence. No full-support condition or arbitrary fallback semantics. One branch precedes all x,y and all j,k.

GlobalRayAction: private nonzero-coordinate existence follows from injective b.repr and x≠0. eq_id_of_coordinate_products chooses unit representatives of each ray and image, then selects its own nonzero coordinate. Antiunitary branch does this on Kx and consumes its coordinate formula. CoordinateConjugation supplies K inside exists_antiunitary_of_conjugated_coordinate_products. Sparse vectors included; no fixed-reference division. The inherited RayReconstruction cancellation is only by a coordinate proved nonzero for that particular state. Products imply output reference coordinate nonzero before division.

Conditional helper premises are not source-root assumptions: b is an internal basis witness; h_basis/h_pairs/h_products/h_lift/hK are proof obligations that must be produced at their actual consumers. At this stage only final provider/denormalization consumption remains to inspect.

## Requested execution evidence

Sent independently reconstructed exact root example text to the lead. Requested explicit provider application at the same original-input type (defeats any default-argument concealment), fully printed frozen proof, regenerated pp.all ABI compared exactly to original snapshot, root/provider/new-export #print axioms, and an original-input → normalization → global branch → actual ray-action consumer. Lead is to archive full probe source/output and delete temporary probes. No Lean/Lake invocation by this auditor. Final guard and build evidence still pending.

## New-helper binder ledger (relative to the full source root)

No new public definitions occur: BODY_MATCH / WELL_DEFINEDNESS / CHARACTERIZATION / CHOICE_INDEPENDENCE = N/A (theorem-only packet). Existential witnesses selected inside proofs need existence, not unique witness choice; no canonical uniquely characterized public object is claimed.

For each new theorem, each applicable carrier row below counts separately. T = TYPING, S = SOURCE, X = EXCESS relative to the full root. X at a helper is an explicit conditional obligation, never a passing full-source declaration; final consumers must discharge it.

| Export | Binder | Bin | Meaning |
|---|---|---|---|
| exists_coordinate_conjugation | ι | T | finite coordinate index type |
| exists_coordinate_conjugation | E | T | complex space carrier |
| exists_coordinate_conjugation | Fintype ι | T | finite coordinates |
| exists_coordinate_conjugation | NormedAddCommGroup E | T | norm structure |
| exists_coordinate_conjugation | InnerProductSpace ℂ E | T | source complex inner product |
| exists_coordinate_conjugation | b | X | chosen ONB, source III internal construction |
| signs_uniform_of_coordinate_lifts | ι | T | coordinate index type |
| signs_uniform_of_coordinate_lifts | ε | T | specified pair sign assignment |
| signs_uniform_of_coordinate_lifts | h_lift | X | arbitrary-coordinate lifting obligation, produced by GlobalBranch |
| coordinate_products_global_branch | E | T | complex carrier |
| coordinate_products_global_branch | ι | T | coordinate carrier |
| coordinate_products_global_branch | NormedAddCommGroup E | T | norm structure |
| coordinate_products_global_branch | InnerProductSpace ℂ E | T | complex inner product |
| coordinate_products_global_branch | Fintype ι | T | finite coordinate indexing |
| coordinate_products_global_branch | b | X | basis normalization output |
| coordinate_products_global_branch | f | S | II ray map |
| coordinate_products_global_branch | h_probability | S | exact II preservation premise, same ten internal binders as root |
| coordinate_products_global_branch | h_basis | X | normalized basis fixation |
| coordinate_products_global_branch | h_pairs | X | pair-circle classification after offset removal |
| eq_id_of_coordinate_products | E | T | complex carrier |
| eq_id_of_coordinate_products | ι | T | coordinate carrier |
| eq_id_of_coordinate_products | NormedAddCommGroup E | T | norm structure |
| eq_id_of_coordinate_products | InnerProductSpace ℂ E | T | complex inner product |
| eq_id_of_coordinate_products | Fintype ι | T | finite coordinates |
| eq_id_of_coordinate_products | b | X | chosen basis |
| eq_id_of_coordinate_products | f | S | ray map |
| eq_id_of_coordinate_products | h_products | X | global preserved products |
| eq_map_of_conjugated_coordinate_products | E | T | complex carrier |
| eq_map_of_conjugated_coordinate_products | ι | T | coordinate carrier |
| eq_map_of_conjugated_coordinate_products | NormedAddCommGroup E | T | norm structure |
| eq_map_of_conjugated_coordinate_products | InnerProductSpace ℂ E | T | complex inner product |
| eq_map_of_conjugated_coordinate_products | Fintype ι | T | finite coordinates |
| eq_map_of_conjugated_coordinate_products | b | X | chosen basis |
| eq_map_of_conjugated_coordinate_products | f | S | ray map |
| eq_map_of_conjugated_coordinate_products | K | X | actual antiunitary witness must be produced |
| eq_map_of_conjugated_coordinate_products | hK | X | coordinate conjugation formula |
| eq_map_of_conjugated_coordinate_products | h_products | X | global conjugated products |
| exists_antiunitary_of_conjugated_coordinate_products | E | T | complex carrier |
| exists_antiunitary_of_conjugated_coordinate_products | ι | T | coordinate carrier |
| exists_antiunitary_of_conjugated_coordinate_products | NormedAddCommGroup E | T | norm structure |
| exists_antiunitary_of_conjugated_coordinate_products | InnerProductSpace ℂ E | T | complex inner product |
| exists_antiunitary_of_conjugated_coordinate_products | Fintype ι | T | finite coordinates |
| exists_antiunitary_of_conjugated_coordinate_products | b | X | chosen basis |
| exists_antiunitary_of_conjugated_coordinate_products | f | S | ray map |
| exists_antiunitary_of_conjugated_coordinate_products | h_products | X | global conjugated products |

Top-level counts in listed order (SOURCE, STANDING, TYPING, RULED, EXCESS): (0,0,5,0,1); (0,0,2,0,1); (2,0,5,0,3); (1,0,5,0,2); (1,0,5,0,4); (1,0,5,0,2). All six are CONDITIONAL at their own boundaries. h_lift expands to ∀ c, ∃ d, ∀ j k, the explicit product identity; h_basis to ∀ i, the basis ray equality; h_pairs to ∀ j k, j≠k → ((∀z, rotation ray equality) ∨ (∀z, reflection equality)); hK to ∀ x i, coordinate formula. These internal indices/coordinate values are typing the specified obligation; no further independent proposition is hidden. h_products expands to x,y,hx,hy,unit x,unit y,image equality,j,k and the literal pair-product identity. Its unit/nonzero/image restrictions specify the source representative domain; its asserted identity remains X until produced. Conclusions are outputs, not extra assumptions.

## Final provider source review

Stable Provider inspected after lead's notice. It has exactly the original SOURCE proof premises, with E and f implicit and tactic defaults on h_bijective/h_probability. `by assumption` is elaborator argument retrieval, not an axiom; exact explicit-argument consumer evidence is still required. No project structure/class packages these inputs. Provider same root binder counts and zero EXCESS.

Term-level source trace: exists_basis_zero_offset_normalization f h_bijective h_probability produces b,U,h_probability',h_basis,h_pairs. Those actual terms supply coordinate_products_global_branch. Its hpos feeds eq_id_of_coordinate_products; hneg feeds exists_antiunitary_of_conjugated_coordinate_products, which internally supplies actual K/hK. Positive final witness U.symm; negative final witness K.trans U.symm, i.e. U^{-1} after K. projectivization_map_symm_apply cancels the actual invertible normalizer on every ray; quotient induction proves the final composition equality. All conditional obligations are visibly consumed. The provider imports no frozen module, so it cannot consume the draft root or prove it circularly.

Dimension endpoints: normalization's rank-zero branch has no coordinate index; sign and reconstruction claims are vacuous on no rays. Rank one has no distinct pair and diagonal product equality suffices to reconstruct its unique ray. Rank two uses actual off-diagonal sign and its reversed-pair symmetry; no third coordinate is selected. No excluded Section V induction, Wigner black box, or source-root convenience assumption occurs in the route.

## Final sealed identity and supplied validation evidence

Read `.state/wigner-final-validation.log` and `.state/wigner-final-exact-output.txt` independently. Lead executed; not independently rerun. Exact consumer source was inspected in full. It matches the independently requested original-input type, explicitly supplies both hypotheses to root and provider, and obtains b,U from original inputs before consuming the global branch and ray-action producers. All eleven axiom reports were parsed independently across wrapped lines: root, provider, six new exports, and three named consumers each have exactly propext, Classical.choice, Quot.sound. No sorryAx, custom axiom, or unexplained constant.

Independently recomputed approved baseline SHA and final whole-file SHA; sealed bytes equal exactly the original baseline with `by sorry\n` replaced by `by exact GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary\n`. Final SHA is 6b557eb1096e9305b067e06a389b903282b1f7d7feee1a1eb0a1e60d9ac8a96d. Prefix/suffix unchanged; manifest state SEALED. Fresh ABI output's first 28015 bytes exactly equal the stored approved snapshot, not merely the same reported hash. ABI probe has two expected unused-binder-name warnings, as the original did. The exact/consumption probe is warning-free. Both transient probe paths are absent after archive.

Concrete evidence correction: the initially supplied imported-root `#print` ends in `<not imported>`, so it does not expose the root proof body. This reviewer caught the limitation and requested re-elaboration of the exact sealed root source in a transient file with a same-module #print. Until that supplemental evidence is reviewed, the report does not claim to have seen its elaborated argument term. Explicit original-input root/provider consumers and their axiom reports already pass.

Final read-only source graph check: 26 modules, acyclic. Only GraduateQM imports Frozen; only Frozen imports Provider. No draft consumption, sorry/admit/custom axiom/unsafe candidate found. After sealing, GraduateQM.lean publicly imports the frozen export. Updated scripts/check audits both named smoke and Wigner exports, rejects unexpected axioms, and fails on an absent/unrecognized exact-export report. Inspected final integration log: frozen guard OK, 26 modules, 12 skills, 17 guard regression tests pass, GraduateQM build succeeds (2450 jobs), both exact-export axiom reports standard. The build count includes cached dependency jobs, not an independently measured clean rebuild.

Stable final new-file hashes:
- CoordinateConjugation.lean: 43533a7a094854eab2661a6a74e9584b80b0e26332265e3bf0e253582c3799f8
- SignCoherence.lean: fd7022c84eb5c9d142d170b054dba9b72c052f191f38579ec2d456b2673f2056
- GlobalBranch.lean: edcf6c30d185c7c14cf5fee220dbf2a1957ba5f36c870f91c7f958657564500a
- GlobalRayAction.lean: 8ab9253776b7ee1f801fad883f503799ed73c356b8511d6496bd9ef5b149d545
- Provider.lean: d4b9ef897330792c900c5f08c0e5f1ecba2f6399222b7a22ed6d49af5e813126

## Supplemental proof-term evidence and final verdict

Reviewed `.state/wigner-final-proofterm-output.txt` and appended complete probe source in validation log. Independently verified that the probe begins byte-for-byte with the exact current sealed frozen file, followed only by pp.all #print and #print axioms. Lead execution exited 0, warning-free; transient probe deleted. Unlike the imported-root print, this re-elaboration exposes the body:

`@GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary.{u_1} E inst inst_1 inst_2 f h_bijective h_probability`

Thus the automatic defaults supply precisely the root's original two source assumptions and its actual instances; they do not insert another premise or unexplained witness. The supplemental root axiom list is again exactly propext, Classical.choice, Quot.sound. The initial missing proof-body visibility and inaccurate all-probes-warning-free description have been corrected; neither remains an unresolved mathematical issue.

DECLARATION_FIDELITY: PASS.
BINDER_AUDIT: PASS; STANDING 0, FiniteDimensional SOURCE, root EXCESS 0.
DEFINITION_CLOSURE: PASS; no project semantic definitions in frozen type; library carrier/semilinearity inspected, prior helper versions hash-bound, new theorem constructions inspected.
PROOF_BODY_ONLY_SEAL: PASS.
ACTUAL_SOURCE_PREMISE_CONSUMPTION: PASS, both static terms and supplied compiled consumers.
AXIOM_CLOSURE: PASS on supplied exact-export and re-elaboration logs, standard three only.
IMPORT_AND_DRAFT_CONSUMPTION: PASS; acyclic, no draft remains or circular provider path.
FINAL_AUDIT_VERDICT: PASS for GraduateQM.Wigner.exists_unitary_or_antiunitary, approved finite-dimensional statement v1. Eligible for PROVED status based on compiled exact seal plus independent source/statement/dependency review.

The physical meaning certified by this independent source review is: every bijection of pure-state rays in an arbitrary finite-dimensional complex inner-product space preserving all Born transition probabilities has one global unitary or antiunitary implementation. This does not assert uniqueness, branch exclusivity, mixed-state channel properties, infinite-dimensional Wigner, or an empirical physics claim. Kernel evidence establishes the encoded proposition under standard axioms; the source/quantifier/carrier review establishes that this proposition is the approved mathematical target.

Checks not independently rerun: all Lean/Lake builds, all transient Lean examples/ABI/proofterm/axiom probes, infrastructure checker, and guard unittest execution. They were executed by lead, then independently inspected here, per governing read-only-build instruction. No clean fresh-checkout rebuild; no dedicated concrete dimension-0/1/2 instantiation probe beyond generic theorem compilation and source review; no re-proof/rebuild of prior helper milestones; no execution of manuscript instructions. Source hashes, proof-only delta, exact ABI byte comparison, axiom-output parsing, probe removal, module import graph, and mathematical/term-level source review were independently performed. The source graph's historical gap labels/topology remain historical evidence and were not treated as proof closure.

Files owned/changed by reviewer: `.state/wigner-final-audit.md` only. No implementation/frozen/public-doc changes, no commits/pushes.

DRAFT_ANCHORS: 0.
UNREGISTERED_SORRIES: 0.
DRAFT_IMPORT_VIOLATIONS: 0.
SEALED_THIS_TURN: 1 by lead — GraduateQM.Wigner.exists_unitary_or_antiunitary; 0 by auditor.
