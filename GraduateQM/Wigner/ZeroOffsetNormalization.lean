/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.BasisNormalization
public import GraduateQM.Wigner.PhaseOffsets

/-!
# Removing every pair-circle phase offset

Starting with the original ray-symmetry assumptions, choose one basis and a
single combined unitary normalization. Every equal-weight coordinate-pair
circle then has either identity or inversion action. The branch can still
depend on the pair. Source III (3.12)-(3.22) supplies the two phase-removal
steps; the zero-dimensional case has no coordinate pairs.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E]
  [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

/-- A ray symmetry admits one internally constructed unitary normalization with
zero phase offset on every coordinate-pair circle. Orientations remain local
to pairs; no agreement between distinct pairs is asserted here. -/
theorem exists_basis_zero_offset_normalization
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_bijective : Function.Bijective f)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) :
    ∃ (b : OrthonormalBasis (Fin (Module.finrank ℂ E)) ℂ E)
      (U : E ≃ₗᵢ[ℂ] E),
      let g := Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f
      Function.Bijective g ∧
      (∀ (x y x' y' : E)
        (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
        g (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
        g (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
        ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
          ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) ∧
      (∀ i, g (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
        Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) ∧
      (∀ (j k : Fin (Module.finrank ℂ E)) (hjk : j ≠ k),
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) ∨
        (∀ z : Circle,
          g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
            Projectivization.mk ℂ (b j + ((z⁻¹ : Circle) : ℂ) • b k)
              (pair_ne_zero b hjk z⁻¹))) := by
  obtain ⟨b, U, h_bijective', h_probability', h_basis, _⟩ :=
    exists_basis_unitary_normalization f h_bijective h_probability
  by_cases hzero : Module.finrank ℂ E = 0
  · refine ⟨b, U, h_bijective', h_probability', h_basis, ?_⟩
    intro j
    exact (Nat.not_lt_zero j.val (hzero ▸ j.isLt)).elim
  · let r : Fin (Module.finrank ℂ E) := ⟨0, Nat.pos_of_ne_zero hzero⟩
    obtain ⟨D, hD_bijective, hD_probability, hD_basis, hD_pairs⟩ :=
      exists_zero_offset_unitary_normalization b
        (Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f)
        h_probability' h_basis h_bijective' r
    let W : E ≃ₗᵢ[ℂ] E := U.trans D
    have hcomp :
        Projectivization.map W.toLinearEquiv.toLinearMap W.injective ∘ f =
          Projectivization.map D.toLinearEquiv.toLinearMap D.injective ∘
            (Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f) := by
      funext p
      change Projectivization.map W.toLinearEquiv.toLinearMap W.injective (f p) =
        Projectivization.map D.toLinearEquiv.toLinearMap D.injective
          (Projectivization.map U.toLinearEquiv.toLinearMap U.injective (f p))
      generalize f p = q
      induction q using Projectivization.ind with
      | h x hx => rfl
    refine ⟨b, W, ?_⟩
    dsimp only
    rw [hcomp]
    exact ⟨hD_bijective, hD_probability, hD_basis, hD_pairs⟩

end GraduateQM.Wigner
