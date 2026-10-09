/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.PairCircle
public import GraduateQM.Wigner.DiagonalUnitary
public import GraduateQM.Wigner.RayIsometries

/-!
# One diagonal normalization for all reference pairs

Choose the phase offsets on all pairs containing a reference basis coordinate.
One diagonal unitary removes them simultaneously. The remaining orientation
may depend on the pair but not on the circle parameter. This is the conditional
`diagonal_normalization` step of `docs/wigner/PROOF_SOURCE.md`.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]

/-- A single diagonal unitary removes every reference-pair phase offset while
retaining ray bijectivity, the exact probability premise, and fixed basis rays.
The unitary precedes all quantifiers over pairs and circle parameters. -/
theorem exists_reference_unitary_normalization (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_bijective : Function.Bijective f)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2))
    (h_basis : ∀ i, f (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
      Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i))
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
      (∀ (k : ι) (hrk : r ≠ k),
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) =
            Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) ∨
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z)) =
            Projectivization.mk ℂ (b r + ((z⁻¹ : Circle) : ℂ) • b k)
              (pair_ne_zero b hrk z⁻¹))) := by
  classical
  choose a ha using fun k : {k : ι // r ≠ k} =>
    exists_pair_circle_mul_or_mul_inv b f h_probability h_basis k.property
  let d : ι → Circle := fun i => if hi : r = i then 1 else (a ⟨i, hi⟩)⁻¹
  obtain ⟨D, hD⟩ := exists_diagonal_unitary b d
  have hdr : d r = 1 := dite_eq_left rfl
  have hdk (k : ι) (hrk : r ≠ k) : d k = (a ⟨k, hrk⟩)⁻¹ := dite_eq_right hrk
  have hpair (k : ι) (hrk : r ≠ k) (z : Circle) :
      Projectivization.map D.toLinearEquiv.toLinearMap D.injective
        (Projectivization.mk ℂ (b r + ((a ⟨k, hrk⟩ * z : Circle) : ℂ) • b k)
          (pair_ne_zero b hrk (a ⟨k, hrk⟩ * z))) =
        Projectivization.mk ℂ (b r + (z : ℂ) • b k) (pair_ne_zero b hrk z) := by
    have hc : (a ⟨k, hrk⟩ * z) * (a ⟨k, hrk⟩)⁻¹ = z := by
      calc
        _ = z * (a ⟨k, hrk⟩ * (a ⟨k, hrk⟩)⁻¹) := by ac_rfl
        _ = z := by rw [mul_inv_cancel, mul_one]
    have hc' : ((a ⟨k, hrk⟩ * z : Circle) : ℂ) * (d k : ℂ) = (z : ℂ) := by
      rw [hdk k hrk]
      simpa only [Circle.coe_mul] using congrArg (fun t : Circle => (t : ℂ)) hc
    have hvec : D (b r + ((a ⟨k, hrk⟩ * z : Circle) : ℂ) • b k) =
        b r + (z : ℂ) • b k := by
      rw [map_add, map_smul, hD r, hD k, hdr, Circle.coe_one, one_smul,
        smul_smul, hc']
    change Projectivization.mk ℂ
      (D (b r + ((a ⟨k, hrk⟩ * z : Circle) : ℂ) • b k)) _ = _
    simp only [hvec]
  refine ⟨D, (projectivization_map_bijective D).comp h_bijective,
    probability_preserving_unitary_postcomp D f h_probability, ?_, ?_⟩
  · intro i
    dsimp only [Function.comp_apply]
    rw [h_basis i]
    exact diagonal_unitary_map_basis_ray b d D hD i
  · intro k hrk
    rcases ha ⟨k, hrk⟩ with hpos | hneg
    · left
      intro z
      dsimp only [Function.comp_apply]
      rw [hpos z]
      exact hpair k hrk z
    · right
      intro z
      dsimp only [Function.comp_apply]
      rw [hneg z]
      exact hpair k hrk z⁻¹

end GraduateQM.Wigner
