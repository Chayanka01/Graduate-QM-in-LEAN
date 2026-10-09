# Graduate QM in Lean

An experimental graduate quantum mechanics learning project with AI-assisted,
kernel-checked Lean proofs. The infrastructure is verified. The first selected project is **Wigner's theorem
in finite-dimensional quantum mechanics**, currently at source and statement
review. No Wigner theorem is claimed proved.

## Local setup

- Lean **4.34.1**, the latest stable release checked on 2026-10-09.
- Mathlib **4.34.1**, pinned to an exact commit and a committed Lake manifest.
- All 12 Scott Armstrong skills, pinned with original licenses and provenance.
- A high-level physics orchestrator, a separate **gpt-6-astra / xhigh** lead,
  and **gpt-6-astra / medium** workers and independent auditors.
- A requested ceiling of **20 workers**, subject to the actual session limit.
  Agent settings do not establish that all 20 slots are available.

Lean, elan, build outputs, and caches live inside this checkout. No global Lean
installation or shell-profile edits are required. Use Python 3.12+ and Git:

```sh
python3 scripts/bootstrap.py
./scripts/lean --version
./scripts/check
```

Use `./scripts/lake` and `./scripts/lean` for every project command. The wrappers
select the local environment even if other Lean versions are installed.
Bootstrap needs network access. Routine builds can reuse the downloaded cache.
The smoke check imports real-analysis/inner-product-space infrastructure, builds
this library, and checks the smoke theorem's exact axiom dependencies. It does
not certify a future physics translation or audit every future declaration.

## Working with the agents

Keep talking to the orchestrator in Codex. It passes approved work to the lead,
which prepares bounded worker packets, integrates results, and arranges an
independent audit. Start with a small team and increase parallelism only when
the proof has independent parts. At most two build jobs run concurrently.

Project skills are discovered through `.agents/skills`; they become available
on the next turn/new chat. Agent roles and defaults are in `.codex/`. Existing
sessions may retain their old limits. The desktop's effective runtime settings
always take precedence over a requested ceiling.

The active milestone is preparing the exact Wigner theorem statement and its
independent semantic review. Read [the project scope](docs/wigner/PROJECT.md),
[the sources](docs/wigner/SOURCES.md), [the workflow](docs/WORKFLOW.md), and
[agent rules](AGENTS.md).
The pinned skill workflow requires independent statement review and explicit
approval of exact source-facing declarations before proof campaigns begin.

## Provenance

[Scott Armstrong's skills](https://github.com/scottnarmstrong/LeanAutoformalizationSkills)
are vendored at commit `05a07311f16bc581729e52f3e73647b95fa9bef1`. The snapshot is
unmodified, and project-local links are portable. Its original
[license](vendor/LeanAutoformalizationSkills/LICENSE),
[provenance](vendor/LeanAutoformalizationSkills/PROVENANCE.md), and
[third-party notices](vendor/LeanAutoformalizationSkills/THIRD_PARTY_NOTICES.md)
remain with it. Hashes in `docs/skills-checksums.json` detect accidental edits.

[Dependency pins](docs/dependencies.json) record versions;
[the milestone ledger](docs/progress.json) records scope.
Official [Codex subagent documentation](https://learn.chatgpt.com/docs/agent-configuration/subagents)
describes the requested project settings.
