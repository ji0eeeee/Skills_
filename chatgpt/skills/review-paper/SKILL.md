---
name: review-paper
description: Review an academic manuscript against a target journal or conference using Agentic Reviewer's journal exploration and five specialist review dimensions. Use for journal-fit and pre-submission review; use paper-reviewer for cross-revision issue tracking.
---

# Journal-targeted manuscript review

This is a portable Codex entrypoint for [Agentic Reviewer](https://github.com/FilippoScaramuzza/agentic-reviewer), not a replacement implementation of its specialist prompts.

## Locate the framework

Use `PROJECT_REVIEW_TOOLS/agentic-reviewer` if that environment variable is set; otherwise use `%LOCALAPPDATA%/codex-research-tools/agentic-reviewer` on Windows or `~/.local/share/codex-research-tools/agentic-reviewer` on macOS/Linux. An explicitly supplied upstream checkout takes precedence. If absent, prepare it using `scripts/setup_review_tools.py --tools agentic-reviewer` from the project_skills registry.

Resolve a paper path and target venue from the request; ask only for a missing required input. Keep outputs in the user's research workspace, separate from the installed framework.

## Run the upstream workflow

1. Read the framework's `.agents/skills/review-paper/SKILL.md` and `prompts/editor-in-chief.txt`. Resolve prompt paths against the framework and output/cache paths against the research workspace.
2. Follow its conversion, journal exploration, five-dimension review, and compilation phases. Reuse complete, current journal context; honor `re-explore`.
3. Use available Codex subagents with each role's `developer_instructions` from `.codex/agents/<role>.toml` or its matching `prompts/<role>.txt`. Pass the paper, required context, absolute prompt/output paths, and the specific role. Default to the parent's model settings. Batch independent roles within the host's concurrency limit; twelve roles does not require twelve simultaneous agents. If named roles are unavailable, pass their instructions to ordinary subagents. If delegation is unavailable, report that the upstream multi-agent workflow cannot run in this session.
4. For PDF/DOCX input, use the framework's `.venv` markitdown executable, or an already available equivalent extraction tool. Check extraction against the original, especially figures and equations. Markdown input needs no converter. Record inaccessible full texts as missing evidence.
5. Produce the numbered artifacts and `10-final-review-report.md` under `reports/<journal-slug>/<timestamp>/`. Generate the upstream PDF only when pandoc and a PDF engine are available; otherwise deliver the Markdown and name the missing export dependency. Match the user's report language.

Report substantive concerns with manuscript locations and evidence, and distinguish missing reporting from proof that a method was not performed. An AI recommendation is pre-submission feedback. Installing this entrypoint alone does not install the framework, its Python conversion environment, or PDF export tools.
