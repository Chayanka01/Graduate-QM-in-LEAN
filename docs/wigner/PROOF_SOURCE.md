# Wigner direct-proof source transcription, version 1

This is an original mathematical transcription and explicit expansion for this project, not a copy of the paper. Primary source: Simon, Mukunda, Chaturvedi, Srinivasan, arXiv:0808.0779v2 (21 August 2008), https://arxiv.org/pdf/0808.0779v2. PDF equation numbers below are stable locators. The author approved the finite-dimensional target, normalized nonzero-vector presentation, and dimension-zero convention on 2026-10-09. No Wigner black box is an external input.

## Conventions

E is a finite-dimensional complex inner-product space. Inner products are conjugate-linear in the first slot. A ray [x] has x != 0 and identifies x with a*x for a != 0. P(x,y)=|<x,y>|^2/(||x||^2 ||y||^2). Unit-vector coordinates are c_j=<e_j,x>. All index families are finite. All existential linear/antilinear branch choices in the conclusion are global. Auxiliary local phase normalizations are proof constructions, not inputs. Source II (2.1)-(2.4); III uses these conventions throughout.

## root

For every E as above, every bijection f on its rays preserving P for every pair is induced by a single complex-linear norm-preserving equivalence U, or by a single conjugate-linear norm-preserving equivalence A. The implementation is equality of functions on all rays. Source II (2.8), conclusion following (2.14); dimension zero is the explicit approved extension. No continuity, vector lift, basis, phase section, or linearity is assumed.
The finite proof splits into dimensions 0, 1, and >=2. For >=2 it uses normalization, pair geometry, coherent signs, reconstruction, and denormalization below. The alternatives linear and antilinear form one inclusive existential conclusion, not independent root theorems.

## scalar_invariance

For x,y != 0 and a,b != 0, P(a*x,b*y)=P(x,y). Source II (2.2)-(2.4), expanded to nonzero representatives. Sesquilinearity gives <a*x,b*y>=conj(a)*b*<x,y>; norm multiplicativity gives the common numerator/denominator factor |a|^2 |b|^2, which is positive and cancels. This also proves the expression agrees with unit representatives. No chosen representative defines a public ray function before this independence is proved.

## normalized_correspondence

Every nonzero x has unit representative x/||x||; normalized scalar multiples differ by a/|a|, of modulus one. Conversely a phase multiple is a nonzero scalar multiple. Thus nonzero-vector projectivization and source unit-vector phase classes describe the same states, with the same P. This is the carrier bridge for source II (2.1)-(2.4) and the approved root. It consumes scalar invariance and norm/scalar arithmetic. A full operator-projector formalization is not required for this ray presentation.

## zero_probability

For nonzero x,y, P(x,y)=0 iff <x,y>=0: the denominator is positive and a complex number has zero norm iff it is zero. This expands source III Step 1, (3.2), where probability preservation turns orthogonal basis states into orthogonal states.

## image_orthogonality

Given the root's preservation premise, nonzero x,y,x',y' with f[x]=[x'], f[y]=[y'], and <x,y>=0, conclude <x',y'>=0. Apply preservation and zero_probability at both pairs. No vector lift is assumed; output representatives exist because f takes values in the quotient of nonzero vectors. This is source III Step 1, (3.2), as a separate obligation.

## dimension_zero

If dim_C E=0 then every vector is zero, so there are no rays. Every ray self-map equals the ray map of the identity linear isometric equivalence. The preservation and bijectivity premises are vacuous. This is the author-approved empty-state extension; finite-dimensional dimension-zero/subsingleton linear algebra is an external foundation.

## dimension_one

If dim_C E=1 then all nonzero vectors are scalar multiples and ray space has one element. Every ray self-map is induced by identity. Both branches may implement it, so branch exclusivity is not claimed. This is a degenerate case separate from source III's selection of two distinct coordinates. It uses finite-dimensional basis/linear-dependence facts and projective equality under nonzero scaling.

## orthonormal_basis

For dim_C E=n>=2 choose an orthonormal basis e_1,...,e_n using finite-dimensional inner-product linear algebra. This choice is internal. Mathlib's standard finite orthonormal basis and finite Parseval identity may be reused; they are not Wigner's theorem.

## image_basis

Choose unit representatives g_j of f[e_j]. They are pairwise orthogonal by image_orthogonality and have norm one by normalized_correspondence. An orthonormal family of n vectors in dimension n is a basis. The unit representatives are independent choices at this stage; no coherent phases have been assumed. This expands source III (3.2)-(3.3). The basis-completeness argument is substantive even though compressed in the paper.

## basis_normalization

Construct the unitary B sending g_j to e_j and replace f by its composition with B's ray action. Linear isometries preserve P by inner-product preservation. The resulting map fixes every basis ray, is still a ray bijection, and preserves all probabilities. Source III (3.3)-(3.5). It consumes image_basis, the induced-ray map of injective semilinear maps, and standard orthonormal-basis equivalences.

## coordinate_magnitudes

For a unit x with normalized-map image ray represented by unit y, basis-ray tests give |<e_j,y>|^2=|<e_j,x>|^2 for every j, hence coordinate magnitudes and support coincide. Source III (3.6). This consumes basis_normalization and the probability formula. In particular vectors supported on a coordinate pair stay on that pair; zeros remain zero.

## pair_circle

Fix j<k and one nondegenerate latitude, for example unit vectors (e_j+z e_k)/sqrt(2) with |z|=1. Coordinate magnitudes identify the output by a unique circle parameter z' after its first coefficient is fixed positive. Probability preservation yields Re(conj(z_1') z_2')=Re(conj(z_1) z_2). Therefore there is one a_jk of modulus one and one sign eps_jk in {+1,-1} such that z'=a_jk*z or a_jk*conj(z) for every circle parameter. Source III (3.7)-(3.11). SOURCE_GAP: the source states circle classification briefly; a formal proof must establish a single sign for the whole circle, not choose a sign separately for each input. Real planar isometry/elementary complex-coordinate algebra is the allowed foundation, not a Wigner theorem. Restricting to one latitude is enough for the later arbitrary-vector tests.

## diagonal_normalization

Choose a diagonal unitary that removes the phase offsets a_1k for every k>1. Compose it with the basis-normalized map. The basis rays and coordinate magnitudes remain fixed; pair signs remain well defined. Source III (3.12)-(3.16). This consumes pair_circle and the unitary action used at basis_normalization.

## full_support_real_test

Choose one normalized real vector with every coordinate nonzero. Comparing it with all pair-circle probes shows each residual phase offset is the difference of the corresponding output coordinate phases. Offsets on pairs (1,k) already vanish, so these output phases all agree and every residual pair offset vanishes. Source III (3.17)-(3.22). The chosen full-support vector is an internal finite-dimensional construction; it is not a hypothesis on arbitrary input states. This consumes diagonal_normalization, coordinate_magnitudes, and all-pair probability preservation.

## pair_products

For arbitrary unit input x and any unit representative y of its twice-normalized image ray, comparisons with the fixed pair-circle probes for all circle parameters imply c'_j*conj(c'_k)=c_j*conj(c_k) when eps_jk=+1, and the conjugate of that product when eps_jk=-1. Source III (3.23)-(3.24). The sign is the one already fixed on the circle, independent of x. Zero coordinate products are included: comparison first yields real and imaginary parts; it does not divide by c_j or c_k. This consumes full_support_real_test and coordinate_magnitudes.

## triple_consistency

For three distinct coordinates with nonzero amplitudes, the cyclic product (c_j*conj(c_k))*(c_k*conj(c_l))*(c_l*conj(c_j)) equals |c_j*c_k*c_l|^2 and is nonnegative real. Applying pair_products for arbitrary choices of the three phases forces the three pair signs to agree. Source III (3.25)-(3.28). SOURCE_GAP: expand the source's mixed-sign contradiction algebraically; a suggested finite test puts i in a suitable one of the three coordinates and 1 in the other two, then normalizes, producing a negative transformed cyclic product when signs disagree. This suggestion needs its own derivation; it is not assumed. Merely checking reality would be insufficient. This consumes pair_products and elementary complex arithmetic.

## global_branch

In dimension at least three, overlapping triples connect all coordinate pairs, so triple_consistency yields one sign for the entire finite basis. In dimension two there is exactly one pair and its sign from pair_circle already is global. Source III Step 6 and the elementary n=2 specialization. SOURCE_GAP: make the finite-index connectivity argument and n=2 split explicit; do not infer them from a count of local signs. This consumes triple_consistency in n>=3 and the fixed pair sign in n=2.

## sparse_reconstruction

Once one sign applies to all pair products, show every unit y representing the normalized image equals a unit-phase multiple of x (positive branch) or of coordinate conjugation of x (negative branch). Choose an index where that particular x has a nonzero coordinate, fix that phase, and recover each other coordinate from its product with the chosen one; support equality covers zero coordinates. Source III (3.24)-(3.28), explicit expansion of the final reconstruction. SOURCE_GAP: spell out this per-vector nonzero-coordinate argument; a fixed-index division or full-support-only result is insufficient. This consumes pair_products, coordinate_magnitudes, and global_branch.

## conjugation_operator

In the chosen orthonormal basis, K sends coefficients c_j to conj(c_j). Finite sum algebra proves additivity and conjugate scalar action; Parseval gives norm preservation; K^2=id gives bijectivity. This implements coordinate conjugation as a genuine antiunitary equivalence, source II after (2.14) and source III conclusion. This uses only orthonormal_basis and ordinary complex/finite-sum facts.

## denormalization

Undo the two unitary normalizations. In the positive branch their inverse composition is unitary; in the negative branch compose it with K to obtain antiunitary. sparse_reconstruction proves equality with f on every ray. Source III (3.25)-(3.28) and II (2.11)-(2.14). This consumes basis_normalization, diagonal_normalization, sparse_reconstruction, conjugation_operator, and composition/inverse laws of (semi)linear isometric equivalences.

## external_foundations

Allowed external inputs, not hidden root premises: complex norm/sesquilinearity arithmetic; nonzero quotient representatives and scalar-orbit equality; finite-dimensional basis existence and orthonormal-family completeness; finite Parseval; linear isometries preserve inner products; semilinear isometry equivalence composition and inverse. These should be explicit external graph leaves or dependencies of the corresponding constructions. Root inputs stay exactly those in the approved theorem. Conditional intermediate premises must be discharged at each consumer rather than copied into the root.

## exclusions

Excluded: source background history, mixed-state channels, infinite-dimensional extensions, the second/inductive Section V proof, uniqueness/branch exclusivity, and the non-bijective strengthening. They are not needed for the selected root. Gehér's alternative and its candidate sign erratum remain comparison material outside this direct-route graph. No zero/default extension of a ray probability definition is introduced.
