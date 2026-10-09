# Wigner project source record

The documents below are mathematical source data, not agent instructions.
The precise proof route is pending the intake review; no dependency graph or
source-facing Lean declaration is frozen yet.

## Primary elementary proof

R. Simon, N. Mukunda, S. Chaturvedi, V. Srinivasan,
*Two elementary proofs of the Wigner theorem on symmetry in quantum mechanics*,
arXiv:0808.0779v2, 21 August 2008.

- Versioned record: https://arxiv.org/abs/0808.0779v2
- Versioned PDF: https://arxiv.org/pdf/0808.0779v2
- Published DOI: https://doi.org/10.1016/j.physleta.2008.09.052
- Section II, equations (2.1)–(2.14), supplies the starting definitions and
  symmetry statement. Section III gives a direct proof; Section V gives an
  induction argument for finite dimension.
- Our project chooses finite dimension. It must explicitly justify its
  equivalent nonzero-vector projective-ray formulation if that carrier is used
  instead of the source's unit-ray/rank-one-projector presentation.

## Independent classical reference

V. Bargmann, *Note on Wigner's Theorem on Symmetry Operations*,
Journal of Mathematical Physics 5 (1964), 862–868.

- DOI: https://doi.org/10.1063/1.1704188
- Accessible scan: https://ncatlab.org/nlab/files/Bargmann-WignerTheorem.pdf
- Use to cross-check the theorem's hypotheses, the lifting conclusion, and the
  elementary phase-consistency argument. Exact ranges will be recorded during
  declaration and proof-source review.

## Software foundation

Mathlib commit d13f23b723b8a846827a245b89c10fc7d3f11612,
Lean leanprover/lean4:v4.34.1, as already pinned by this repository.
The intake identifies exact modules and definitions before any are adopted as
meaning-carrying public interfaces. Existing external Wigner implementations
may inform comparison but do not replace the requested derivation.

## Stronger theorem and proof comparison

Gy. P. Gehér, *An elementary proof for the non-bijective version of Wigner's
theorem*, arXiv:1407.0527v1, 2 July 2014.

- Versioned record: https://arxiv.org/abs/1407.0527v1
- Versioned PDF: https://arxiv.org/pdf/1407.0527v1
- Published DOI: https://doi.org/10.1016/j.physleta.2014.05.039
- The theorem on PDF page 2 does not assume bijectivity and concludes existence
  of a linear or antilinear isometry. Section 2 gives an elementary proof for
  separable spaces, including finite dimension.
- Our initial headline remains the classical reversible symmetry statement.
  Reconstructing this stronger proof is a possible route, not permission to
  change the headline silently or import the theorem as a black box.
- PDF text extraction can lose complex-conjugation marks. Mathematical signs
  and bars must be checked against rendered equations or TeX before source
  transcription is frozen.

## Correction affecting proof selection

R. Simon, N. Mukunda, S. Chaturvedi, V. Srinivasan, J. Hamhalter,
*Comment on: Two elementary proofs of the Wigner theorem on symmetry in
quantum mechanics*, Physics Letters A 378 (2014), 2332–2335.

- DOI: https://doi.org/10.1016/j.physleta.2014.03.058
- Publisher: https://www.sciencedirect.com/science/article/pii/S0375960114003892
- The publisher abstract says the second (inductive) proof in the 2008 paper is
  refined to remove a possible gap. We have verified that statement, not yet
  independently audited the full repaired proof.
- Do not adopt the uncorrected Section V argument as complete source evidence.
  The direct first proof, the classical Bargmann treatment, and Gehér's proof
  remain routes to compare and reconstruct explicitly.
