---
name: git-guardrails-codex
description: Configure Codex PreToolUse hooks that block destructive Git commands before execution. Use when the user asks for an additional local Git safety hook in Codex.
---

# Git guardrails for Codex

Install an opt-in `PreToolUse` hook that blocks `git push`, `git reset --hard`, forced `git clean`, `git branch -D`, and whole-tree checkout or restore commands.

## 1. Choose scope

Ask whether the hook should apply to the current repository or all Codex projects:

- Repository: `<repo>/.codex/hooks.json` and `<repo>/.codex/hooks/`
- User: `~/.codex/hooks.json` and `~/.codex/hooks/`

Do not enable the hook until the user chooses the scope because this changes future command execution.

## 2. Copy both implementations

Copy [scripts/block-dangerous-git.sh](scripts/block-dangerous-git.sh) and [scripts/block-dangerous-git.ps1](scripts/block-dangerous-git.ps1) into the selected `hooks` directory. Preserve existing hooks and configuration.

## 3. Merge the hook definition

Merge this entry into `hooks.PreToolUse` in the selected `hooks.json`:

```json
{
  "hooks": {
    "PreToolUse": [
      {
        "matcher": "^Bash$",
        "hooks": [
          {
            "type": "command",
            "command": "bash /absolute/path/to/.codex/hooks/block-dangerous-git.sh",
            "commandWindows": "powershell -NoProfile -ExecutionPolicy Bypass -File C:\\\\absolute\\\\path\\\\to\\\\.codex\\\\hooks\\\\block-dangerous-git.ps1",
            "timeout": 10,
            "statusMessage": "Checking Git command"
          }
        ]
      }
    ]
  }
}
```

Use resolved absolute paths. If `hooks.json` exists, merge without overwriting unrelated hooks. Do not define the same hook both in `hooks.json` and `config.toml` at one scope.

## 4. Verify

Pipe representative Codex hook JSON to the platform script. Confirm a harmless command exits `0`, while `git push origin main` exits `2` and prints a blocking reason. Do not run the dangerous Git command itself.

Codex requires the user to review and trust a new or changed non-managed hook. Tell the user to complete that review when Codex prompts.

Offer to customize blocked patterns only after the default hook is verified.
