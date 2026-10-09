/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.PairGeometry
public import GraduateQM.Wigner.UnitRepresentatives
public import GraduateQM.Wigner.CircleRigidity
import Mathlib.Tactic.Linarith

/-!
# The circle action on a pair of basis coordinates

For a probability-preserving ray map fixing every basis ray, the equal-weight
pair circle maps to itself. Its unique parameters preserve the real Hermitian
product and therefore have one common phase offset and orientation. This is
the conditional `pair_circle` step of `docs/wigner/PROOF_SOURCE.md`; the fixed
basis premise must be supplied by basis normalization.
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
  {j k : ι} (hjk : j ≠ k)

include h_probability h_basis

/-- Every image of an equal-weight pair ray has a unique circle parameter,
with the first coordinate fixed to one. -/
theorem exists_unique_pair_circle_image (z : Circle) :
    ∃! w : Circle,
      f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
        Projectivization.mk ℂ (b j + (w : ℂ) • b k) (pair_ne_zero b hjk w) := by
  classical
  obtain ⟨y, hy, hyunit, hymk⟩ := exists_unit_representative
    (f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)))
  have hcoord (i : ι) :
      ‖⟪b i, y⟫_ℂ‖ ^ 2 = ‖⟪b i, b j + (z : ℂ) • b k⟫_ℂ‖ ^ 2 / 2 := by
    have h := h_probability (b i) (b j + (z : ℂ) • b k) (b i) y
      (b.orthonormal.ne_zero i) (pair_ne_zero b hjk z)
      (b.orthonormal.ne_zero i) hy (h_basis i) hymk.symm
    simpa only [b.norm_eq_one, hyunit, one_pow, one_mul, div_one,
      pair_norm_sq b hjk] using h
  have hj : ‖⟪b j, y⟫_ℂ‖ ^ 2 = 1 / 2 := by
    simpa only [inner_pair_left b hjk, norm_one, one_pow] using hcoord j
  have hk : ‖⟪b k, y⟫_ℂ‖ ^ 2 = 1 / 2 := by
    simpa only [inner_pair_right b hjk, Circle.norm_coe, one_pow] using hcoord k
  have hjzero : ⟪b j, y⟫_ℂ ≠ 0 := by
    intro hzero
    rw [hzero, norm_zero, zero_pow (by decide : 2 ≠ 0)] at hj
    norm_num at hj
  have heqnorm : ‖⟪b k, y⟫_ℂ‖ = ‖⟪b j, y⟫_ℂ‖ :=
    (sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _)).mp (hk.trans hj.symm)
  have hoff (i : ι) (hij : i ≠ j) (hik : i ≠ k) : ⟪b i, y⟫_ℂ = 0 := by
    have h := hcoord i
    simp only [inner_add_right, inner_smul_right, b.inner_eq_zero hij,
      b.inner_eq_zero hik, mul_zero, add_zero, norm_zero,
      zero_pow (by decide : 2 ≠ 0), zero_div] at h
    exact norm_eq_zero.mp ((pow_eq_zero_iff (by decide : 2 ≠ 0)).mp h)
  let w : Circle := ⟨⟪b k, y⟫_ℂ / ⟪b j, y⟫_ℂ, mem_sphere_zero_iff_norm.mpr (by
    rw [norm_div, heqnorm, div_self (norm_ne_zero_iff.mpr hjzero)])⟩
  have hyform : y = ⟪b j, y⟫_ℂ • (b j + (w : ℂ) • b k) := by
    apply b.repr.injective
    ext i
    simp only [b.repr_apply_apply]
    rw [inner_smul_right]
    by_cases hij : i = j
    · subst i
      rw [inner_pair_left b hjk, mul_one]
    · by_cases hik : i = k
      · subst i
        rw [inner_pair_right b hjk]
        exact (mul_div_cancel₀ _ hjzero).symm
      · rw [hoff i hij hik]
        simp only [inner_add_right, inner_smul_right, b.inner_eq_zero hij,
          b.inner_eq_zero hik, mul_zero, add_zero]
  have hw : f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
      Projectivization.mk ℂ (b j + (w : ℂ) • b k) (pair_ne_zero b hjk w) := by
    rw [← hymk]
    exact (Projectivization.mk_eq_mk_iff' ℂ _ _ _ _).mpr ⟨⟪b j, y⟫_ℂ, hyform.symm⟩
  refine ⟨w, hw, ?_⟩
  intro v hv
  exact (pair_mk_eq_iff b hjk v w).mp (hv.symm.trans hw)

/-- The pair-circle action has a single phase offset and a single orientation
valid for every circle parameter. Inversion is conjugation on the circle. -/
theorem exists_pair_circle_mul_or_mul_inv :
    ∃ a : Circle,
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + ((a * z : Circle) : ℂ) • b k)
            (pair_ne_zero b hjk (a * z))) ∨
      (∀ z : Circle,
        f (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
          Projectivization.mk ℂ (b j + ((a * z⁻¹ : Circle) : ℂ) • b k)
            (pair_ne_zero b hjk (a * z⁻¹))) := by
  classical
  choose F hF using fun z : Circle =>
    (exists_unique_pair_circle_image b f h_probability h_basis hjk z).exists
  have hreal (z w : Circle) :
      (star (F z : ℂ) * (F w : ℂ)).re = (star (z : ℂ) * (w : ℂ)).re := by
    have h := h_probability
      (b j + (z : ℂ) • b k) (b j + (w : ℂ) • b k)
      (b j + (F z : ℂ) • b k) (b j + (F w : ℂ) • b k)
      (pair_ne_zero b hjk z) (pair_ne_zero b hjk w)
      (pair_ne_zero b hjk (F z)) (pair_ne_zero b hjk (F w)) (hF z) (hF w)
    rw [pair_probability b hjk, pair_probability b hjk] at h
    linarith only [h]
  obtain ⟨a, ha | ha⟩ := exists_circle_mul_or_mul_inv_of_preserving_re F hreal
  · exact ⟨a, Or.inl (fun z => by simpa only [ha z] using hF z)⟩
  · exact ⟨a, Or.inr (fun z => by simpa only [ha z] using hF z)⟩

end GraduateQM.Wigner
