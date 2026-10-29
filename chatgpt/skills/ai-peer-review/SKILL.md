---
name: ai-peer-review
description: Use the installed poldrack AI Peer Review CLI to obtain independent manuscript critiques from multiple model providers and compare common versus model-specific concerns. Use for multi-model peer review or meta-review, not journal-agent orchestration or revision issue tracking.
---

# Multi-model manuscript review

This Codex entrypoint uses [poldrack/ai-peer-review](https://github.com/poldrack/ai-peer-review), a Python CLI rather than an upstream Codex skill.

## Runtime

Locate `ai-peer-review/.venv` under `PROJECT_REVIEW_TOOLS`, or `%LOCALAPPDATA%/codex-research-tools` on Windows and `~/.local/share/codex-research-tools` elsewhere. Honor an explicit source/runtime path. Use its `Scripts/ai-peer-review.exe` or `bin/ai-peer-review`; prepend that directory to PATH only for the process if needed. Set `PYTHONUTF8=1` for Windows output. If absent, use project_skills `scripts/setup_review_tools.py --tools ai-peer-review --python <Python-3.13-or-newer>`.

Check `--help`, `review --help`, and `list-models` before a review. These local checks do not prove remote model access. Use the paper supplied by the user; this installation workflow alone does not submit any manuscript.

## Before an actual model run

Read the installed source's `src/ai_peer_review/review.py`, `cli.py`, and `llm_clients/` for the selected provider mappings. The pinned upstream exposes legacy CLI aliases, hardcodes older provider model IDs, and uses a Google Gemini preview ID for both meta-review and concern extraction. The CLI label can differ from the model actually requested. Verify supported IDs for the intended providers; report incompatibility instead of silently substituting models or claiming a successful comparison.

Credentials come from the intended provider's environment variables or the upstream local config. Check only presence, never print key values. Pass `--config-file` before the subcommand if using one. The default prompt is neuroscience/brain-imaging specific: use an appropriate domain prompt for the manuscript. The bundled `configs/scientific-only.json` focuses on scientific validity rather than prose style; inspect and adapt its domain instructions if needed. Keep credentials outside the registry and report the prompt/profile used.

## Execution and evidence

- Explicitly select the requested models. For individual reviews only, use `review <paper.pdf> --models <aliases> --no-meta-review --output-dir <new-session-dir>`; otherwise the upstream also attempts its hardcoded Google meta-review/concerns calls. Full comparison output requires that Google path to work as well as the selected review providers.
- Use a fresh session directory per manuscript revision/configuration. The upstream reuses existing per-model review files by default, so reusing a directory could mix different manuscript versions.
- Verify PDF text extraction. Image-only pages and figures need separate inspection; text extraction does not establish visual review.
- Preserve each model's output. Check that every selected model returned a substantive review before comparing results. Report the actual model IDs, failures, missing outputs, meta-review status, and CSV/JSON artifacts that really exist. Keep common and unique concerns tied to the originating reviews.

Package installation, API-key presence, model access, and completed manuscript review are separate states. Do not represent a help/model-list check as a successful paid review.
