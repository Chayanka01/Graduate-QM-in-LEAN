/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Algebra.Star.Module

/-!
# Antiunitary coordinate conjugation

Conjugating the coordinates in an orthonormal basis gives a conjugate-linear
isometric equivalence whose square is the identity. This implements
`conjugation_operator` in the Wigner proof source. The construction also works
for an empty basis and uses no projective symmetry theorem.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

/-- Every finite orthonormal basis determines an involutive antiunitary that
conjugates precisely its complex coordinates. -/
theorem exists_coordinate_conjugation {ι E : Type*} [Fintype ι]
    [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    (b : OrthonormalBasis ι ℂ E) :
    ∃ K : E ≃ₗᵢ⋆[ℂ] E,
      (∀ x i, ⟪b i, K x⟫_ℂ = star ⟪b i, x⟫_ℂ) ∧
      (∀ x, K (K x) = x) := by
  let e : EuclideanSpace ℂ ι ≃ₗ⋆[ℂ] EuclideanSpace ℂ ι :=
    LinearEquiv.withLpCongr 2 (starLinearEquiv ℂ : (ι → ℂ) ≃ₗ⋆[ℂ] (ι → ℂ))
  have he (v : EuclideanSpace ℂ ι) (i : ι) : e v i = star (v i) := rfl
  let C : EuclideanSpace ℂ ι ≃ₗᵢ⋆[ℂ] EuclideanSpace ℂ ι :=
    { toLinearEquiv := e
      norm_map' := by
        intro v
        simp only [EuclideanSpace.norm_eq, he, norm_star] }
  let K : E ≃ₗᵢ⋆[ℂ] E := (b.repr.trans C).trans b.repr.symm
  have hK (x : E) (i : ι) : ⟪b i, K x⟫_ℂ = star ⟪b i, x⟫_ℂ := by
    change ⟪b i, b.repr.symm (C (b.repr x))⟫_ℂ = _
    rw [← b.repr_apply_apply, b.repr.apply_symm_apply]
    exact (he (b.repr x) i).trans (congrArg star (b.repr_apply_apply x i))
  refine ⟨K, hK, fun x => ?_⟩
  apply b.repr.injective
  apply PiLp.ext
  intro i
  rw [b.repr_apply_apply, b.repr_apply_apply, hK, hK, star_star]

end GraduateQM.Wigner
