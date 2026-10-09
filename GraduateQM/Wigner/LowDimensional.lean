module

public import Mathlib.LinearAlgebra.Projectivization.Basic
public import Mathlib.Analysis.InnerProductSpace.Basic
public import Mathlib.Analysis.Normed.Operator.LinearIsometry

/-!
# Wigner's theorem in dimensions zero and one

The projective space is empty in dimension zero and a subsingleton in dimension
at most one. Consequently every self-map of rays is induced by the identity
linear isometric equivalence, without preservation or bijectivity assumptions.
This covers `dimension_zero` and `dimension_one` in `docs/wigner/PROOF_SOURCE.md`.
-/

public section

namespace GraduateQM.Wigner

variable {E : Type*} [NormedAddCommGroup E]
  [InnerProductSpace ℂ E] [FiniteDimensional ℂ E]

/-- A zero-dimensional complex space has no rays. -/
theorem isEmpty_projectivization_of_finrank_eq_zero
    (h : Module.finrank ℂ E = 0) : IsEmpty (Projectivization ℂ E) := by
  let : Subsingleton E := Module.finrank_zero_iff.mp h
  exact ⟨fun p => p.rep_nonzero (Subsingleton.elim _ _)⟩

/-- In dimension at most one, any two complex rays coincide. -/
theorem subsingleton_projectivization_of_finrank_le_one
    (h : Module.finrank ℂ E ≤ 1) : Subsingleton (Projectivization ℂ E) := by
  rcases Nat.eq_zero_or_pos (Module.finrank ℂ E) with hzero | hpos
  · let := isEmpty_projectivization_of_finrank_eq_zero hzero
    infer_instance
  · have hone : Module.finrank ℂ E = 1 := Nat.le_antisymm h hpos
    refine ⟨fun p q => ?_⟩
    rw [← Projectivization.mk_rep p, ← Projectivization.mk_rep q]
    exact (Projectivization.mk_eq_mk_iff' ℂ _ _ _ _).mpr
      (exists_smul_eq_of_finrank_eq_one hone q.rep_nonzero p.rep)

/-- Every ray self-map in dimension at most one is the ray map of the identity. -/
theorem eq_projectivization_map_refl_of_finrank_le_one
    (h : Module.finrank ℂ E ≤ 1)
    (f : Projectivization ℂ E → Projectivization ℂ E) :
    f = Projectivization.map
      (LinearIsometryEquiv.refl ℂ E).toLinearEquiv.toLinearMap
      (LinearIsometryEquiv.refl ℂ E).injective := by
  let := subsingleton_projectivization_of_finrank_le_one h
  exact Subsingleton.elim _ _

/-- The unitary branch of Wigner's conclusion holds for every ray self-map in
dimension zero or one, with the identity as witness. -/
theorem exists_unitary_of_finrank_le_one
    (h : Module.finrank ℂ E ≤ 1)
    (f : Projectivization ℂ E → Projectivization ℂ E) :
    ∃ U : E ≃ₗᵢ[ℂ] E,
      f = Projectivization.map U.toLinearEquiv.toLinearMap U.injective :=
  ⟨LinearIsometryEquiv.refl ℂ E, eq_projectivization_map_refl_of_finrank_le_one h f⟩

end GraduateQM.Wigner
