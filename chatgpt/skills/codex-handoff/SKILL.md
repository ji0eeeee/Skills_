---
name: codex-handoff
description: Hand the current conversation to a new Codex task that starts working from a concise, redacted summary. Use only when the user explicitly asks to create or hand work to a new task.
---

Create a concise handoff summary of the current conversation, then create a new Codex task seeded with that summary.

Use the Codex task-creation capability rather than invoking an external agent CLI. Follow the user's requested project and environment. If no destination is specified, preserve the current project context when possible; otherwise create a projectless task. Do not create a new task unless the user explicitly asked for one.

Include a "suggested skills" section naming relevant Codex skills with `$skill-name` syntax. Reference existing specs, plans, ADRs, issues, commits, and diffs by path or URL instead of duplicating them.

Redact API keys, passwords, tokens, and personal information from the handoff prompt. If the user supplied a focus, tailor the new task to it.

After creation, report the new task using the task reference returned by Codex.

