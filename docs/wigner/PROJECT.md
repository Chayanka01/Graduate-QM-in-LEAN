# First project: finite-dimensional Wigner theorem

Status: **PROVED** on 2026-10-09. The exact author-approved
[declaration](../../GraduateQM/Wigner/Frozen/ExistsUnitaryOrAntiunitary.lean)
is sealed; only its proof body changed. The [final independent audit](FINAL_AUDIT.md)
passed source fidelity, binder and dependency checks, dimensions zero/one/two,
and arbitrary sparse states. The complete theorem and its explicit consumers
compile with only `propext`, `Classical.choice`, and `Quot.sound`. The orchestrator separately reran the integration and exact sealed-source
checks. See [release verification](RELEASE.md) for publication and fresh-checkout
validation, and [orchestrator verification](ORCHESTRATOR_VERIFICATION.md) for the
additional current-checkout checks.

The direct Section III proof is implemented: normalize basis images, classify
pair circles, remove their offsets, prove one common orientation from coordinate
products, reconstruct every ray, and undo the normalizer. A genuine coordinate
conjugation antiunitary supplies the second branch. The witness and branch are
chosen before every state. Earlier helper and step audits are historical
milestones; their then-open obligations are discharged in the final assembly.

## Physical question

A pure quantum state is a ray, not an individual vector. Suppose a reversible
transformation of pure states preserves every transition probability. Why must
it come from a unitary or antiunitary transformation of the vector space?

The purpose of this project is to derive that structure while making the
assumptions visible. It should become the first substantial chapter of a
pedagogical graduate-QM formalization.

## Intended mathematical scope

Let H be a finite-dimensional complex inner-product space. A ray is an
equivalence class of nonzero vectors under multiplication by a nonzero complex
scalar. Equivalently, it is a one-dimensional complex subspace. Unit-vector
representatives differ by a scalar of modulus one.

For nonzero x and y, the transition probability of their rays is

    P([x], [y]) = |<x,y>|^2 / (||x||^2 ||y||^2).

This must be proved independent of representatives before being exposed as a
ray-level function. Its range, diagonal value, and orthogonality interpretation
are supporting results. The Born transition-probability formula is physical
input, not something Wigner's theorem derives.

The intended main result is:

    Every bijection T of the ray space satisfying
    P(T(r), T(s)) = P(r, s) for every pair of rays
    is induced by a single unitary or antiunitary operator U on H.

Induced means T([x]) = [U x] for every nonzero x. The same U and the same
linearity branch must work for all x. In the linear case U(a x + b y) =
a U(x) + b U(y); in the conjugate-linear case the two coefficients are
complex-conjugated. U is surjective and norm-preserving in both cases.

We intend arbitrary finite dimension, including explicit handling of dimensions
zero and one. The substantive geometric argument starts in dimension two.
Uniqueness and branch-exclusivity claims require separate dimension checks:
in dimension one, both branches induce the same map of the singleton ray space.
Do not silently claim cross-branch uniqueness there.

The headline hypotheses contain no assumed linearity, antilinearity, continuity,
vector-level lift, preferred basis, or coherent phase assignment. An
orthonormal basis can be chosen inside a proof; it is not extra physical data.
Bijectivity is retained as the reversible-symmetry assumption of the selected
classical statement, whether or not it can be weakened in finite dimensions.

## What 'from first principles' means here

We build the ray-level definitions and prove the Wigner implication, explaining
each mathematical dependency. Complex numbers, finite-dimensional linear
algebra, inner products, and suitable existing Mathlib theorems may be reused.
We do not import an already-proved Wigner theorem as the final argument, rebuild
real numbers, or claim to derive quantum mechanics from logic alone.

Existing formalizations are comparison material. Their assumptions and exact
exports must be audited before reuse. A compilation claim in another project's
README is not evidence that its result has our intended meaning.

## Proposed chapter arc

1. Vector representatives, rays, phase, and well-defined transition probabilities.
2. Linear and conjugate-linear maps; unitary and antiunitary operators and their
   induced action on rays. This proves that the proposed answers work.
3. The converse: use preservation of overlaps to constrain a general ray map.
4. Establish consistent relative phases and one global linear/conjugate-linear
   branch, including the two-dimensional case and zero-coordinate cases.
5. Construct the implementing operator and prove its properties, then establish
   its action on every ray.
6. Explain the remaining phase ambiguity with correct dimensional hypotheses.

This is a pedagogical outline. The separately reviewed source decomposition
is in [the dependency graph](DEPGRAPH.md), with its coverage inventory and
[review record](GRAPH_REVIEW.md). It remains a source-topology snapshot with
initial Lean planning fields. Its six source-gap markers identify omissions in
the written source; the implementation expands these arguments, and the final
audit verifies their consumption. Those labels are not the live proof status.

## Definition and theorem review

The lead prepares exact Lean declarations with complete meaning-carrying
bodies and independent review, while the orchestrator provides a physics
translation. Only then can the author approve and freeze them under Scott's
workflow. Topic selection does not mark an unseen declaration approved.

The first review must check representative independence, nonzero domains,
normalization, the meaning of a ray bijection, all-state quantifiers, global
branch consistency, surjectivity of the implementing operator, and low-dimensional exceptions. Proofs of basic lemmas are part of this larger target.

## Boundaries of this first project

The theorem classifies individual pure-state symmetries. It does not by itself
construct a representation of a whole symmetry group with coherent phases,
derive the Schrödinger equation, prove time reversal is always antiunitary,
or address mixed-state channels or infinite-dimensional operator domains.
Those are possible later chapters, with their own additional assumptions.

## Completed proof artifacts

- [Source provenance](source-lock.json), [approval](APPROVAL.md), and the exact
  frozen declaration with an unchanged elaborated type.
- Independently reviewed source graph and historical milestone audits.
- [Provider assembly](../../GraduateQM/Wigner/Provider.lean) consuming all
  constructed premises, with no custom axiom or remaining placeholder.
- [Final audit](FINAL_AUDIT.md) and [milestone ledger](../progress.json).
- `./scripts/check` builds the public sealed export and audits its exact axioms.

The pedagogical chapter outline above and extensions beyond this existence
statement are separate future work. The formalization is of a known theorem;
no new physics theorem or empirical result is claimed.
