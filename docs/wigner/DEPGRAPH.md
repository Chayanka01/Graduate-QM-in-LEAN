# Wigner direct proof dependency database

GRAPH_VERSION: 4
ROOTS: wigner.root
CORPUS: docs/wigner/PROOF_SOURCE.md version 1 sha256:8329924b00f9594ab4658c1fbfc9523e00704411a0282a31aaf78caf4f2f7632; primary arXiv:0808.0779v2 PDF sha256:59903556c2d3ec56528ded0dcb0c98e9daaa76cd87843d999e21822fec494228
CONVENTIONS: Finite complex dimension including 0; nonzero scalar-orbit rays; normalized squared inner norm; conjugate-linear first slot; one global inclusive linear/antilinear branch; conditional helper premises discharged at consumers.
STANDING_ASSUMPTIONS: -
EXTERNAL_POLICY: Only elementary complex/quotient/finite-linear-algebra/orthonormal-basis/isometric-equivalence foundations are external; no Wigner or projective-geometry theorem black box.
FROZEN_ANCHORS: wigner.root
FROZEN_MANIFEST: docs/wigner/frozen-anchors.json | sha256:d3592e8377ec0578c6f482bdbbd1cfea61b04e42892628c94d7391f714bb95a8
WRITER: wigner-lead
GLOBAL_REVIEWER: wigner-graph-global-review
GLOBAL_REVIEW_REF: docs/wigner/GRAPH_REVIEW.md

Source topology only. Initialized Lean fields do not claim mathematical proof. Conditional cases are conjunctive coverage, not competing routes.

Lifecycle metadata rebinding (2026-10-09): the frozen-manifest hash was updated after its anchor lifecycle state changed. Reconstructing the previous state reproduces the previously reviewed manifest hash exactly. Anchor identity, source identity, and ABI metadata are unchanged. This update changes no graph nodes, edges, source claims, or initialized Lean planning fields and makes no proof-status assessment. Independently reviewed by `wigner-graph-global-review`.

## Nodes

NODE: wigner.scalar_invariance
KIND: lemma
TITLE: Transition probability is invariant under nonzero rescaling
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#scalar_invariance@L16-L16
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#scalar_invariance@L16-L16
CONTRACT_ID: wigner.scalar_invariance
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space; x,y are nonzero; a,b are nonzero complex scalars
SOURCE_QUANTIFIERS: For every E, every x,y in E and every a,b in C satisfying the premises
SOURCE_CONCLUSION: P(a*x,b*y)=P(x,y); in particular P agrees with its value on unit representatives
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#scalar_invariance@L16-L16 | Sesquilinearity and norm multiplicativity give a positive common factor that cancels.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.normalized_correspondence
KIND: step
TITLE: Nonzero-vector rays and unit-phase classes agree
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#normalized_correspondence@L20-L20
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#normalized_correspondence@L20-L20
CONTRACT_ID: wigner.normalized_correspondence
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space; vectors being normalized are nonzero
SOURCE_QUANTIFIERS: For every E and every nonzero x; for every nonzero scalar a; universally over both quotient carriers
SOURCE_CONCLUSION: x/||x|| is unit; normalization of a*x is (a/|a|) times normalization of x; this induces a bijection from nonzero scalar-orbit classes to unit-vector phase classes preserving P
CONSTANT_SCOPE: The unit representative depends on x; the phase a/|a| depends on a. No global phase section or linear lift is asserted.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.scalar_invariance, external.complex_inner, external.projective_quotient
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.scalar_invariance | docs/wigner/PROOF_SOURCE.md#normalized_correspondence@L20-L20 | The explicit carrier bridge consumes scalar invariance to identify P.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#normalized_correspondence@L20-L20 | Norm/scalar arithmetic proves unit length and modulus-one phase.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#normalized_correspondence@L20-L20 | Scalar-orbit and phase-orbit equality make normalization descend and supply inverse quotient representatives.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.zero_probability
KIND: lemma
TITLE: Zero transition probability characterizes orthogonality
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#zero_probability@L24-L24
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#zero_probability@L24-L24
CONTRACT_ID: wigner.zero_probability
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space; x,y are nonzero
SOURCE_QUANTIFIERS: For every E and all nonzero x,y in E
SOURCE_CONCLUSION: P(x,y)=0 if and only if <x,y>=0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#zero_probability@L24-L24 | Positivity of nonzero-vector norms and norm-zero characterization justify the equivalence.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.image_orthogonality
KIND: lemma
TITLE: Probability preservation carries orthogonality to image representatives
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#image_orthogonality@L28-L28
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#image_orthogonality@L28-L28
CONTRACT_ID: wigner.image_orthogonality
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space; f is a ray self-map preserving P for every pair; x,y,xprime,yprime are nonzero; f[x]=[xprime]; f[y]=[yprime]; <x,y>=0
SOURCE_QUANTIFIERS: For every E, every such f, and every x,y,xprime,yprime satisfying these premises
SOURCE_CONCLUSION: <xprime,yprime>=0
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.zero_probability, wigner.scalar_invariance
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.zero_probability | docs/wigner/PROOF_SOURCE.md#image_orthogonality@L28-L28 | Apply the zero-probability equivalence to input and output pairs.
EDGE: wigner.scalar_invariance | docs/wigner/PROOF_SOURCE.md#image_orthogonality@L28-L28 | Preservation stated on rays applies to the displayed representatives because P is representative-independent.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Bijectivity is unnecessary for this explicitly conditional local lemma. Its representatives are bound variables, not an assumed vector lift.

NODE: wigner.dimension_zero
KIND: lemma
TITLE: Empty ray space in dimension zero is implemented by identity
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#dimension_zero@L32-L32
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#dimension_zero@L32-L32
CONTRACT_ID: wigner.dimension_zero
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space with complex dimension zero
SOURCE_QUANTIFIERS: For every E with dimension zero and every ray self-map f
SOURCE_CONCLUSION: There are no rays and f equals the ray action of the identity complex-linear isometric equivalence
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.finite_linear_algebra, external.projective_quotient
ROUTES: -
ROUTE_FOR: -
EDGE: external.finite_linear_algebra | docs/wigner/PROOF_SOURCE.md#dimension_zero@L32-L32 | Dimension zero implies all vectors are zero.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#dimension_zero@L32-L32 | A ray has a nonzero representative, so this carrier is empty.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Author-approved empty-state extension; preservation and bijectivity are not extra assumptions.

NODE: wigner.dimension_one
KIND: lemma
TITLE: One ray in dimension one is implemented by identity
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#dimension_one@L36-L36
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#dimension_one@L36-L36
CONTRACT_ID: wigner.dimension_one
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space with complex dimension one
SOURCE_QUANTIFIERS: For every E with dimension one and every ray self-map f
SOURCE_CONCLUSION: All nonzero vectors lie on one ray, and f equals the ray action of the identity complex-linear isometric equivalence
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.finite_linear_algebra, external.projective_quotient
ROUTES: -
ROUTE_FOR: -
EDGE: external.finite_linear_algebra | docs/wigner/PROOF_SOURCE.md#dimension_one@L36-L36 | Dimension-one basis and linear-dependence facts express every nonzero vector as a nonzero multiple of a fixed nonzero vector.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#dimension_one@L36-L36 | Nonzero scalar multiples represent the same ray.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: No exclusivity of linear and antilinear branches is claimed.

NODE: wigner.orthonormal_basis
KIND: step
TITLE: Choose a finite orthonormal basis internally
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#orthonormal_basis@L40-L40
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#orthonormal_basis@L40-L40
CONTRACT_ID: wigner.orthonormal_basis
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space of complex dimension n>=2
SOURCE_QUANTIFIERS: For every E and n=dim_C(E)>=2, there exists an orthonormal basis (e_j) indexed by n coordinates
SOURCE_CONCLUSION: An orthonormal basis e_1,...,e_n exists
CONSTANT_SCOPE: The basis depends on E and is an internal proof choice, not a root input.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.orthonormal_basis
ROUTES: -
ROUTE_FOR: -
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#orthonormal_basis@L40-L40 | Finite orthonormal-basis existence is the explicitly allowed standard foundation.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.image_basis
KIND: step
TITLE: Unit image representatives form an orthonormal basis
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44
CONTRACT_ID: wigner.image_basis
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space of complex dimension n>=2; f is a ray bijection preserving P for every pair
SOURCE_QUANTIFIERS: For every E and f as above, using the basis e from orthonormal_basis, there exists a family (g_j) indexed by the same n coordinates
SOURCE_CONCLUSION: Each g_j is unit and [g_j]=f[e_j], and the family (g_j) is an orthonormal basis
CONSTANT_SCOPE: The independent choices g_j depend on E, f, e, and j; no coherent phase relation is assumed.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.orthonormal_basis, external.projective_quotient, wigner.normalized_correspondence, wigner.image_orthogonality, external.finite_linear_algebra
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44 | The paragraph takes image rays of the chosen basis vectors e_j.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44 | Each image ray admits a nonzero representative.
EDGE: wigner.normalized_correspondence | docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44 | Normalize independently chosen image representatives to norm one.
EDGE: wigner.image_orthogonality | docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44 | Orthogonal distinct basis vectors have orthogonal image representatives.
EDGE: external.finite_linear_algebra | docs/wigner/PROOF_SOURCE.md#image_basis@L44-L44 | An orthonormal n-family in dimension n is complete and hence a basis.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.basis_normalization#induced_ray_action
KIND: step
TITLE: Injective semilinear maps descend to rays
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48
CONTRACT_ID: wigner.basis_normalization#induced_ray_action
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E,F are complex inner-product spaces; T:E->F is injective and either complex-linear or conjugate-linear
SOURCE_QUANTIFIERS: For every E,F and every such T; for equivalence conclusions additionally suppose T is an equivalence
SOURCE_CONCLUSION: The formula [x] -> [T x] is a well-defined ray map; if T is an equivalence its induced ray map is a bijection with inverse induced by T inverse
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: external.projective_quotient, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | A quotient map is induced when nonzero representatives remain nonzero and scalar-orbit equivalence is respected.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | Conjugation maps nonzero scalars to nonzero scalars, so conjugate-linearity respects scalar orbits.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: line48 invokes induced-ray maps of injective semilinear maps but supplies no quotient-descent and inverse construction. This records that substantive bridge without assuming a lift of f.

NODE: wigner.basis_normalization
KIND: step
TITLE: Normalize image basis by an internally constructed unitary
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48
CONTRACT_ID: wigner.basis_normalization
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space of complex dimension n>=2; f is a ray bijection preserving P for every pair
SOURCE_QUANTIFIERS: For every E and f as above, with e and g constructed by image_basis, there exists a complex-linear isometric equivalence B; define f1=ray(B) composed with f
SOURCE_CONCLUSION: B(g_j)=e_j for every j, and f1 is a probability-preserving ray bijection fixing every [e_j]
CONSTANT_SCOPE: B depends on the selected e and g; f1 is their internally constructed normalization of f. No linear representative of f is assumed.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.image_basis, external.orthonormal_basis, wigner.basis_normalization#induced_ray_action, external.semilinear_isometries
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.image_basis | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | The two orthonormal bases e and g supply B.
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | The standard equivalence between orthonormal bases constructs the unitary carrying g_j to e_j.
EDGE: wigner.basis_normalization#induced_ray_action | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | Use the induced ray bijection to compose B with f.
EDGE: external.semilinear_isometries | docs/wigner/PROOF_SOURCE.md#basis_normalization@L48-L48 | Linear isometries preserve inner products and norms, so the normalized map preserves P.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.coordinate_magnitudes
KIND: lemma
TITLE: The normalized ray map preserves coordinate magnitudes and support
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#coordinate_magnitudes@L52-L52
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#coordinate_magnitudes@L52-L52
CONTRACT_ID: wigner.coordinate_magnitudes
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E is a finite-dimensional complex inner-product space of complex dimension n>=2; f is a ray bijection preserving P for every pair; x is unit and y is a unit representative of the basis-normalized image of [x]
SOURCE_QUANTIFIERS: For every E and f as above, with e and f1 constructed by basis_normalization, for every unit x and every unit y with [y]=f1[x], and every j
SOURCE_CONCLUSION: |<e_j,y>|^2=|<e_j,x>|^2, hence |<e_j,y>|=|<e_j,x>|; the coordinate supports coincide, including for vectors supported on a pair
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.basis_normalization, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.basis_normalization | docs/wigner/PROOF_SOURCE.md#coordinate_magnitudes@L52-L52 | Basis-ray fixation and preservation supply the basis-ray probability tests.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#coordinate_magnitudes@L52-L52 | Unit norms reduce P to squared inner-product magnitude; nonnegative squared magnitudes determine magnitudes and zeros.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: The unit representative y is arbitrary, so this result introduces no phase section.

NODE: external.complex_inner
KIND: external
TITLE: Complex inner-product and norm arithmetic
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
CONTRACT_ID: external.complex_inner
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Complex inner-product spaces; scalars and vectors satisfying any nonzero conditions needed for division
SOURCE_QUANTIFIERS: Universally over those spaces, vectors, and complex scalars
SOURCE_CONCLUSION: Inner products are sesquilinear with conjugate-linear first slot; norm of a*x is |a| times norm of x; nonzero vector norm is positive; complex norm is zero exactly at zero; complex conjugation is multiplicative, involutive, and preserves norm; finite complex sums and nonnegative-real square cancellation obey ordinary arithmetic
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: EXTERNAL
LEAN_REF: -
LEAN_NOTE: -
NOTE: Boundary is elementary complex/norm/sesquilinearity arithmetic. It supplies no circle-map classification, global sign, or Wigner theorem.

NODE: external.projective_quotient
KIND: external
TITLE: Nonzero scalar-orbit quotient foundations
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
CONTRACT_ID: external.projective_quotient
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Complex vector spaces; ray carrier is the quotient of nonzero vectors by nonzero complex scalar multiplication
SOURCE_QUANTIFIERS: For every such space, every ray, and every pair of nonzero representatives; for maps satisfying orbit compatibility
SOURCE_CONCLUSION: Every ray has a nonzero representative; two nonzero vectors have the same ray exactly when one is a nonzero scalar multiple of the other; the corresponding unit-vector quotient identifies precisely phase multiples; orbit-compatible functions descend to quotient functions with the expected representative equation
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: EXTERNAL
LEAN_REF: -
LEAN_NOTE: -
NOTE: General quotient construction and scalar-orbit equality only; no vector lift of a ray bijection is supplied.

NODE: external.finite_linear_algebra
KIND: external
TITLE: Finite-dimensional basis and completeness facts
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
CONTRACT_ID: external.finite_linear_algebra
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Finite-dimensional complex vector spaces; inner-product structure for orthonormal-family conclusions
SOURCE_QUANTIFIERS: For every finite-dimensional E with n=dim_C(E); universally over its finite families and bases
SOURCE_CONCLUSION: Dimension zero implies every vector is zero; dimension one has a nonzero basis vector and every vector is its scalar multiple; finite bases give unique finite coordinate expansions; an orthonormal family is linearly independent and an n-element linearly independent family in dimension n is a basis
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: EXTERNAL
LEAN_REF: -
LEAN_NOTE: -
NOTE: Contains the finite family completeness needed at image_basis, not a presupposed image-vector lift.

NODE: external.orthonormal_basis
KIND: external
TITLE: Finite orthonormal bases, Parseval, and basis equivalences
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
CONTRACT_ID: external.orthonormal_basis
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Finite-dimensional complex inner-product spaces; orthonormal bases where coordinate or equivalence conclusions are used
SOURCE_QUANTIFIERS: For every finite-dimensional E there exists an orthonormal basis; for every such basis and vector x; for every pair of orthonormal bases with the same index set
SOURCE_CONCLUSION: A finite orthonormal basis exists; ||x||^2 equals the sum of squared magnitudes of its basis coordinates; two orthonormal bases with a common index set determine a complex-linear isometric equivalence carrying corresponding basis vectors to one another
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: EXTERNAL
LEAN_REF: -
LEAN_NOTE: -
NOTE: The basis-equivalence foundation is also expressly invoked at basis_normalization line48; no Wigner result is included.

NODE: external.semilinear_isometries
KIND: external
TITLE: Inner-product preservation and composition/inverse laws
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#external_foundations@L92-L92
CONTRACT_ID: external.semilinear_isometries
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: Complex inner-product spaces; complex-linear isometries for inner-product preservation; linear or conjugate-linear isometric equivalences for composition and inverse laws
SOURCE_QUANTIFIERS: For every such map and every pair of vectors; for every composable pair of such equivalences
SOURCE_CONCLUSION: Complex-linear isometries preserve complex inner products; inverses preserve norm and have the same linear/conjugate-linear type; composition preserves norm and has linear type for equal factor types and conjugate-linear type for unequal factor types
CONSTANT_SCOPE: none
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: -
ROUTES: -
ROUTE_FOR: -
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-foundations
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: EXTERNAL
LEAN_REF: -
LEAN_NOTE: -
NOTE: Does not supply the projective quotient construction or a lift of the original f.

NODE: wigner.pair_circle#circle_parameter
KIND: step
TITLE: Pair-circle parameter from ray output
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56
CONTRACT_ID: wigner.source.pair_circle#circle_parameter
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; basis-normalized map fixes basis rays; j<k; |z|=1
SOURCE_QUANTIFIERS: forall E,n,e,f,j,k; forall z on unit circle; exists unique z_prime on unit circle
SOURCE_CONCLUSION: The image ray of (e_j+z e_k)/sqrt(2) is represented by (e_j+z_prime e_k)/sqrt(2), and its first coefficient is positive real.
CONSTANT_SCOPE: The output parameter depends on f,e,j,k,z; no global phase section for arbitrary rays is selected.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.coordinate_magnitudes, external.projective_quotient, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.coordinate_magnitudes | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | Equal coordinate magnitudes and equal support restrict each output to the same circle after fixing its first coefficient.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | Nonzero scaling of a ray representative fixes its nonzero first coefficient and gives uniqueness of the circle parameter.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | Norm and phase arithmetic normalize the nonzero first coefficient.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: -

NODE: wigner.pair_circle
KIND: lemma
TITLE: One rotation or reflection on each pair circle
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56
CONTRACT_ID: wigner.source.pair_circle
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; basis-normalized map fixes basis rays; one fixed nondegenerate latitude (the equator suffices)
SOURCE_QUANTIFIERS: forall E,n,e,f; forall j<k; exists a_jk with |a_jk|=1 and eps_jk in {+1,-1}; forall |z|=1
SOURCE_CONCLUSION: The output circle parameter is a_jk*z for eps_jk=+1 and a_jk*conj(z) for eps_jk=-1.
CONSTANT_SCOPE: a_jk and eps_jk may depend on the normalized map, basis, pair and fixed latitude, but precede z and cannot depend on z.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.pair_circle#circle_parameter, wigner.basis_normalization, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.pair_circle#circle_parameter | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | A unique output circle parameter makes the probability-preserving circle map well-defined.
EDGE: wigner.basis_normalization | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | The normalized map still preserves all pair probabilities; this gives equality of real pair products on the circle.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#pair_circle@L56-L56 | Complex real-coordinate algebra relates the preserved real pair product to circle rotations/reflections.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: the step from preservation of Re(conj(z1_prime)*z2_prime) to one rotation/reflection valid for every z is only asserted briefly. Establish a single global sign on each fixed circle; do not assign input-dependent signs. Primary locator: III (3.7)-(3.11).

NODE: wigner.diagonal_normalization
KIND: lemma
TITLE: Remove the reference-pair phase offsets
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60
CONTRACT_ID: wigner.source.diagonal_normalization
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; basis normalization and fixed pair-circle offsets/signs
SOURCE_QUANTIFIERS: forall E,n,e,f and its pair-circle data; exists diagonal unitary D; forall k>1 and all pair-circle parameters
SOURCE_CONCLUSION: D composed with the basis-normalized ray map has zero offsets on pairs (1,k), fixes basis rays and coordinate magnitudes, preserves P and bijectivity, and retains the same pair signs.
CONSTANT_SCOPE: D depends on the pair offsets a_1k and basis, never on the later tested input x.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.pair_circle, wigner.basis_normalization, external.semilinear_isometries, external.orthonormal_basis, external.complex_inner, wigner.basis_normalization#induced_ray_action
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.pair_circle | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | The pair offsets a_1k supply the diagonal phases and the fixed signs survive their removal.
EDGE: wigner.basis_normalization | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | Consume the first normalized ray map, its fixed basis rays, bijectivity, and probability preservation.
EDGE: external.semilinear_isometries | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | Inner-product preservation and composition laws ensure that the constructed unitary normalization preserves P.
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | The original basis and its coordinatewise phase-scaled orthonormal basis determine the diagonal unitary.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | Modulus-one scaling preserves orthonormality and transforms pair offsets while retaining their signs.
EDGE: wigner.basis_normalization#induced_ray_action | docs/wigner/PROOF_SOURCE.md#diagonal_normalization@L60-L60 | Descend the newly constructed diagonal unitary to a ray bijection before composing it with the normalized ray map.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Primary locator: III (3.12)-(3.16). The reference index exists since n>=2; all signs refer to the same chosen circles.

NODE: wigner.full_support_real_test#test_vector
KIND: step
TITLE: Choose one real unit vector of full coordinate support
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64
CONTRACT_ID: wigner.source.full_support_real_test#test_vector
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e
SOURCE_QUANTIFIERS: forall E,n,e; exists r in E
SOURCE_CONCLUSION: r has norm one and every coefficient <e_j,r> is real and nonzero.
CONSTANT_SCOPE: r is an internal witness depending on the finite basis; no full-support condition is imposed on arbitrary input states.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.orthonormal_basis, external.orthonormal_basis
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | The finite orthonormal basis permits a normalized finite real coefficient sum.
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | Finite basis expansion and Parseval give the unit norm of a nonzero real coefficient vector.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: line 64 instructs choosing this witness but does not give its explicit finite construction or normalization proof. Primary locator: III (3.18).

NODE: wigner.full_support_real_test
KIND: lemma
TITLE: All residual pair offsets vanish
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64
CONTRACT_ID: wigner.source.full_support_real_test
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; twice-normalized map from diagonal normalization
SOURCE_QUANTIFIERS: forall E,n,e,f and twice-normalized map; forall j<k
SOURCE_CONCLUSION: Every residual pair-circle offset is zero; each circle action has only its previously fixed sign.
CONSTANT_SCOPE: The one auxiliary full-support real test vector is chosen internally and is independent of arbitrary later input x.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.full_support_real_test#test_vector, wigner.diagonal_normalization, wigner.coordinate_magnitudes, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.full_support_real_test#test_vector | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | Choose the real unit test vector with all nonzero coordinates before comparing it with each circle.
EDGE: wigner.diagonal_normalization | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | Offsets on (1,k) vanish and P is preserved under the twice-normalized map.
EDGE: wigner.coordinate_magnitudes | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | The output test vector has matching nonzero magnitudes, allowing each output coordinate phase to be compared.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#full_support_real_test@L64-L64 | Real/imaginary or phase algebra in all-circle probability comparisons identifies residual offsets with output phase differences.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Primary locator: III (3.17)-(3.22). Coordinate magnitudes transfer to the twice-normalized map by diagonal_normalization; they are not a new premise at the root.

NODE: wigner.pair_products
KIND: lemma
TITLE: Recover all pair products without coordinate division
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_products@L68-L68
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#pair_products@L68-L68
CONTRACT_ID: wigner.source.pair_products
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; twice-normalized map with zero pair offsets and fixed pair signs; x and y unit; [y] is the twice-normalized image of [x]
SOURCE_QUANTIFIERS: forall E,n,e,f and normalized data; forall unit x,y with image-ray relation; forall j<k
SOURCE_CONCLUSION: Writing c_j=<e_j,x> and c_prime_j=<e_j,y>, c_prime_j*conj(c_prime_k)=c_j*conj(c_k) if eps_jk=+1, and equals conj(c_j*conj(c_k)) if eps_jk=-1, including zero products.
CONSTANT_SCOPE: eps_jk is fixed before x,y and cannot depend on the tested state; no division by any c_j is permitted in this extraction.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.full_support_real_test, wigner.coordinate_magnitudes, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.full_support_real_test | docs/wigner/PROOF_SOURCE.md#pair_products@L68-L68 | Zero-offset pair probes have known images for all circle parameters and the twice-normalized map preserves their probabilities.
EDGE: wigner.coordinate_magnitudes | docs/wigner/PROOF_SOURCE.md#pair_products@L68-L68 | Matching coordinate magnitudes cancel the diagonal terms in each probe comparison.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#pair_products@L68-L68 | Equality for all probe phases determines real and imaginary parts of the complex product, also when a factor vanishes.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Primary locator: III (3.23)-(3.24). The probability comparisons use arbitrary x and the already determined circle images; their premises are supplied by full_support_real_test and diagonal normalization through that node.

NODE: wigner.triple_consistency
KIND: lemma
TITLE: Sign consistency within every triple
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#triple_consistency@L72-L72
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#triple_consistency@L72-L72
CONTRACT_ID: wigner.source.triple_consistency
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; n>=3; twice-normalized map with fixed pair signs; three distinct indices
SOURCE_QUANTIFIERS: forall E,n,e,f and normalized data; forall distinct j,k,l
SOURCE_CONCLUSION: The three pair signs on the triple agree.
CONSTANT_SCOPE: The sign statement holds before any arbitrary state x is chosen; nonzero triple-amplitude phase test vectors are internal witnesses.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.pair_products, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.pair_products | docs/wigner/PROOF_SOURCE.md#triple_consistency@L72-L72 | Apply the fixed sign identities to arbitrary normalized vectors with three nonzero coordinates and variable phases.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#triple_consistency@L72-L72 | Both input and output cyclic pair products equal a squared complex norm and must be nonnegative real.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: mixed-sign contradiction and valid normalization of the suggested i,1,1 test remain to be derived. A negative transformed product contradicts nonnegativity even though it is real; a reality-only argument is insufficient for that test. Primary locator: III (3.25)-(3.27).

NODE: wigner.global_branch
KIND: lemma
TITLE: One sign for the entire basis
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#global_branch@L76-L76
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#global_branch@L76-L76
CONTRACT_ID: wigner.source.global_branch
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; twice-normalized map with fixed pair-circle signs
SOURCE_QUANTIFIERS: forall E,n,e,f and normalized data with n>=2; exists eps in {+1,-1}; forall j<k
SOURCE_CONCLUSION: eps_jk=eps for every coordinate pair.
CONSTANT_SCOPE: eps depends only on the normalized map and basis, never on x or the pair.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.triple_consistency, wigner.pair_circle
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.triple_consistency | docs/wigner/PROOF_SOURCE.md#global_branch@L76-L76 | For n>=3, each triple has agreeing signs; overlapping triples transfer equality between arbitrary coordinate pairs.
EDGE: wigner.pair_circle | docs/wigner/PROOF_SOURCE.md#global_branch@L76-L76 | For n=2, the one pair already has a fixed sign for its entire circle, retained by diagonal normalization.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: finite-index connectivity and exhaustive n=2 versus n>=3 case split must be written explicitly. These conditional cases are both required, not alternative whole-theorem proof routes. Premise discharge: n>=3 is assumed only inside its case; for n=2 there are exactly two indices and a unique unordered pair. Primary locator: III Step 6, with project-specific n=2 expansion.

NODE: wigner.sparse_reconstruction
KIND: lemma
TITLE: Reconstruct every state, including coordinate zeros
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80
CONTRACT_ID: wigner.source.sparse_reconstruction
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P; twice-normalized map; one sign applies to every pair product
SOURCE_QUANTIFIERS: forall E,n,e,f and global sign eps; forall unit x,y with [y] equal to normalized image of [x]; exists lambda with |lambda|=1
SOURCE_CONCLUSION: y=lambda*x if eps=+1, and y=lambda*(coordinate conjugation of x) if eps=-1; hence equality of the corresponding rays for every unit x.
CONSTANT_SCOPE: eps precedes all states; the nonzero coordinate index and phase lambda may depend on x,y. The reference index is not fixed across states.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.pair_products, wigner.coordinate_magnitudes, wigner.global_branch, external.orthonormal_basis, external.projective_quotient, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.pair_products | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | Products against the chosen nonzero coordinate recover every other nonzero coefficient in the chosen global branch.
EDGE: wigner.coordinate_magnitudes | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | Support equality handles zero coefficients and ensures the chosen output coefficient is nonzero with the matching magnitude.
EDGE: wigner.global_branch | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | All pair-product identities use the same sign, giving one vector formula per branch.
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | Unit norm and finite coordinate expansion ensure at least one coefficient is nonzero and coordinate equality gives vector equality.
EDGE: external.projective_quotient | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | The recovered nonzero phase multiple represents exactly the same ray.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#sparse_reconstruction@L80-L80 | Dividing only by the chosen nonzero coefficient gives a phase of modulus one and resolves the remaining coefficients.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: SOURCE_GAP: expand the per-vector nonzero-index selection and phase recovery, including the chosen-index coordinate and every zero coordinate. A fixed-index division or full-support-only reconstruction would weaken the conclusion. Primary locator: III (3.24)-(3.28), with explicit project expansion.

NODE: wigner.conjugation_operator
KIND: step
TITLE: Coordinate conjugation is an antiunitary equivalence
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#conjugation_operator@L84-L84
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#conjugation_operator@L84-L84
CONTRACT_ID: wigner.source.conjugation_operator
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; chosen orthonormal basis e
SOURCE_QUANTIFIERS: forall E and orthonormal basis e; define K; forall x,y in E and a in C
SOURCE_CONCLUSION: K conjugates every basis coefficient, is additive, satisfies K(a*x)=conj(a)*K(x), preserves norm, and K(K(x))=x, hence is a bijective conjugate-linear isometry.
CONSTANT_SCOPE: One K is fixed by the chosen basis and applies to every vector.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.orthonormal_basis, external.orthonormal_basis, external.complex_inner
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#conjugation_operator@L84-L84 | Use the internally chosen orthonormal basis to define coefficientwise conjugation.
EDGE: external.orthonormal_basis | docs/wigner/PROOF_SOURCE.md#conjugation_operator@L84-L84 | Finite expansion and Parseval turn conjugation of coefficients into norm preservation and vector involutivity.
EDGE: external.complex_inner | docs/wigner/PROOF_SOURCE.md#conjugation_operator@L84-L84 | Conjugation preserves sums, conjugates scalar products, preserves complex norms, and squares to identity.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Primary locators: II after (2.14), III conclusion. The conjugation law, norm law and inverse law are the substantive content of this node, never assumptions on the root.

NODE: wigner.denormalization
KIND: application
TITLE: Undo normalizations to obtain the implementing equivalence
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88
CONTRACT_ID: wigner.source.denormalization
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E finite-dimensional complex inner-product space; dim_C E=n>=2; chosen orthonormal basis e; f is a ray bijection preserving P
SOURCE_QUANTIFIERS: forall E,n,e,f with n>=2; either exists unitary U, forall rays r, f(r)=[U acting on r]; or exists antiunitary A, forall rays r, f(r)=[A acting on r]
SOURCE_CONCLUSION: The inverse unitary normalizations, composed with K only in the negative branch, implement f as equality on every ray.
CONSTANT_SCOPE: The implementing equivalence depends on f and the internal basis/normalizations; it is chosen before the universally quantified ray.
FROZEN_FILE: -
FROZEN_DECL: -
FROZEN_ANCHOR_ID: -
FROZEN_ABI_SHA256: -
DEPS: wigner.basis_normalization, wigner.diagonal_normalization, wigner.sparse_reconstruction, wigner.conjugation_operator, wigner.normalized_correspondence, external.semilinear_isometries, wigner.basis_normalization#induced_ray_action
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.basis_normalization | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | Recover the first normalizing unitary and its inverse action on rays.
EDGE: wigner.diagonal_normalization | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | Recover the second normalizing unitary and undo it in the correct composition order.
EDGE: wigner.sparse_reconstruction | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | The twice-normalized action agrees on every unit representative with identity or coefficient conjugation, including sparse states.
EDGE: wigner.conjugation_operator | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | Realize the negative branch by a genuine conjugate-linear norm-preserving equivalence K.
EDGE: wigner.normalized_correspondence | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | Every ray has a unit representative, extending the unit-vector reconstruction to equality of functions on all nonzero-vector rays.
EDGE: external.semilinear_isometries | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | Inverse and composition laws preserve the linear or conjugate-linear isometry-equivalence structure.
EDGE: wigner.basis_normalization#induced_ray_action | docs/wigner/PROOF_SOURCE.md#denormalization@L88-L88 | The implementing linear or conjugate-linear equivalence descends to rays, and the induced inverse actions undo the two normalizations.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Primary locators: III conclusion after (3.28); II (2.11)-(2.14). Conditional n>=2 context is supplied by the root dimension split. No branch exclusivity is asserted.

NODE: wigner.root
KIND: theorem
TITLE: Finite-dimensional Wigner theorem
STATEMENT_SOURCE: docs/wigner/PROOF_SOURCE.md#root@L11-L11
PROOF_SOURCE: docs/wigner/PROOF_SOURCE.md#root@L12-L12
CONTRACT_ID: wigner.classical.finite
CONTRACT_VERSION: 1
SOURCE_HYPOTHESES: E has a normed additive commutative group and complex inner-product-space structure and is finite-dimensional; f is a bijection of Projectivization C E; for all nonzero x,y,x_prime,y_prime representing respective input and output rays, P(x_prime,y_prime)=P(x,y)
SOURCE_QUANTIFIERS: forall E and its stated structures; forall f; forall proofs of bijectivity and the universally quantified representative probability-preservation premise; (exists complex-linear norm-preserving equivalence U implementing f on all rays) OR (exists conjugate-linear norm-preserving equivalence A implementing f on all rays)
SOURCE_CONCLUSION: f equals the ray function induced by a single complex-linear isometric equivalence or by a single conjugate-linear isometric equivalence.
CONSTANT_SCOPE: The implementing U or A is global and independent of the ray; no continuity, lift, basis, phase section or linearity premise; inclusive disjunction with no branch-exclusivity requirement.
FROZEN_FILE: GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean
FROZEN_DECL: GraduateQM.Wigner.exists_unitary_or_antiunitary
FROZEN_ANCHOR_ID: wigner_exists_unitary_or_antiunitary_v1
FROZEN_ABI_SHA256: 393a6d05da209da8453b5fcc43a3972c578d3ea4c031b2843b86c79929dd5727
DEPS: wigner.dimension_zero, wigner.dimension_one, wigner.denormalization, wigner.normalized_correspondence
ROUTES: -
ROUTE_FOR: -
EDGE: wigner.dimension_zero | docs/wigner/PROOF_SOURCE.md#root@L12-L12 | Line 12 dimension split: in dimension zero apply the empty-ray result to the given ray self-map; no nonempty-state premise is required.
EDGE: wigner.dimension_one | docs/wigner/PROOF_SOURCE.md#root@L12-L12 | Line 12 dimension split: in dimension one apply the singleton-ray result to the given ray self-map.
EDGE: wigner.denormalization | docs/wigner/PROOF_SOURCE.md#root@L12-L12 | Line 12 dimension split: in dimension at least two, the normalized-coordinate proof and inverse normalizations produce the implementing equivalence.
EDGE: wigner.normalized_correspondence | docs/wigner/PROOF_SOURCE.md#root@L12-L12 | Line 12 normalization transfers the approved nonzero-vector ray presentation and preservation premise to the unit representative proof and its conclusion.
TOPOLOGY_STATUS: REVIEWED
EXTRACTOR: wigner-extract-coherence
REVIEWER: wigner-graph-slice-review
LEAN_STATUS: NOT_STARTED
LEAN_REF: -
LEAN_NOTE: -
NOTE: Root dimension premises are discharged by the exhaustive finite natural-number split dim=0, dim=1, dim>=2 explicitly stated at line 12. The n>=2 branch chooses an orthonormal basis internally through the denormalization dependency closure. These branches are conjunctive case coverage, not alternative routes. Anchor split policy NOT_SPLIT; one global inclusive existential disjunction. Primary source: II (2.8), conclusion following (2.14); explicit project-approved dimension-zero extension.

<!-- BEGIN PROOF DEPGRAPH GENERATED -->
Regenerated by `proof_depgraph.py`; do not hand-edit.

### Dashboard

* Total nodes: **28**
* Frozen anchors: **1**
* Versioned statement contracts: **28**
* Total edges: **70**
* Root-closure nodes: **28**
* Dependency leaves in root closure: **5**
* Assumption boundary leaves: **0**
* External boundary leaves: **5**
* Alternative routes: **0**
* Topology review queue: **0**
* Explicit source gaps: **6**
* Coverage items: **24**; excluded: **2**

### Roots

* `wigner.root` [REVIEWED; frozen] — contract `wigner.classical.finite@1`

### Topology review queue

* _(none)_

### Dependency leaves in root closure

* `external.complex_inner` [REVIEWED] — Complex inner-product and norm arithmetic
* `external.finite_linear_algebra` [REVIEWED] — Finite-dimensional basis and completeness facts
* `external.orthonormal_basis` [REVIEWED] — Finite orthonormal bases, Parseval, and basis equivalences
* `external.projective_quotient` [REVIEWED] — Nonzero scalar-orbit quotient foundations
* `external.semilinear_isometries` [REVIEWED] — Inner-product preservation and composition/inverse laws

### Assumption boundary leaves

* _(none)_

### External boundary leaves

* `external.complex_inner` [REVIEWED] — Complex inner-product and norm arithmetic
* `external.finite_linear_algebra` [REVIEWED] — Finite-dimensional basis and completeness facts
* `external.orthonormal_basis` [REVIEWED] — Finite orthonormal bases, Parseval, and basis equivalences
* `external.projective_quotient` [REVIEWED] — Nonzero scalar-orbit quotient foundations
* `external.semilinear_isometries` [REVIEWED] — Inner-product preservation and composition/inverse laws

### Uncovered graph nodes

* _(none)_

### Nodes outside every root closure

* _(none)_

### Explicit source gaps

* `wigner.basis_normalization#induced_ray_action` [REVIEWED] — Injective semilinear maps descend to rays
* `wigner.full_support_real_test#test_vector` [REVIEWED] — Choose one real unit vector of full coordinate support
* `wigner.global_branch` [REVIEWED] — One sign for the entire basis
* `wigner.pair_circle` [REVIEWED] — One rotation or reflection on each pair circle
* `wigner.sparse_reconstruction` [REVIEWED] — Reconstruct every state, including coordinate zeros
* `wigner.triple_consistency` [REVIEWED] — Sign consistency within every triple
<!-- END PROOF DEPGRAPH GENERATED -->
