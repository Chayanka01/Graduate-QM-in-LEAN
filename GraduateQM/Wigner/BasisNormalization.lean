/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.ImageBasis
public import GraduateQM.Wigner.RayIsometries
public import GraduateQM.Wigner.CoordinateMagnitudes

/-!
# The first unitary normalization of a ray symmetry

The basis and normalizing unitary are constructed internally from the original
ray symmetry. After this one change of basis, the symmetry fixes every basis
ray and preserves coordinate magnitudes and zero supports for all unit states.
This assembles the mathematical content of source III (3.2)-(3.6). It does not
settle the phases or the global linear/conjugate-linear branch of Wigner's
theorem.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E]
  [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

/-- A probability-preserving ray bijection admits an internally chosen basis
and one unitary normalization fixing its basis rays. The same normalization
preserves all probabilities and every unit state's coordinate magnitudes and
support. The basis and unitary precede the quantification over states. -/
theorem exists_basis_unitary_normalization
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
      (∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0),
        ‖x‖ = 1 → ‖y‖ = 1 →
        g (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
        (∀ i, ‖⟪b i, y⟫_ℂ‖ ^ 2 = ‖⟪b i, x⟫_ℂ‖ ^ 2) ∧
        (∀ i, ‖⟪b i, y⟫_ℂ‖ = ‖⟪b i, x⟫_ℂ‖) ∧
        (∀ i, ⟪b i, y⟫_ℂ = 0 ↔ ⟪b i, x⟫_ℂ = 0) ∧
        Function.support (fun i => b.repr y i) =
          Function.support (fun i => b.repr x i)) := by
  classical
  let b := stdOrthonormalBasis ℂ E
  obtain ⟨c, hc⟩ := exists_image_orthonormalBasis b f h_probability
  let U : E ≃ₗᵢ[ℂ] E := c.equiv b (Equiv.refl _)
  let g := Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f
  have h_basis : ∀ i, g (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
      Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i) := by
    intro i
    dsimp only [g, Function.comp_apply]
    rw [hc i, Projectivization.map_mk]
    change Projectivization.mk ℂ (U (c i)) _ = _
    simp only [U, OrthonormalBasis.equiv_apply_basis, Equiv.refl_apply]
  have h_prob := probability_preserving_unitary_postcomp U f h_probability
  refine ⟨b, U, (projectivization_map_bijective U).comp h_bijective,
    h_prob, h_basis, ?_⟩
  intro x y hx hy hx_unit hy_unit h_image
  exact ⟨coordinate_norm_sq_eq_of_fixed_basis b g h_prob h_basis
      hx hy hx_unit hy_unit h_image,
    coordinate_norm_eq_of_fixed_basis b g h_prob h_basis
      hx hy hx_unit hy_unit h_image,
    coordinate_eq_zero_iff_of_fixed_basis b g h_prob h_basis
      hx hy hx_unit hy_unit h_image,
    coordinate_support_eq_of_fixed_basis b g h_prob h_basis
      hx hy hx_unit hy_unit h_image⟩

end GraduateQM.Wigner
