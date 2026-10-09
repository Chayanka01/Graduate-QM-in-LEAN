/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.PairProducts
public import GraduateQM.Wigner.UnitRepresentatives
public import GraduateQM.Wigner.SignCoherence
import Mathlib.Analysis.Normed.Module.RCLike.Basic
import Mathlib.Tactic.Ring

/-!
# One global branch for coordinate products

The actual zero-offset circle actions supply pair signs. Arbitrary coordinate
families are realized by vectors, normalized for the ray tests, and rescaled
after choosing unit image representatives. Algebraic sign coherence then gives
one product-preserving or product-conjugating branch before all states and pairs.
This implements the `global_branch` consumption of `triple_consistency` in
`docs/wigner/PROOF_SOURCE.md`, including the degenerate index cases.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]

/-- A probability-preserving map fixing basis rays and having zero offsets on
all pair circles has one common coordinate-product branch for all unit states.
No bijectivity, dimensional lower bound, or support condition is assumed. -/
theorem coordinate_products_global_branch (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2))
    (h_basis : ∀ i, f (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
      Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i))
    (h_pairs : ∀ (j k : ι) (hjk : j ≠ k),
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) ∨
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + ((z⁻¹ : Circle) : ℂ) • b k)
            (pair_ne_zero b hjk z⁻¹))) :
    (∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0), ‖x‖ = 1 → ‖y‖ = 1 →
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
      ∀ j k, ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        ⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ) ∨
    (∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0), ‖x‖ = 1 → ‖y‖ = 1 →
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
      ∀ j k, ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        star (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ)) := by
  classical
  have hex (j k : ι) : ∃ e : Bool, ∀ hjk : j ≠ k,
      if e then
        (∀ z : Circle,
          f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z))
      else
        (∀ z : Circle,
          f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + ((z⁻¹ : Circle) : ℂ) • b k)
              (pair_ne_zero b hjk z⁻¹)) := by
    by_cases hjk : j = k
    · exact ⟨true, fun hne => False.elim (hne hjk)⟩
    · rcases h_pairs j k hjk with hrot | href
      · exact ⟨true, fun _ => hrot⟩
      · exact ⟨false, fun _ => href⟩
  choose ε hε using hex
  have hself (x y : E) (hx : x ≠ 0) (hy : y ≠ 0) (hxunit : ‖x‖ = 1)
      (hyunit : ‖y‖ = 1)
      (h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy) (i : ι) :
      ⟪b i, y⟫_ℂ * star ⟪b i, y⟫_ℂ = ⟪b i, x⟫_ℂ * star ⟪b i, x⟫_ℂ := by
    have h := coordinate_norm_sq_eq_of_fixed_basis b f h_probability h_basis
      hx hy hxunit hyunit h_image i
    simp only [Complex.star_def, Complex.mul_conj']
    exact_mod_cast h
  have hunit (x y : E) (hx : x ≠ 0) (hy : y ≠ 0) (hxunit : ‖x‖ = 1)
      (hyunit : ‖y‖ = 1)
      (h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy) (j k : ι) :
      ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        if ε j k then ⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ
        else star (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ) := by
    by_cases hjk : j = k
    · subst k
      rw [hself x y hx hy hxunit hyunit h_image j]
      split <;> simp only [star_mul', star_star, mul_comm]
    · have haction := hε j k hjk
      by_cases he : ε j k = true
      · rw [ite_eq_left he] at haction ⊢
        simpa only [Circle.coe_one, star_one, one_mul] using
          coordinate_product_of_pair_rotation b f h_probability h_basis hjk
            hx hy hxunit hyunit h_image 1 (by simpa only [one_mul] using haction)
      · rw [ite_eq_right he] at haction ⊢
        simpa only [Circle.coe_one, star_one, one_mul] using
          coordinate_product_of_pair_reflection b f h_probability h_basis hjk
            hx hy hxunit hyunit h_image 1 (by simpa only [one_mul] using haction)
  have h_lift (c : ι → ℂ) : ∃ d : ι → ℂ, ∀ j k,
      d j * star (d k) = if ε j k then c j * star (c k) else star (c j * star (c k)) := by
    let x : E := b.repr.symm (WithLp.toLp 2 c)
    have hxcoord (i : ι) : ⟪b i, x⟫_ℂ = c i := by
      rw [← b.repr_apply_apply]
      change (b.repr (b.repr.symm (WithLp.toLp 2 c))) i = c i
      rw [LinearIsometryEquiv.apply_symm_apply]
    by_cases hx : x = 0
    · have hc (i : ι) : c i = 0 := by
        rw [← hxcoord i, hx, inner_zero_right]
      refine ⟨fun _ => 0, ?_⟩
      intro j k
      simp only [hc, star_zero, mul_zero, ite_self]
    · let u : E := (‖x‖⁻¹ : ℂ) • x
      have huunit : ‖u‖ = 1 := norm_smul_inv_norm hx
      have hu : u ≠ 0 := norm_ne_zero_iff.mp (by rw [huunit]; exact one_ne_zero)
      obtain ⟨y, hy, hyunit, hymk⟩ :=
        exists_unit_representative (f (Projectivization.mk ℂ u hu))
      have hreal : star (‖x‖ : ℂ) = (‖x‖ : ℂ) := Complex.conj_ofReal _
      have hscaled (i : ι) : (‖x‖ : ℂ) * ⟪b i, u⟫_ℂ = c i := by
        simp only [u, inner_smul_right, hxcoord, ← mul_assoc]
        rw [mul_inv_cancel₀ (Complex.ofReal_ne_zero.mpr (norm_ne_zero_iff.mpr hx)), one_mul]
      have hscaledprod (j k : ι) :
          (‖x‖ : ℂ) ^ 2 * (⟪b j, u⟫_ℂ * star ⟪b k, u⟫_ℂ) = c j * star (c k) := by
        calc
          _ = ((‖x‖ : ℂ) * ⟪b j, u⟫_ℂ) * star ((‖x‖ : ℂ) * ⟪b k, u⟫_ℂ) := by
            rw [star_mul', hreal]
            ring
          _ = _ := by rw [hscaled, hscaled]
      refine ⟨fun i => (‖x‖ : ℂ) * ⟪b i, y⟫_ℂ, ?_⟩
      intro j k
      calc
        _ = (‖x‖ : ℂ) ^ 2 * (⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ) := by
          rw [star_mul', hreal]
          ring
        _ = _ := by
          rw [hunit u y hu hy huunit hyunit hymk.symm j k]
          split
          · exact hscaledprod j k
          · rw [← hscaledprod j k]
            simp only [star_mul', star_pow, hreal]
  rcases signs_uniform_of_coordinate_lifts ε h_lift with hpos | hneg
  · left
    intro x y hx hy hxunit hyunit h_image j k
    by_cases hjk : j = k
    · subst k
      exact hself x y hx hy hxunit hyunit h_image j
    · simpa only [hpos j k hjk, ↓reduceIte] using hunit x y hx hy hxunit hyunit h_image j k
  · right
    intro x y hx hy hxunit hyunit h_image j k
    by_cases hjk : j = k
    · subst k
      rw [hself x y hx hy hxunit hyunit h_image j]
      rw [star_mul', star_star, mul_comm]
    · simpa only [hneg j k hjk, Bool.false_eq_true, ↓reduceIte] using
        hunit x y hx hy hxunit hyunit h_image j k

end GraduateQM.Wigner
