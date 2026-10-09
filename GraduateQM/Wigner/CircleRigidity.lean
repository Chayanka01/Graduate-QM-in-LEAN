/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.Complex.Circle
import Mathlib.Tactic.Linarith

/-!
# Rigidity of the real inner product on the circle

A circle map preserving `Re(conj(z) * w)` has a single phase offset and one
global choice of orientation. Inversion on `Circle` is complex conjugation by
`Circle.coe_inv_eq_conj`. This is the abstract classification needed in
`pair_circle` of the Wigner proof source; construction of the circle map from
the ray transformation is a separate obligation.
-/

public section

namespace GraduateQM.Wigner

private theorem circle_star_mul_left (a z w : Circle) :
    star ((a * z : Circle) : ℂ) * ((a * w : Circle) : ℂ) =
      star (z : ℂ) * (w : ℂ) := by
  have ha : star (a : ℂ) * (a : ℂ) = 1 := by
    rw [Complex.star_def, ← Complex.normSq_eq_conj_mul_self, Circle.normSq_coe,
      Complex.ofReal_one]
  simp only [Circle.coe_mul, star_mul]
  calc
    _ = (star (a : ℂ) * (a : ℂ)) * (star (z : ℂ) * (w : ℂ)) := by ac_rfl
    _ = _ := by rw [ha, one_mul]

private theorem circle_eq_self_or_inv_of_preserving_re_one
    (F : Circle → Circle)
    (h : ∀ z w : Circle,
      (star (F z : ℂ) * (F w : ℂ)).re = (star (z : ℂ) * (w : ℂ)).re)
    (h_one : F 1 = 1) :
    (∀ z, F z = z) ∨ (∀ z, F z = z⁻¹) := by
  let i : Circle := ⟨Complex.I, mem_sphere_zero_iff_norm.mpr Complex.norm_I⟩
  have hi : (i : ℂ) = Complex.I := rfl
  have hre (z : Circle) : (F z : ℂ).re = (z : ℂ).re := by
    simpa only [h_one, Circle.coe_one, star_one, one_mul] using h 1 z
  have hri : (F i : ℂ).re = 0 := by
    rw [hre, hi, Complex.I_re]
  have hsq : (F i : ℂ).im * (F i : ℂ).im = 1 := by
    simpa only [Complex.normSq_apply, hri, zero_mul, zero_add] using
      Circle.normSq_coe (F i)
  rcases mul_self_eq_one_iff.mp hsq with hsign | hsign
  · left
    intro z
    apply Circle.ext
    apply Complex.ext (hre z)
    have hz := h i z
    simp only [Complex.star_def, Complex.mul_re, Complex.conj_re, Complex.conj_im,
      hi, Complex.I_re, Complex.I_im, hri, hsign] at hz
    linarith only [hz]
  · right
    intro z
    apply Circle.ext
    rw [Circle.coe_inv_eq_conj]
    apply Complex.ext
    · rw [Complex.conj_re, hre]
    · have hz := h i z
      simp only [Complex.star_def, Complex.mul_re, Complex.conj_re, Complex.conj_im,
        hi, Complex.I_re, Complex.I_im, hri, hsign] at hz
      rw [Complex.conj_im]
      linarith only [hz]

/-- Preservation of the real Hermitian product on the circle forces one global
rotation or reflected rotation. Neither continuity nor bijectivity is assumed.
The inverse in the second branch is complex conjugation on unit complex numbers. -/
theorem exists_circle_mul_or_mul_inv_of_preserving_re
    (F : Circle → Circle)
    (h : ∀ z w : Circle,
      (star (F z : ℂ) * (F w : ℂ)).re = (star (z : ℂ) * (w : ℂ)).re) :
    ∃ a : Circle, (∀ z, F z = a * z) ∨ (∀ z, F z = a * z⁻¹) := by
  let G : Circle → Circle := fun z => (F 1)⁻¹ * F z
  have hG : ∀ z w : Circle,
      (star (G z : ℂ) * (G w : ℂ)).re = (star (z : ℂ) * (w : ℂ)).re := by
    intro z w
    change (star (((F 1)⁻¹ * F z : Circle) : ℂ) *
      (((F 1)⁻¹ * F w : Circle) : ℂ)).re = _
    rw [circle_star_mul_left]
    exact h z w
  have hG_one : G 1 = 1 := inv_mul_cancel (F 1)
  refine ⟨F 1, ?_⟩
  rcases circle_eq_self_or_inv_of_preserving_re_one G hG hG_one with hpos | hneg
  · left
    intro z
    have hz := congrArg (fun t : Circle => F 1 * t) (hpos z)
    simpa only [G, mul_inv_cancel_left] using hz
  · right
    intro z
    have hz := congrArg (fun t : Circle => F 1 * t) (hneg z)
    simpa only [G, mul_inv_cancel_left] using hz

end GraduateQM.Wigner
