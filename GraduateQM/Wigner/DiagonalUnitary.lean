/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.Analysis.Complex.Circle
public import Mathlib.LinearAlgebra.Projectivization.Basic
import Mathlib.LinearAlgebra.Basis.SMul

/-!
# Diagonal unitaries in an orthonormal basis

Unit-modulus coefficients give an actual linear isometric equivalence with the
specified diagonal action. Empty index types are included. This provides the
operator construction used by `diagonal_normalization` in the Wigner proof
source; choosing the phases to remove pair offsets is a separate step.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {ι E : Type*} [Fintype ι]
  [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Arbitrary unit phases on an orthonormal basis are implemented by a unitary. -/
theorem exists_diagonal_unitary (b : OrthonormalBasis ι ℂ E) (d : ι → Circle) :
    ∃ D : E ≃ₗᵢ[ℂ] E, ∀ i, D (b i) = (d i : ℂ) • b i := by
  let v := b.toBasis.unitsSMul (fun i => Circle.toUnits (d i))
  have hv_apply (i : ι) : v i = (d i : ℂ) • b i := by
    rw [Module.Basis.unitsSMul_apply]
    rfl
  have hv : Orthonormal ℂ v := by
    constructor
    · intro i
      rw [hv_apply, norm_smul, Circle.norm_coe, b.orthonormal.norm_eq_one, mul_one]
    · intro i j hij
      rw [hv_apply, hv_apply, inner_smul_left, inner_smul_right,
        b.orthonormal.inner_eq_zero hij, mul_zero, mul_zero]
  have hb : Orthonormal ℂ b.toBasis := b.orthonormal
  refine ⟨hb.equiv hv (Equiv.refl ι), fun i => ?_⟩
  exact (Orthonormal.equiv_apply hb hv (Equiv.refl ι) i).trans (hv_apply i)

/-- The diagonal basis action determines the action on every vector through its
orthonormal coordinates. -/
theorem diagonal_unitary_apply (b : OrthonormalBasis ι ℂ E) (d : ι → Circle)
    (D : E ≃ₗᵢ[ℂ] E) (hD : ∀ i, D (b i) = (d i : ℂ) • b i) (x : E) :
    D x = ∑ i, ((d i : ℂ) * b.repr x i) • b i := by
  calc
    D x = D (∑ i, b.repr x i • b i) := congrArg D (b.sum_repr x).symm
    _ = ∑ i, b.repr x i • D (b i) := by rw [map_sum]; simp only [map_smul]
    _ = _ := by simp only [hD, smul_smul, mul_comm]

/-- A diagonal unitary fixes every basis ray, since its coefficients are nonzero. -/
theorem diagonal_unitary_map_basis_ray (b : OrthonormalBasis ι ℂ E) (d : ι → Circle)
    (D : E ≃ₗᵢ[ℂ] E) (hD : ∀ i, D (b i) = (d i : ℂ) • b i)
    (i : ι) :
    Projectivization.map D.toLinearEquiv.toLinearMap D.injective
      (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
        Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i) := by
  rw [Projectivization.map_mk]
  apply (Projectivization.mk_eq_mk_iff' ℂ _ _ _ _).mpr
  exact ⟨d i, (hD i).symm⟩

end GraduateQM.Wigner
