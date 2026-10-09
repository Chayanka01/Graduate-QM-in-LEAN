/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.ReferenceNormalization
public import GraduateQM.Wigner.FullSupportVector
public import GraduateQM.Wigner.PairProducts
public import GraduateQM.Wigner.RayReconstruction

/-!
# Elimination of every pair phase offset

One internally chosen positive real unit vector has a fixed ray once all
reference-pair offsets vanish. Its nonzero coordinate products then force every
other offset to vanish. This implements `full_support_real_test` in
`docs/wigner/PROOF_SOURCE.md`; arbitrary states are not assumed to have full
support. Pair orientations remain independent at this stage.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

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

include h_probability h_basis

/-- Pure rotation or reflection on all reference pairs forces every pair circle
to have zero offset. Each pair has one orientation valid for every parameter. -/
theorem pair_action_without_offsets (r : ι)
    (h_reference : ∀ (k : ι) (hrk : r ≠ k),
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) =
          Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) ∨
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) =
          Projectivization.mk ℂ (b r + ((z⁻¹ : Circle) : ℂ) • b k)
            (pair_ne_zero b hrk z⁻¹))) :
    ∀ (j k : ι) (hjk : j ≠ k),
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) ∨
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + ((z⁻¹ : Circle) : ℂ) • b k)
            (pair_ne_zero b hjk z⁻¹)) := by
  classical
  let : Nonempty ι := ⟨r⟩
  obtain ⟨t, htunit, htpos⟩ := exists_positive_unit_vector b
  have ht : t ≠ 0 := norm_ne_zero_iff.mp (by rw [htunit]; exact one_ne_zero)
  have htstar (i : ι) : star ⟪b i, t⟫_ℂ = ⟪b i, t⟫_ℂ := by
    apply Complex.ext
    · rfl
    · simp only [Complex.star_def, Complex.conj_im, (htpos i).1, neg_zero]
  have htcoord (i : ι) : ⟪b i, t⟫_ℂ ≠ 0 := by
    intro hzero
    have h := (htpos i).2
    rw [hzero, Complex.zero_re] at h
    exact (lt_irrefl 0) h
  have htprod (j k : ι) :
      star (⟪b j, t⟫_ℂ * star ⟪b k, t⟫_ℂ) =
        ⟪b j, t⟫_ℂ * star ⟪b k, t⟫_ℂ := by
    simp only [star_mul', htstar]
  obtain ⟨y, hy, hyunit, hymk⟩ :=
    exists_unit_representative (f (Projectivization.mk ℂ t ht))
  have hproducts (i : ι) :
      ⟪b r, y⟫_ℂ * star ⟪b i, y⟫_ℂ = ⟪b r, t⟫_ℂ * star ⟪b i, t⟫_ℂ := by
    by_cases hri : r = i
    · subst i
      have hnorm := coordinate_norm_sq_eq_of_fixed_basis b f h_probability h_basis
        ht hy htunit hyunit hymk.symm r
      simp only [Complex.star_def, Complex.mul_conj']
      exact_mod_cast hnorm
    · rcases h_reference i hri with hrot | href
      · have h := coordinate_product_of_pair_rotation b f h_probability h_basis hri
          ht hy htunit hyunit hymk.symm 1 (by simpa only [one_mul] using hrot)
        simpa only [Circle.coe_one, star_one, one_mul] using h
      · have h := coordinate_product_of_pair_reflection b f h_probability h_basis hri
          ht hy htunit hyunit hymk.symm 1 (by simpa only [one_mul] using href)
        simpa only [Circle.coe_one, star_one, one_mul, htprod] using h
  have htfix : f (Projectivization.mk ℂ t ht) = Projectivization.mk ℂ t ht :=
    hymk.symm.trans (mk_eq_of_reference_products b t y ht hy r (htcoord r) hproducts).symm
  intro j k hjk
  have hnonzero : ⟪b j, t⟫_ℂ * star ⟪b k, t⟫_ℂ ≠ 0 :=
    mul_ne_zero (htcoord j) (star_ne_zero.mpr (htcoord k))
  have offset_eq_one (a : Circle)
      (hprod : ⟪b j, t⟫_ℂ * star ⟪b k, t⟫_ℂ =
        star (a : ℂ) * (⟪b j, t⟫_ℂ * star ⟪b k, t⟫_ℂ)) : a = 1 := by
    have hstarone : star (a : ℂ) = 1 :=
      mul_right_cancel₀ hnonzero (by simpa only [one_mul] using hprod.symm)
    apply Circle.ext
    simpa only [star_star, star_one, Circle.coe_one] using congrArg star hstarone
  obtain ⟨a, hrot | href⟩ :=
    exists_pair_circle_mul_or_mul_inv b f h_probability h_basis hjk
  · have hprod := coordinate_product_of_pair_rotation b f h_probability h_basis hjk
      ht ht htunit htunit htfix a hrot
    have ha := offset_eq_one a hprod
    left
    simpa only [ha, one_mul] using hrot
  · have hprod := coordinate_product_of_pair_reflection b f h_probability h_basis hjk
      ht ht htunit htunit htfix a href
    rw [htprod] at hprod
    have ha := offset_eq_one a hprod
    right
    simpa only [ha, one_mul] using href

/-- One unitary normalization simultaneously removes all pair offsets. The
orientation remains fixed on each circle but may still differ between pairs. -/
theorem exists_zero_offset_unitary_normalization (h_bijective : Function.Bijective f)
    (r : ι) :
    ∃ D : E ≃ₗᵢ[ℂ] E,
      let g := Projectivization.map D.toLinearEquiv.toLinearMap D.injective ∘ f
      Function.Bijective g ∧
      (∀ (x y x' y' : E)
        (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
        g (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
        g (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
        ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
          ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) ∧
      (∀ i, g (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
        Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) ∧
      (∀ (j k : ι) (hjk : j ≠ k),
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) ∨
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + ((z⁻¹ : Circle) : ℂ) • b k)
              (pair_ne_zero b hjk z⁻¹))) := by
  obtain ⟨D, hbij, hprob, hb, href⟩ :=
    exists_reference_unitary_normalization b f h_bijective h_probability h_basis r
  exact ⟨D, hbij, hprob, hb, pair_action_without_offsets b _ hprob hb r href⟩

end GraduateQM.Wigner
