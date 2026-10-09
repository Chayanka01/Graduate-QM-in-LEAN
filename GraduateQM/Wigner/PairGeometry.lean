/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.PiL2
public import Mathlib.Analysis.Complex.Circle
public import Mathlib.LinearAlgebra.Projectivization.Basic
import Mathlib.Tactic.Ring

/-!
# Geometry of a pair of orthonormal coordinates

Elementary groundwork for `pair_circle` in `docs/wigner/PROOF_SOURCE.md`.
The representatives `b j + z • b k` differ from source III's unit vectors by
the common factor `√2`. The explicit probability denominator accounts for
this factor. No ray map or classification of circle maps is constructed here.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]
variable (b : OrthonormalBasis ι ℂ E) {j k : ι} (hjk : j ≠ k)

include hjk

/-- The first coordinate of the pair representative is exactly one. -/
theorem inner_pair_left (z : ℂ) : ⟪b j, b j + z • b k⟫_ℂ = 1 := by
  simp only [inner_add_right, inner_smul_right, b.inner_eq_one,
    b.inner_eq_zero hjk, mul_zero, add_zero]

/-- The second coordinate of the pair representative is its parameter. -/
theorem inner_pair_right (z : ℂ) : ⟪b k, b j + z • b k⟫_ℂ = z := by
  simp only [inner_add_right, inner_smul_right, b.inner_eq_one,
    b.inner_eq_zero hjk.symm, mul_one, zero_add]

/-- The constant first coordinate makes every pair representative nonzero. -/
theorem pair_ne_zero (z : ℂ) : b j + z • b k ≠ 0 := by
  intro h
  have hcoord := inner_pair_left b hjk z
  rw [h, inner_zero_right] at hcoord
  exact zero_ne_one hcoord

/-- Circle parameters give pair representatives of squared norm two. -/
theorem pair_norm_sq (z : Circle) : ‖b j + (z : ℂ) • b k‖ ^ 2 = 2 := by
  rw [norm_add_sq (𝕜 := ℂ)]
  simp only [inner_smul_right, b.inner_eq_zero hjk, mul_zero, map_zero,
    b.norm_eq_one, norm_smul, Circle.norm_coe, one_mul, one_pow, add_zero]
  norm_num

/-- The inner product of pair representatives records their relative phase. -/
theorem inner_pair_pair (z w : ℂ) :
    ⟪b j + z • b k, b j + w • b k⟫_ℂ = 1 + star z * w := by
  rw [inner_add_left, inner_smul_left, inner_pair_left b hjk,
    inner_pair_right b hjk]
  rfl

/-- The explicit representative probability is the affine rescaling of the
real part of the relative circle phase. -/
theorem pair_probability (z w : Circle) :
    ‖⟪b j + (z : ℂ) • b k, b j + (w : ℂ) • b k⟫_ℂ‖ ^ 2 /
      (‖b j + (z : ℂ) • b k‖ ^ 2 * ‖b j + (w : ℂ) • b k‖ ^ 2) =
      (1 + (star (z : ℂ) * (w : ℂ)).re) / 2 := by
  rw [inner_pair_pair b hjk, pair_norm_sq b hjk, pair_norm_sq b hjk,
    ← Complex.normSq_eq_norm_sq, Complex.normSq_add]
  have hnorm : Complex.normSq (star (z : ℂ) * (w : ℂ)) = 1 := by
    rw [Complex.normSq_eq_norm_sq, norm_mul, norm_star, Circle.norm_coe,
      Circle.norm_coe, one_mul, one_pow]
  rw [hnorm]
  simp only [Complex.normSq_one, one_mul, Complex.conj_re]
  ring

/-- A pair ray whose first coordinate is fixed to one has a unique circle
parameter. -/
theorem pair_mk_eq_iff (z w : Circle) :
    Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z) =
      Projectivization.mk ℂ (b j + (w : ℂ) • b k) (pair_ne_zero b hjk w) ↔ z = w := by
  constructor
  · intro h
    obtain ⟨a, ha⟩ := (Projectivization.mk_eq_mk_iff' ℂ _ _ _ _).mp h
    have hfirst := congrArg (fun v => ⟪b j, v⟫_ℂ) ha
    simp only [inner_smul_right, inner_pair_left b hjk, mul_one] at hfirst
    have hsecond := congrArg (fun v => ⟪b k, v⟫_ℂ) ha
    simp only [inner_smul_right, inner_pair_right b hjk, hfirst, one_mul] at hsecond
    exact Circle.ext hsecond.symm
  · rintro rfl
    rfl

end GraduateQM.Wigner
