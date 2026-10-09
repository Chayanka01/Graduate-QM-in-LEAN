/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.LinearAlgebra.Projectivization.Basic
public import Mathlib.Analysis.InnerProductSpace.LinearMap
import GraduateQM.Wigner.UnitRepresentatives

/-!
# Unitary actions on rays

Ordinary complex linear isometric equivalences act bijectively on rays and
preserve the inline transition probability. These are the linear unitary part
of `basis_normalization#induced_ray_action` in the Wigner proof source.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]

/-- Applying a unitary ray action and its inverse recovers the original ray. -/
theorem projectivization_map_symm_apply (U : E ≃ₗᵢ[ℂ] E)
    (p : Projectivization ℂ E) :
    Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective
      (Projectivization.map U.toLinearEquiv.toLinearMap U.injective p) = p := by
  induction p using Projectivization.ind with
  | h x hx =>
    simp only [Projectivization.map_mk, LinearEquiv.coe_coe,
      LinearIsometryEquiv.coe_toLinearEquiv, U.symm_apply_apply]

/-- A unitary induces a bijection of complex rays. -/
theorem projectivization_map_bijective (U : E ≃ₗᵢ[ℂ] E) :
    Function.Bijective
      (Projectivization.map U.toLinearEquiv.toLinearMap U.injective) := by
  refine ⟨Projectivization.map_injective _ _, fun p => ?_⟩
  exact ⟨Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective p,
    projectivization_map_symm_apply U.symm p⟩

/-- A unitary preserves the probability expression, including its totalized
value when a representative is zero. -/
theorem probability_unitary (U : E ≃ₗᵢ[ℂ] E) (x y : E) :
    ‖⟪U x, U y⟫_ℂ‖ ^ 2 / (‖U x‖ ^ 2 * ‖U y‖ ^ 2) =
      ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) := by
  rw [U.inner_map_map, U.norm_map, U.norm_map]

/-- Left postcomposition with a unitary ray action preserves the exact
all-representative probability premise, with no vector lift assumed. -/
theorem probability_preserving_unitary_postcomp
    (U : E ≃ₗᵢ[ℂ] E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) :
    ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      (Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f)
        (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      (Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f)
        (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) := by
  intro x y x' y' hx hy hx' hy' hfx hfy
  let p := f (Projectivization.mk ℂ x hx)
  let q := f (Projectivization.mk ℂ y hy)
  have hUp : U p.rep ≠ 0 := by
    simpa only [map_zero] using U.injective.ne p.rep_nonzero
  have hUq : U q.rep ≠ 0 := by
    simpa only [map_zero] using U.injective.ne q.rep_nonzero
  have hpx : Projectivization.mk ℂ (U p.rep) hUp =
      Projectivization.mk ℂ x' hx' := by
    change Projectivization.map U.toLinearEquiv.toLinearMap U.injective
      (Projectivization.mk ℂ p.rep p.rep_nonzero) = _
    rw [Projectivization.mk_rep]
    exact hfx
  have hqy : Projectivization.mk ℂ (U q.rep) hUq =
      Projectivization.mk ℂ y' hy' := by
    change Projectivization.map U.toLinearEquiv.toLinearMap U.injective
      (Projectivization.mk ℂ q.rep q.rep_nonzero) = _
    rw [Projectivization.mk_rep]
    exact hfy
  calc
    _ = ‖⟪U p.rep, U q.rep⟫_ℂ‖ ^ 2 /
        (‖U p.rep‖ ^ 2 * ‖U q.rep‖ ^ 2) :=
      (probability_eq_of_mk_eq (U p.rep) (U q.rep) x' y'
        hUp hUq hx' hy' hpx hqy).symm
    _ = ‖⟪p.rep, q.rep⟫_ℂ‖ ^ 2 / (‖p.rep‖ ^ 2 * ‖q.rep‖ ^ 2) :=
      probability_unitary U p.rep q.rep
    _ = _ := h_probability x y p.rep q.rep hx hy p.rep_nonzero q.rep_nonzero
      (Projectivization.mk_rep p).symm (Projectivization.mk_rep q).symm

end GraduateQM.Wigner
