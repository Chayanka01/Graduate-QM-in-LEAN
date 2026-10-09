/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.Basic
public import Mathlib.LinearAlgebra.Projectivization.Basic

/-!
# Representative probability and orthogonality

Elementary consequences of the explicit probability expression in the approved
Wigner statement. No probability function on rays or choice of representatives
is introduced. These implement `scalar_invariance`, `zero_probability`, and
`image_orthogonality` in `docs/wigner/PROOF_SOURCE.md`.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Nonzero rescaling of either representative leaves the probability expression
unchanged. The algebraic identity also holds when a vector is zero. -/
theorem probability_smul_smul (x y : E) {a b : ℂ} (ha : a ≠ 0) (hb : b ≠ 0) :
    ‖⟪a • x, b • y⟫_ℂ‖ ^ 2 / (‖a • x‖ ^ 2 * ‖b • y‖ ^ 2) =
      ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) := by
  simp only [inner_smul_left, inner_smul_right, norm_mul, RCLike.norm_conj,
    norm_smul, mul_pow]
  have hnum : ‖b‖ ^ 2 * (‖a‖ ^ 2 * ‖⟪x, y⟫_ℂ‖ ^ 2) =
      (‖a‖ ^ 2 * ‖b‖ ^ 2) * ‖⟪x, y⟫_ℂ‖ ^ 2 := by ac_rfl
  have hden : ‖a‖ ^ 2 * ‖x‖ ^ 2 * (‖b‖ ^ 2 * ‖y‖ ^ 2) =
      (‖a‖ ^ 2 * ‖b‖ ^ 2) * (‖x‖ ^ 2 * ‖y‖ ^ 2) := by ac_rfl
  rw [hnum, hden]
  exact mul_div_mul_left _ _
    (mul_ne_zero (pow_ne_zero _ (norm_ne_zero_iff.mpr ha))
      (pow_ne_zero _ (norm_ne_zero_iff.mpr hb)))

/-- For nonzero representatives, zero probability is exactly orthogonality. -/
theorem probability_eq_zero_iff {x y : E} (hx : x ≠ 0) (hy : y ≠ 0) :
    ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) = 0 ↔ ⟪x, y⟫_ℂ = 0 := by
  have hden : ‖x‖ ^ 2 * ‖y‖ ^ 2 ≠ 0 :=
    mul_ne_zero (pow_ne_zero _ (norm_ne_zero_iff.mpr hx))
      (pow_ne_zero _ (norm_ne_zero_iff.mpr hy))
  simp only [div_eq_zero_iff, hden, or_false, pow_eq_zero_iff (by decide : 2 ≠ 0),
    norm_eq_zero]

/-- The approved all-representative probability premise sends orthogonal
representatives to orthogonal representatives, without a vector lift. -/
theorem image_inner_eq_zero
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2))
    (x y x' y' : E) (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0)
    (hfx : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx')
    (hfy : f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy')
    (hxy : ⟪x, y⟫_ℂ = 0) : ⟪x', y'⟫_ℂ = 0 := by
  apply (probability_eq_zero_iff hx' hy').mp
  rw [h_probability x y x' y' hx hy hx' hy' hfx hfy]
  exact (probability_eq_zero_iff hx hy).mpr hxy

end GraduateQM.Wigner
