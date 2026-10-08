module

public import Mathlib.Analysis.InnerProductSpace.Basic

/-!
A build and dependency smoke test only. This is not a formalized QM result.
-/
public section

namespace GraduateQM.Infrastructure

/-- Confirms that real analysis is available from the pinned Mathlib. -/
theorem real_square_nonnegative (x : ℝ) : 0 ≤ x * x := mul_self_nonneg x

end GraduateQM.Infrastructure
