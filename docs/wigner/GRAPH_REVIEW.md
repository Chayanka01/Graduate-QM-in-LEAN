# Wigner source graph review

The graph records the direct proof in Simon et al., arXiv:0808.0779v2,
Section III, against the source snapshot and hashes in `source-lock.json`.
It is a source-topology artifact, not evidence that a Lean theorem is proved.

## Independent slice review

Reviewer: `wigner-graph-slice-review`. The reviewer was distinct from both
extractors and the central writer. Read scope: all 96 lines of
`PROOF_SOURCE.md`, all graph and coverage records, primary Section II
(2.1)–(2.14) and its theorem statement, and Section III (3.1)–(3.28)
including the conclusion.

The initial review required two corrections. Diagonal normalization now
directly consumes orthonormal-basis construction, complex arithmetic, and
the induced-ray-action bridge. Denormalization also directly consumes that
bridge. The external isometry leaf supplies preservation and equivalence
laws, without silently supplying either construction or quotient descent.
After those four edges and their use-site explanations were integrated, a
targeted rereview accepted both corrected nodes and their coverage entries.

Verdict: all 28 nodes, 70 edges, and 24 inventory entries accepted for source
topology. The dimension cases are required case coverage; pair signs precede
arbitrary states; the final operator precedes all rays; sparse reconstruction
must allow zero coordinates and choose a nonzero coordinate for each state.

## Independent global review

Reviewer: `wigner-graph-global-review`, fresh and distinct from the writer,
extractors, and slice reviewer. Read scope: the complete source transcription,
all graph and coverage records, permitted frozen identity metadata and
statement header, and the same primary Section II and III passages.

Verdict: PASS for the entire `wigner.root` closure. No correction was required.
The independently reconstructed root hypotheses, quantifiers, conclusion,
and witness scope match the recorded fields. The reviewer checked the
scalar-orbit/unit-phase carrier bridge, dimension 0/1/2 cases, conjugation
convention, conditional-premise discharge, inverse normalization order,
consumer edge evidence, external boundaries, and AND/OR structure.

All 28 nodes are reachable, all 27 non-anchor frozen fields are empty, and all
24 coverage dispositions are consistent (22 mapped, two excluded). There
are five ordinary external leaves, no standing assumptions, and no alternative
routes. The six source gaps below remain. Frozen metadata identification is
not an independent ABI certification.

## Open source obligations

The graph retains six explicit gaps: induced ray action, pair-circle
classification, construction of a full-support real test vector, triple-sign
consistency, global-sign propagation, and sparse-state reconstruction.
These are mathematical obligations, not additional hypotheses on the root.
The suggested complex phase test for triple consistency requires a genuine
nonnegativity contradiction; merely showing a cyclic product is real does
not establish the required claim.

No implementation Lean files or proof-status evidence were supplied to the
reviewers. The graph's initialized Lean fields carry no proof assertion.

## Structural validation

Both commands passed on 2026-10-09:

```sh
python3 .agents/skills/build-proof-dependency-graph/scripts/proof_depgraph.py --db docs/wigner/DEPGRAPH.md --manifest docs/wigner/DEPGRAPH_COVERAGE.md --source-root . --require-reviewed --require-complete-coverage --require-initial-lean-status --require-all-reachable --write-dashboard
python3 .agents/skills/build-proof-dependency-graph/scripts/proof_depgraph.py --db docs/wigner/DEPGRAPH.md --manifest docs/wigner/DEPGRAPH_COVERAGE.md --source-root . --require-reviewed --require-complete-coverage --require-initial-lean-status --require-all-reachable --check
```

This completes source-graph delivery. Later Lean implementation and its
independent audits are recorded separately; the graph's initial status fields
are not a live proof-progress ledger.

## Sealing lifecycle metadata rebinding

On 2026-10-09 the same independent global reviewer approved refreshing only the
`FROZEN_MANIFEST` header hash from
`ec4ac72d880a5b7c560df00fcda1695165a2a792988e3ac86bddce6351ba1deb` to
`d3592e8377ec0578c6f482bdbbd1cfea61b04e42892628c94d7391f714bb95a8`, plus its
provenance note. Reverting only the manifest lifecycle state from SEALED to
DRAFT_SORRY reconstructs the exact original hash. All anchor identity, source,
contract and ABI fields are unchanged. No node, edge, source claim or initial
Lean planning field changed. This is a header lifecycle binding update; the
node-level AMEND schema has no header operation. The review made no proof
assessment. The separate [final theorem audit](FINAL_AUDIT.md) records that result.
