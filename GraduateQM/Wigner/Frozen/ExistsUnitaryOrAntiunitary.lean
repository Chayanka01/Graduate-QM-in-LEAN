-- FROZEN_ANCHOR_PREFIX_BEGIN
module

public import Mathlib.LinearAlgebra.Projectivization.Basic
public import Mathlib.Analysis.InnerProductSpace.Basic
public import Mathlib.Analysis.Normed.Operator.LinearIsometry
import GraduateQM.Wigner.Provider

open scoped InnerProductSpace

public theorem GraduateQM.Wigner.exists_unitary_or_antiunitary
    (E : Type*) [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_bijective : Function.Bijective f)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) :
    (∃ U : E ≃ₗᵢ[ℂ] E,
      f = Projectivization.map U.toLinearEquiv.toLinearMap U.injective) ∨
    (∃ A : E ≃ₗᵢ⋆[ℂ] E,
      f = Projectivization.map A.toLinearEquiv.toLinearMap A.injective) :=
-- FROZEN_ANCHOR_PROOF_BEGIN
by exact GraduateQM.Wigner.Provider.exists_unitary_or_antiunitary
-- FROZEN_ANCHOR_PROOF_END
-- FROZEN_ANCHOR_SUFFIX_BEGIN
-- FROZEN_ANCHOR_SUFFIX_END
