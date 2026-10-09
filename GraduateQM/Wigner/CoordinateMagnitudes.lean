/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.RayProbability
public import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# Coordinate magnitudes after basis normalization

Conditional internal consequences of the basis-ray tests in source III (3.6),
recorded as `coordinate_magnitudes` in `docs/wigner/PROOF_SOURCE.md`.
The fixed-basis hypothesis must be supplied by the separate basis-normalization
construction. These lemmas neither construct that normalization nor complete
the source node or Wigner's theorem. Coordinates use the convention that the
inner product is conjugate-linear in its first slot.
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
  {x y : E} (hx : x ≠ 0) (hy : y ≠ 0)
  (hx_unit : ‖x‖ = 1) (hy_unit : ‖y‖ = 1)
  (h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy)

include h_probability h_basis hx_unit hy_unit h_image

/-- Testing against a fixed basis ray preserves each squared coordinate magnitude
of unit input and output representatives. -/
theorem coordinate_norm_sq_eq_of_fixed_basis (i : ι) :
    ‖⟪b i, y⟫_ℂ‖ ^ 2 = ‖⟪b i, x⟫_ℂ‖ ^ 2 := by
  have h := h_probability (b i) x (b i) y
    (b.orthonormal.ne_zero i) hx (b.orthonormal.ne_zero i) hy (h_basis i) h_image
  simpa only [b.norm_eq_one, hx_unit, hy_unit, one_pow, one_mul, div_one] using h

/-- Nonnegativity of norms removes the square in the basis-ray probability test. -/
theorem coordinate_norm_eq_of_fixed_basis (i : ι) :
    ‖⟪b i, y⟫_ℂ‖ = ‖⟪b i, x⟫_ℂ‖ := by
  exact (sq_eq_sq₀ (norm_nonneg _) (norm_nonneg _)).mp
    (coordinate_norm_sq_eq_of_fixed_basis b f h_probability h_basis
      hx hy hx_unit hy_unit h_image i)

/-- A coordinate vanishes in the image exactly when it vanishes in the input. -/
theorem coordinate_eq_zero_iff_of_fixed_basis (i : ι) :
    ⟪b i, y⟫_ℂ = 0 ↔ ⟪b i, x⟫_ℂ = 0 := by
  calc
    ⟪b i, y⟫_ℂ = 0 ↔ ‖⟪b i, y⟫_ℂ‖ = 0 := norm_eq_zero.symm
    _ ↔ ‖⟪b i, x⟫_ℂ‖ = 0 := by
      rw [coordinate_norm_eq_of_fixed_basis b f h_probability h_basis
        hx hy hx_unit hy_unit h_image i]
    _ ↔ ⟪b i, x⟫_ℂ = 0 := norm_eq_zero

/-- Unit representatives related by a probability-preserving map fixing the
basis rays have the same coordinate support. -/
theorem coordinate_support_eq_of_fixed_basis :
    Function.support (fun i => b.repr y i) = Function.support (fun i => b.repr x i) := by
  apply Set.ext
  intro i
  change b.repr y i ≠ 0 ↔ b.repr x i ≠ 0
  rw [b.repr_apply_apply, b.repr_apply_apply]
  exact not_congr (coordinate_eq_zero_iff_of_fixed_basis b f h_probability h_basis
    hx hy hx_unit hy_unit h_image i)

end GraduateQM.Wigner
