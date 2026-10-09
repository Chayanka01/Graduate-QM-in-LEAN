/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.RayProbability
import Mathlib.Analysis.Normed.Module.RCLike.Basic

/-!
# Unit representatives of complex rays

Every ray admits a unit representative. Equality of rays preserves the inline
probability expression, and equality of unit-vector rays is exactly equality up
to a scalar of modulus one. These give the operational carrier bridge in
`normalized_correspondence` of `docs/wigner/PROOF_SOURCE.md` and the representative
existence needed by `image_basis`. No representative-selection function is defined.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Every complex ray admits a nonzero representative of norm one. -/
theorem exists_unit_representative (p : Projectivization ℂ E) :
    ∃ (x : E) (hx : x ≠ 0), ‖x‖ = 1 ∧ Projectivization.mk ℂ x hx = p := by
  let x : E := (‖p.rep‖⁻¹ : ℂ) • p.rep
  have hnorm : ‖x‖ = 1 := norm_smul_inv_norm p.rep_nonzero
  have hx : x ≠ 0 := by
    intro hzero
    have h : (0 : ℝ) = 1 := by simpa only [hzero, norm_zero] using hnorm
    exact zero_ne_one h
  refine ⟨x, hx, hnorm, ?_⟩
  rw [← p.mk_rep]
  exact (Projectivization.mk_eq_mk_iff' ℂ x p.rep hx p.rep_nonzero).mpr
    ⟨(‖p.rep‖⁻¹ : ℂ), rfl⟩

/-- Replacing both nonzero representatives by equal rays preserves the explicit
probability expression. -/
theorem probability_eq_of_mk_eq (x y x' y' : E)
    (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0)
    (hxx' : Projectivization.mk ℂ x hx = Projectivization.mk ℂ x' hx')
    (hyy' : Projectivization.mk ℂ y hy = Projectivization.mk ℂ y' hy') :
    ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) =
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) := by
  obtain ⟨a, ha⟩ := (Projectivization.mk_eq_mk_iff ℂ x x' hx hx').mp hxx'
  obtain ⟨b, hb⟩ := (Projectivization.mk_eq_mk_iff ℂ y y' hy hy').mp hyy'
  have ha' : (a : ℂ) • x' = x := ha
  have hb' : (b : ℂ) • y' = y := hb
  rw [← ha', ← hb']
  exact probability_smul_smul x' y' a.ne_zero b.ne_zero

/-- Two unit representatives determine the same ray exactly when the first is
a modulus-one scalar multiple of the second. -/
theorem mk_eq_mk_iff_exists_unit_phase (x y : E) (hx : x ≠ 0) (hy : y ≠ 0)
    (hnormx : ‖x‖ = 1) (hnormy : ‖y‖ = 1) :
    Projectivization.mk ℂ x hx = Projectivization.mk ℂ y hy ↔
      ∃ a : ℂ, ‖a‖ = 1 ∧ a • y = x := by
  constructor
  · intro h
    obtain ⟨a, ha⟩ := (Projectivization.mk_eq_mk_iff' ℂ x y hx hy).mp h
    refine ⟨a, ?_, ha⟩
    have hnorm := congrArg norm ha
    simpa only [norm_smul, hnormx, hnormy, mul_one] using hnorm
  · rintro ⟨a, _, ha⟩
    exact (Projectivization.mk_eq_mk_iff' ℂ x y hx hy).mpr ⟨a, ha⟩

/-- On unit representatives, the probability expression is the squared modulus
of the inner product. -/
theorem probability_eq_norm_inner_sq (x y : E) (hx : ‖x‖ = 1) (hy : ‖y‖ = 1) :
    ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) = ‖⟪x, y⟫_ℂ‖ ^ 2 := by
  simp only [hx, hy, one_pow, mul_one, div_one]

end GraduateQM.Wigner
