---
name: paper-reviewer
description: Run initial peer review, reassess a revised manuscript against prior concerns, or inspect issue trajectories using paper-reviewer's persistent issues.yaml and stable reviewer personas. Use when the user asks whether a revision resolved earlier review comments.
---

# Manuscript review across revisions

Codex adapter for [sohan-shingade/paper-reviewer](https://github.com/sohan-shingade/paper-reviewer). The upstream ships Claude Code agents and slash commands; this adapter maps their workflow to Codex. It does not make `/review`, `/revise`, or `/issues` native Codex commands.

## Locate the source and choose the mode

Use `PROJECT_REVIEW_TOOLS/paper-reviewer`, or by default `%LOCALAPPDATA%/codex-research-tools/paper-reviewer` on Windows and `~/.local/share/codex-research-tools/paper-reviewer` on macOS/Linux. Honor an explicitly provided checkout. If absent, prepare the pinned source with `scripts/setup_review_tools.py --tools paper-reviewer` in project_skills. Keep this upstream source unmodified; save the manuscript, reviews, and issue database in the user's research workspace.

- `initial <paper-path> [--venue generic|neurips|nature|jama] [--difficulty gentle|standard|harsh|brutal] [--rebuttal]`: read the source's `.claude/commands/review.md` and the initial pipeline of `CLAUDE.md`.
- `revise <new-paper-path> --of vN`: read `.claude/commands/revise.md` and the revision pipeline. Require prior reviews and `reviews/<slug>/issues.yaml`; preserve the previous reviewer set and issue IDs. Treat `--of v1` as directory `v1`, never `vv1`.
- `issues <slug>`: read `.claude/commands/issues.md`, then summarize the real issue database directly. This mode does not launch reviewers or rewrite issues.

Infer the mode from a clear natural-language request. Resolve the paper slug/version from `papers/<slug>/versions/vN.pdf` or an explicit user mapping. For iteration, establish this mapping before writing. Ask for missing required inputs only.

## Codex mapping

Read the relevant upstream playbook, venue/difficulty configuration, and output templates. In upstream instructions:

- `Task` means an available Codex subagent call. Use the body and description of `.claude/agents/<role>.md` as its task instructions; `Read`, `Write`, `Bash`, `Grep`, `Glob`, and web tools mean the corresponding available Codex capabilities. Claude's frontmatter model/tool fields are metadata, not Codex configuration. Inherit the current model unless the user requests otherwise.
- Pass absolute source, manuscript, template, and output paths. Template/config paths refer to the upstream source; `papers/` and `reviews/` refer to the research workspace. Use native file tools on Windows; the upstream shell scripts are optional conveniences.
- Run independent reviewers as separate subagents, in batches if capacity is limited. Initial reviewers receive the same manuscript/context but not each other's reviews. Revisions receive the prior reviews, issue database, semantic diff, and author changelog. Keep role identities stable through saved artifacts; a persistent live agent is not required. If delegation is unavailable, report the limitation instead of labeling a single review independent multi-agent review.
- Only the issue-tracker role writes `issues.yaml`. Preserve its schema and history; make a versioned backup before updating. Each old issue requires a reviewer verdict tied to revised evidence. The author saying a concern is fixed is not a closure verdict.
- Honor desk rejection and parser failures. Report failed reviewers, unavailable consultants, inaccessible literature, or unreadable figures in the decision letter. Use available PDF extraction/rendering, with explicit extraction warnings when information is lost.

Follow the upstream ordering of editor synthesis and issue extraction/update. Validate the final issue counts and statuses against `issues.yaml` after the tracker completes, so the reported closure delta reflects the written database. Keep prior round artifacts intact. Summarize recommendation, unresolved issues, trajectory, and output paths in the user's language.
