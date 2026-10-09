/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.BasisNormalization
public import GraduateQM.Wigner.PairCircle

/-!
# Coordinate-pair circles after one unitary normalization

This assembles source III (3.2)-(3.11) from the original ray-symmetry inputs.
One basis and one normalizing unitary are chosen before all coordinate pairs.
Each pair has one phase offset and one orientation valid on its entire circle.
The orientations are not yet proved to agree between different pairs.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E]
  [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

/-- A ray symmetry admits one basis normalization whose action on each
coordinate-pair circle is a rotation or reflected rotation. The unitary is
global, while each pair's offset and orientation precede every circle state. -/
theorem exists_basis_unitary_pair_circle_normalization
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
        ∃ a : Circle,
          (∀ z : Circle,
            g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
              Projectivization.mk ℂ (b j + ((a * z : Circle) : ℂ) • b k)
                (pair_ne_zero b hjk (a * z))) ∨
          (∀ z : Circle,
            g (Projectivization.mk ℂ (b j + (z : ℂ) • b k) (pair_ne_zero b hjk z)) =
              Projectivization.mk ℂ (b j + ((a * z⁻¹ : Circle) : ℂ) • b k)
                (pair_ne_zero b hjk (a * z⁻¹)))) := by
  obtain ⟨b, U, h_bijective', h_probability', h_basis, _⟩ :=
    exists_basis_unitary_normalization f h_bijective h_probability
  refine ⟨b, U, h_bijective', h_probability', h_basis, ?_⟩
  intro j k hjk
  exact exists_pair_circle_mul_or_mul_inv b _ h_probability' h_basis hjk

end GraduateQM.Wigner
