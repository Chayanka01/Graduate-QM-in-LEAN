/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import Mathlib.Analysis.Complex.Basic
import Mathlib.Tactic.NormNum

/-!
# Coherence of coordinate-product signs

Algebraic expansion of the `triple_consistency` and `global_branch` source gaps
in `docs/wigner/PROOF_SOURCE.md`, source III (3.25)-(3.28). The explicit
coordinate-lift premise is conditional; its production from the ray map is a
separate obligation. `true` preserves products and `false` conjugates them.
Diagonal signs are irrelevant and unrestricted. The argument works for any
index type, including empty and singleton types.
-/

public section

namespace GraduateQM.Wigner

private theorem imaginary_sign_injective :
    Function.Injective (fun t : Bool => if t then Complex.I else -Complex.I) := by
  intro a b h
  cases a <;> cases b
  · rfl
  · have him := congrArg Complex.im h
    norm_num at him
  · have him := congrArg Complex.im h
    norm_num at him
  · rfl

/-- If every complex coordinate vector admits a lift with the specified
preserved or conjugated pair products, all off-diagonal signs agree. -/
theorem signs_uniform_of_coordinate_lifts {ι : Type*} (ε : ι → ι → Bool)
    (h_lift : ∀ c : ι → ℂ, ∃ d : ι → ℂ, ∀ j k,
      d j * star (d k) =
        if ε j k then c j * star (c k) else star (c j * star (c k))) :
    (∀ j k, j ≠ k → ε j k = true) ∨ (∀ j k, j ≠ k → ε j k = false) := by
  classical
  have hrow (j k l : ι) (hjk : j ≠ k) (hjl : j ≠ l) : ε j k = ε j l := by
    let c : ι → ℂ := fun i => if i = j then Complex.I else 1
    obtain ⟨d, hd⟩ := h_lift c
    have hkk : d k * star (d k) = 1 := by
      simpa only [c, ite_eq_right hjk.symm, star_one, one_mul, ite_self] using hd k k
    have hkl : d k * star (d l) = 1 := by
      simpa only [c, ite_eq_right hjk.symm, ite_eq_right hjl.symm, star_one, one_mul, ite_self]
        using hd k l
    have hjk_val : d j * star (d k) = if ε j k then Complex.I else -Complex.I := by
      simpa only [c, ite_eq_left rfl, ite_eq_right hjk.symm, star_one, mul_one,
        Complex.star_def, Complex.conj_I] using hd j k
    have hjl_val : d j * star (d l) = if ε j l then Complex.I else -Complex.I := by
      simpa only [c, ite_eq_left rfl, ite_eq_right hjl.symm, star_one, mul_one,
        Complex.star_def, Complex.conj_I] using hd j l
    have heq : d j * star (d k) = d j * star (d l) := by
      calc
        d j * star (d k) = (d j * star (d k)) * (d k * star (d l)) := by
          rw [hkl, mul_one]
        _ = (d k * star (d k)) * (d j * star (d l)) := by ac_rfl
        _ = d j * star (d l) := by rw [hkk, one_mul]
    apply imaginary_sign_injective
    exact hjk_val.symm.trans (heq.trans hjl_val)
  have hsymm (j k : ι) (hjk : j ≠ k) : ε j k = ε k j := by
    let c : ι → ℂ := fun i => if i = j then Complex.I else 1
    obtain ⟨d, hd⟩ := h_lift c
    have hjk_val : d j * star (d k) = if ε j k then Complex.I else -Complex.I := by
      simpa only [c, ite_eq_left rfl, ite_eq_right hjk.symm, star_one, mul_one,
        Complex.star_def, Complex.conj_I] using hd j k
    have hkj_val : d k * star (d j) = if ε k j then -Complex.I else Complex.I := by
      simpa only [c, ite_eq_left rfl, ite_eq_right hjk.symm, one_mul,
        Complex.star_def, Complex.conj_I, map_neg, neg_neg] using hd k j
    have hstar : star (if ε k j then -Complex.I else Complex.I) =
        if ε k j then Complex.I else -Complex.I := by
      cases ε k j <;> simp only [Bool.false_eq_true, ite_false, ite_true,
        star_neg, Complex.star_def, Complex.conj_I, neg_neg]
    apply imaginary_sign_injective
    calc
      (if ε j k then Complex.I else -Complex.I) = d j * star (d k) := hjk_val.symm
      _ = star (d k * star (d j)) := by rw [star_mul, star_star]
      _ = star (if ε k j then -Complex.I else Complex.I) := congrArg star hkj_val
      _ = if ε k j then Complex.I else -Complex.I := hstar
  by_cases hex : ∃ j k : ι, j ≠ k
  · obtain ⟨j, k, hjk⟩ := hex
    have hall (l m : ι) (hlm : l ≠ m) : ε l m = ε j k := by
      by_cases hlj : l = j
      · subst l
        exact hrow j m k hlm hjk
      · exact (hrow l m j hlm hlj).trans
          ((hsymm l j hlj).trans (hrow j l k (Ne.symm hlj) hjk))
    cases hsign : ε j k
    · exact Or.inr (fun l m hlm => (hall l m hlm).trans hsign)
    · exact Or.inl (fun l m hlm => (hall l m hlm).trans hsign)
  · exact Or.inl (fun j k hjk => False.elim (hex ⟨j, k, hjk⟩))

end GraduateQM.Wigner
