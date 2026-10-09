/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.InnerProductSpace.PiL2
import Mathlib.Analysis.Normed.Module.RCLike.Basic

/-!
# A positive real unit test vector

Constructs the internal full-support test vector used at the beginning of
`full_support_real_test` in `docs/wigner/PROOF_SOURCE.md`, source III
(3.17)-(3.22). This does not prove the subsequent phase-offset comparison.
Nonemptiness is an explicit helper assumption, supplied in the source's
dimension-at-least-two case. No support assumption is made on arbitrary states.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

/-- A nonempty finite orthonormal basis admits a unit vector with strictly
positive real coordinates. The vector is constructed within the proof. -/
theorem exists_positive_unit_vector
    {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    [Fintype ι] [Nonempty ι] (b : OrthonormalBasis ι ℂ E) :
    ∃ r : E, ‖r‖ = 1 ∧ ∀ i, (⟪b i, r⟫_ℂ).im = 0 ∧ 0 < (⟪b i, r⟫_ℂ).re := by
  let y : E := b.repr.symm (WithLp.toLp 2 (fun _ : ι => (1 : ℂ)))
  have hy_coord (i : ι) : ⟪b i, y⟫_ℂ = 1 := by
    rw [← b.repr_apply_apply]
    change (b.repr (b.repr.symm (WithLp.toLp 2 (fun _ : ι => (1 : ℂ))))) i = 1
    rw [LinearIsometryEquiv.apply_symm_apply]
  have hy_ne : y ≠ 0 := by
    intro hy_zero
    obtain ⟨i⟩ := ‹Nonempty ι›
    have h := hy_coord i
    rw [hy_zero, inner_zero_right] at h
    exact zero_ne_one h
  refine ⟨(‖y‖⁻¹ : ℂ) • y, norm_smul_inv_norm hy_ne, ?_⟩
  intro i
  rw [inner_smul_right, hy_coord, mul_one, ← Complex.ofReal_inv]
  constructor
  · exact Complex.ofReal_im _
  · change 0 < ‖y‖⁻¹
    exact inv_pos.mpr (norm_pos_iff.mpr hy_ne)

end GraduateQM.Wigner
