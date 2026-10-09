/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.UnitRepresentatives
public import Mathlib.Analysis.InnerProductSpace.PiL2

/-!
# An orthonormal basis representing image rays

Probability preservation sends basis rays to rays with orthogonal unit
representatives. The resulting family has the dimension of the original basis,
so it is itself an orthonormal basis. This implements `image_basis` in
`docs/wigner/PROOF_SOURCE.md`, including the empty basis case.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E]
    {ι : Type*} [Fintype ι]

/-- A probability-preserving ray map sends the rays of an orthonormal basis to
the rays of another orthonormal basis. Bijectivity is not needed for this step. -/
theorem exists_image_orthonormalBasis (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2)) :
    ∃ c : OrthonormalBasis ι ℂ E, ∀ i,
      f (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)) =
        Projectivization.mk ℂ (c i) (c.orthonormal.ne_zero i) := by
  classical
  cases isEmpty_or_nonempty ι with
  | inl hempty =>
      let := hempty
      exact ⟨b, fun i => isEmptyElim i⟩
  | inr hnonempty =>
      let := hnonempty
      choose g hg hnorm hmk using fun i : ι =>
        exists_unit_representative (f (Projectivization.mk ℂ (b i) (b.orthonormal.ne_zero i)))
      have horth : Orthonormal ℂ g := by
        refine ⟨hnorm, ?_⟩
        intro i j hij
        exact image_inner_eq_zero f h_probability (b i) (b j) (g i) (g j)
          (b.orthonormal.ne_zero i) (b.orthonormal.ne_zero j) (hg i) (hg j)
          (hmk i).symm (hmk j).symm (b.orthonormal.inner_eq_zero hij)
      have hcard : Fintype.card ι = Module.finrank ℂ E :=
        (Module.finrank_eq_card_basis b.toBasis).symm
      let d := basisOfOrthonormalOfCardEqFinrank horth hcard
      have hd : Orthonormal ℂ d := by
        simpa only [d, coe_basisOfOrthonormalOfCardEqFinrank] using horth
      let c : OrthonormalBasis ι ℂ E := d.toOrthonormalBasis hd
      have hc : (c : ι → E) = g := by
        simp only [c, Module.Basis.coe_toOrthonormalBasis, d,
          coe_basisOfOrthonormalOfCardEqFinrank]
      refine ⟨c, ?_⟩
      intro i
      simpa only [hc] using (hmk i).symm

end GraduateQM.Wigner
