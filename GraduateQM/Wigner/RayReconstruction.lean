/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.LinearAlgebra.Projectivization.Basic

/-!
# Ray reconstruction from reference-coordinate products

An algebraic helper for `sparse_reconstruction` and the intermediate
`full_support_real_test` argument in `docs/wigner/PROOF_SOURCE.md`.
The reference coordinate is nonzero for the particular input vector. Every
other coordinate may vanish. This lemma does not produce the product identities
from a ray map or assert completion of either source node.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

/-- One row of coordinate products determines the ray whenever its input
reference coordinate is nonzero. No full-support or unit-norm premise is needed. -/
theorem mk_eq_of_reference_products
    {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]
    (b : OrthonormalBasis ι ℂ E) (x y : E) (hx : x ≠ 0) (hy : y ≠ 0)
    (r : ι) (hxr : ⟪b r, x⟫_ℂ ≠ 0)
    (h_products : ∀ i, ⟪b r, y⟫_ℂ * star ⟪b i, y⟫_ℂ =
      ⟪b r, x⟫_ℂ * star ⟪b i, x⟫_ℂ) :
    Projectivization.mk ℂ x hx = Projectivization.mk ℂ y hy := by
  have hyr : ⟪b r, y⟫_ℂ ≠ 0 := by
    intro hzero
    have hself := h_products r
    rw [hzero, zero_mul] at hself
    exact (mul_ne_zero hxr (star_ne_zero.mpr hxr)) hself.symm
  let a : ℂ := star ⟪b r, x⟫_ℂ / star ⟪b r, y⟫_ℂ
  have hcoord (i : ι) : a * ⟪b i, x⟫_ℂ = ⟪b i, y⟫_ℂ := by
    have hstar := congrArg star (h_products i)
    simp only [star_mul', star_star] at hstar
    apply mul_left_cancel₀ (star_ne_zero.mpr hyr)
    change star ⟪b r, y⟫_ℂ *
      ((star ⟪b r, x⟫_ℂ / star ⟪b r, y⟫_ℂ) * ⟪b i, x⟫_ℂ) =
      star ⟪b r, y⟫_ℂ * ⟪b i, y⟫_ℂ
    rw [← mul_assoc, mul_div_cancel₀ _ (star_ne_zero.mpr hyr)]
    exact hstar.symm
  have hvec : a • x = y := by
    apply b.repr.injective
    ext i
    simpa only [map_smul, PiLp.smul_apply, smul_eq_mul, b.repr_apply_apply] using hcoord i
  exact ((Projectivization.mk_eq_mk_iff' ℂ y x hy hx).mpr ⟨a, hvec⟩).symm

end GraduateQM.Wigner
