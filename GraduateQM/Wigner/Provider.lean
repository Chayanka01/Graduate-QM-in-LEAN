module

public import GraduateQM.Wigner.ZeroOffsetNormalization
public import GraduateQM.Wigner.GlobalBranch
public import GraduateQM.Wigner.GlobalRayAction

/-!
# Implementation of finite-dimensional Wigner's theorem

One unitary normalization removes the basis and pair phases. Coordinate-product
consistency then chooses one branch for all states, and sparse reconstruction
implements it on every ray. Composing with the inverse normalizer recovers the
original ray map, as in source III (3.25)-(3.28).

The two source proof parameters have tactic defaults so the immutable frozen
anchor can use its checker-required bare `exact` assembly. These defaults only
retrieve the corresponding local hypotheses; the explicit provider application
requires the same bijectivity and probability proofs.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner.Provider

/-- Every bijective finite-dimensional complex ray symmetry preserving all
transition probabilities is induced by one unitary or antiunitary equivalence. -/
theorem exists_unitary_or_antiunitary
    {E : Type*} [NormedAddCommGroup E]
    [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]
    {f : Projectivization ℂ E → Projectivization ℂ E}
    (h_bijective : Function.Bijective f := by assumption)
    (h_probability : ∀ (x y x' y' : E)
      (hx : x ≠ 0) (hy : y ≠ 0) (hx' : x' ≠ 0) (hy' : y' ≠ 0),
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ x' hx' →
      f (Projectivization.mk ℂ y hy) = Projectivization.mk ℂ y' hy' →
      ‖⟪x', y'⟫_ℂ‖ ^ 2 / (‖x'‖ ^ 2 * ‖y'‖ ^ 2) =
        ‖⟪x, y⟫_ℂ‖ ^ 2 / (‖x‖ ^ 2 * ‖y‖ ^ 2) := by assumption) :
    (∃ U : E ≃ₗᵢ[ℂ] E,
      f = Projectivization.map U.toLinearEquiv.toLinearMap U.injective) ∨
    (∃ A : E ≃ₗᵢ⋆[ℂ] E,
      f = Projectivization.map A.toLinearEquiv.toLinearMap A.injective) := by
  obtain ⟨b, U, _, h_probability', h_basis, h_pairs⟩ :=
    exists_basis_zero_offset_normalization f h_bijective h_probability
  let g := Projectivization.map U.toLinearEquiv.toLinearMap U.injective ∘ f
  rcases coordinate_products_global_branch b g h_probability' h_basis h_pairs with hpos | hneg
  · have hg : g = id := eq_id_of_coordinate_products b g hpos
    refine Or.inl ⟨U.symm, ?_⟩
    funext p
    calc
      f p = Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective (g p) :=
        (projectivization_map_symm_apply U (f p)).symm
      _ = Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective p := by
        rw [hg]
        rfl
  · obtain ⟨K, hg⟩ := exists_antiunitary_of_conjugated_coordinate_products b g hneg
    let A : E ≃ₗᵢ⋆[ℂ] E := K.trans U.symm
    refine Or.inr ⟨A, ?_⟩
    funext p
    calc
      f p = Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective (g p) :=
        (projectivization_map_symm_apply U (f p)).symm
      _ = Projectivization.map U.symm.toLinearEquiv.toLinearMap U.symm.injective
          (Projectivization.map K.toLinearEquiv.toLinearMap K.injective p) := by rw [hg]
      _ = Projectivization.map A.toLinearEquiv.toLinearMap A.injective p := by
        induction p using Projectivization.ind with
        | h x hx => rfl

end GraduateQM.Wigner.Provider
