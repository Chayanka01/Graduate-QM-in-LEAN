/-
Copyright (c) 2026 Graduate QM contributors. All rights reserved.
Released under Apache 2.0 license as described in the file LICENSE.
-/
module

public import GraduateQM.Wigner.RayReconstruction
public import GraduateQM.Wigner.CoordinateConjugation
import GraduateQM.Wigner.UnitRepresentatives

/-!
# Global ray actions from coordinate products

Once a single product branch holds for all states, every ray is reconstructed
using a nonzero coordinate chosen for that particular state. No fixed reference
coordinate or full-support hypothesis is used. These are conditional consumers
for `sparse_reconstruction`; producing the global branch is a separate step.
-/

public section

open scoped InnerProductSpace

namespace GraduateQM.Wigner

variable {E ι : Type*} [NormedAddCommGroup E] [InnerProductSpace ℂ E] [Fintype ι]

private theorem exists_nonzero_basis_coordinate (b : OrthonormalBasis ι ℂ E)
    (x : E) (hx : x ≠ 0) : ∃ i, ⟪b i, x⟫_ℂ ≠ 0 := by
  classical
  by_contra h
  apply hx
  apply b.repr.injective
  apply PiLp.ext
  intro i
  have hi : ⟪b i, x⟫_ℂ = 0 := not_not.mp (fun hi => h ⟨i, hi⟩)
  simpa only [b.repr_apply_apply, map_zero, PiLp.zero_apply] using hi

/-- A single globally preserved coordinate-product branch makes the ray map the
identity, even for states with vanishing coordinates. -/
theorem eq_id_of_coordinate_products (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_products : ∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0),
      ‖x‖ = 1 → ‖y‖ = 1 →
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
      ∀ j k, ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        ⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ) : f = id := by
  funext p
  obtain ⟨x, hx, hx_unit, hxp⟩ := exists_unit_representative p
  obtain ⟨y, hy, hy_unit, hyp⟩ := exists_unit_representative (f p)
  have h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy := by
    rw [hxp, hyp]
  obtain ⟨r, hr⟩ := exists_nonzero_basis_coordinate b x hx
  have hxy := mk_eq_of_reference_products b x y hx hy r hr
    (h_products x y hx hy hx_unit hy_unit h_image r)
  change f p = p
  exact hyp.symm.trans (hxy.symm.trans hxp)

/-- A single globally conjugated coordinate-product branch is implemented on
rays by any antiunitary having the stated coordinate-conjugation formula. -/
theorem eq_map_of_conjugated_coordinate_products (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (K : E ≃ₗᵢ⋆[ℂ] E)
    (hK : ∀ x i, ⟪b i, K x⟫_ℂ = star ⟪b i, x⟫_ℂ)
    (h_products : ∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0),
      ‖x‖ = 1 → ‖y‖ = 1 →
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
      ∀ j k, ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        star (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ)) :
    f = Projectivization.map K.toLinearEquiv.toLinearMap K.injective := by
  funext p
  obtain ⟨x, hx, hx_unit, hxp⟩ := exists_unit_representative p
  obtain ⟨y, hy, hy_unit, hyp⟩ := exists_unit_representative (f p)
  have h_image : f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy := by
    rw [hxp, hyp]
  have hKx : K x ≠ 0 := by simpa only [map_zero] using K.injective.ne hx
  obtain ⟨r, hr⟩ := exists_nonzero_basis_coordinate b (K x) hKx
  have hxy : Projectivization.mk ℂ (K x) hKx = Projectivization.mk ℂ y hy := by
    apply mk_eq_of_reference_products b (K x) y hKx hy r hr
    intro i
    rw [h_products x y hx hy hx_unit hy_unit h_image r i, hK, hK]
    simp only [star_mul', star_star]
  calc
    f p = Projectivization.mk ℂ y hy := hyp.symm
    _ = Projectivization.mk ℂ (K x) hKx := hxy.symm
    _ = Projectivization.map K.toLinearEquiv.toLinearMap K.injective
        (Projectivization.mk ℂ x hx) := rfl
    _ = _ := congrArg (Projectivization.map K.toLinearEquiv.toLinearMap K.injective) hxp

/-- The conjugated global product branch supplies an actual antiunitary witness,
using coordinate conjugation constructed from the basis. -/
theorem exists_antiunitary_of_conjugated_coordinate_products
    (b : OrthonormalBasis ι ℂ E)
    (f : Projectivization ℂ E → Projectivization ℂ E)
    (h_products : ∀ (x y : E) (hx : x ≠ 0) (hy : y ≠ 0),
      ‖x‖ = 1 → ‖y‖ = 1 →
      f (Projectivization.mk ℂ x hx) = Projectivization.mk ℂ y hy →
      ∀ j k, ⟪b j, y⟫_ℂ * star ⟪b k, y⟫_ℂ =
        star (⟪b j, x⟫_ℂ * star ⟪b k, x⟫_ℂ)) :
    ∃ K : E ≃ₗᵢ⋆[ℂ] E,
      f = Projectivization.map K.toLinearEquiv.toLinearMap K.injective := by
  obtain ⟨K, hK, _⟩ := exists_coordinate_conjugation b
  exact ⟨K, eq_map_of_conjugated_coordinate_products b f K hK h_products⟩

end GraduateQM.Wigner
