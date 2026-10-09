/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.PairGeometry
public import GraduateQM.Wigner.CoordinateMagnitudes
import Mathlib.Tactic.Linarith
import Mathlib.Tactic.Ring

/-!
# Coordinate products from pair-circle probes

Conditional pair tests recover products of arbitrary state coordinates, with
no division by those coordinates. The phase offset is retained explicitly;
setting it to one gives the zero-offset identities of source III (3.24).
Producing the assumed pair action is a separate source obligation.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

private theorem norm_sq_pair_probe (c d : ℂ) (z : Circle) :
    ‖c + star (z : ℂ) * d‖ ^ 2 =
      ‖c‖ ^ 2 + ‖d‖ ^ 2 + 2 * ((z : ℂ) * (c * star d)).re := by
  simp only [← Complex.normSq_eq_norm_sq, Complex.normSq_add,
    Complex.star_def, Complex.normSq_conj, Circle.normSq_coe, one_mul,
    map_mul, starRingEnd_self_apply]
  congr 2
  congr 1
  ring

private theorem complex_eq_of_circle_re_tests (s t : ℂ)
    (h : ∀ z : Circle, ((z : ℂ) * s).re = ((z : ℂ) * t).re) : s = t := by
  apply Complex.ext
  · simpa only [Circle.coe_one, one_mul] using h 1
  · let i : Circle := ⟨Complex.I, mem_sphere_zero_iff_norm.mpr Complex.norm_I⟩
    have hi : (i : ℂ) = Complex.I := rfl
    have ht := h i
    simp only [hi, Complex.mul_re, Complex.I_re, Complex.I_im, zero_mul,
      one_mul, zero_sub] at ht
    exact neg_injective ht

private theorem circle_product_cancel (a : Circle) (s t : ℂ)
    (h : (a : ℂ) * s = t) : s = star (a : ℂ) * t := by
  have ha : star (a : ℂ) * (a : ℂ) = 1 := by
    rw [Complex.star_def, ← Complex.normSq_eq_conj_mul_self,
      Circle.normSq_coe, Complex.ofReal_one]
  rw [← h, ← mul_assoc, ha, one_mul]

variable {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]
variable (b : OrthonormalBasis ι ℂ E)
  (f : Projectivization ℂ E → Projectivization ℂ E)
  (h_probability : ∀ (x y x' y' : E)
    (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
    f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
    f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
    ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
      ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2))
  (h_basis : ∀ i, f (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
    Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i))
  {j k : ι} (hjk : j ≠ k)
  {x y : E} (hx : x ≠ 0) (hy : y ≠ 0)
  (hx_unit : ‖x‖ = 1) (hy_unit : ‖y‖ = 1)
  (h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy)

include h_probability h_basis hx_unit hy_unit h_image

private theorem coordinate_cross_re_eq (z w : Circle)
    (h_pair : f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
      Projectivization.mk ℂ (b j + (w : ℂ) • b k) (pair_ne_zero b hjk w)) :
    ((w : ℂ) * (⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ)).re =
      ((z : ℂ) * (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ)).re := by
  have hp := h_probability (b j + (z : ℂ) • b k) x
    (b j + (w : ℂ) • b k) y (pair_ne_zero b hjk z) hx (pair_ne_zero b hjk w) hy
    h_pair h_image
  simp only [pair_norm_sq b hjk, hx_unit, hy_unit, one_pow, mul_one,
    inner_add_left, inner_smul_left] at hp
  change ‖⟪b j, y⟫_ℂ + star (w : ℂ) * ⟪b k, y⟫_ℂ‖ ^ 2 / 2 =
    ‖⟪b j, x⟫_ℂ + star (z : ℂ) * ⟪b k, x⟫_ℂ‖ ^ 2 / 2 at hp
  rw [norm_sq_pair_probe, norm_sq_pair_probe] at hp
  have hj := coordinate_norm_sq_eq_of_fixed_basis b f h_probability h_basis
    hx hy hx_unit hy_unit h_image j
  have hk := coordinate_norm_sq_eq_of_fixed_basis b f h_probability h_basis
    hx hy hx_unit hy_unit h_image k
  linarith only [hp, hj, hk]

/-- A rotating pair action determines every unit state's coordinate product,
including states whose tested coordinates vanish. The offset contributes its
complex conjugate because the first inner-product slot is conjugate-linear. -/
theorem coordinate_product_of_pair_rotation (a : Circle)
    (h_action : ∀ z : Circle,
      f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
        Projectivization.mk ℂ (b j + ((a * z : Circle) : ℂ) • b k)
          (pair_ne_zero b hjk (a * z))) :
    ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
      star (a : ℂ) * (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ) := by
  apply circle_product_cancel
  apply complex_eq_of_circle_re_tests
  intro z
  have hz := coordinate_cross_re_eq b f h_probability h_basis hjk hx hy
    hx_unit hy_unit h_image z (a * z) (h_action z)
  simpa only [Circle.coe_mul, mul_assoc, mul_left_comm (z : ℂ) (a : ℂ)] using hz

/-- A reflected pair action conjugates every unit state's coordinate product,
with the same explicit phase offset and no nonzero-coordinate assumption. -/
theorem coordinate_product_of_pair_reflection (a : Circle)
    (h_action : ∀ z : Circle,
      f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
        Projectivization.mk ℂ (b j + ((a * z⁻¹ : Circle) : ℂ) • b k)
          (pair_ne_zero b hjk (a * z⁻¹))) :
    ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
      star (a : ℂ) * star (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ) := by
  apply circle_product_cancel
  apply star_injective
  rw [star_star]
  apply complex_eq_of_circle_re_tests
  intro z
  have hz := coordinate_cross_re_eq b f h_probability h_basis hjk hx hy
    hx_unit hy_unit h_image z (a * z⁻¹) (h_action z)
  rw [Circle.coe_mul, Circle.coe_inv_eq_conj] at hz
  have heq : ((z : ℂ) * star ((a : ℂ) * (⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ))).re =
      ((a : ℂ) * (star (z : ℂ) * (⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ))).re := by
    simp only [Complex.star_def, Complex.mul_re, Complex.mul_im,
      Complex.conj_re, Complex.conj_im]
    ring
  rw [heq]
  simpa only [mul_assoc, Complex.star_def] using hz

end GraduateQM.Wigner
