#!/usr/bin/env python3
"""Install this repository's skill folders using only the Python standard library."""
import argparse
from datetime import datetime
import hashlib
import json
import os
from pathlib import Path
import re
import shutil
import sys
import tempfile
import uuid

ROOT = Path(__file__).resolve().parents[1]


def is_link(path):
    return path.is_symlink() or (hasattr(path, "is_junction") and path.is_junction())


def reject_links(folder):
    if is_link(folder):
        raise ValueError("Linked folder is not supported: " + str(folder))
    if folder.exists():
        for path in folder.rglob("*"):
            if is_link(path):
                raise ValueError("Linked file or folder is not supported: " + str(path))


def load_catalog():
    items = json.loads((ROOT / "catalog.json").read_text(encoding="utf-8"))["skills"]
    result = {}
    for item in items:
        name = item["name"]
        if not isinstance(name, str) or not re.fullmatch(r"[a-z0-9]+(?:-[a-z0-9]+)*", name):
            raise ValueError("Invalid skill name: " + repr(name))
        if name in result or item["path"] != "skills/" + name:
            raise ValueError("Duplicate name or invalid skill path: " + name)
        result[name] = item
    return result


def select_skills(catalog, requested):
    selected = set()
    pending = list(requested if requested is not None else catalog)
    while pending:
        name = pending.pop()
        if name not in catalog:
            raise ValueError("Unknown skill: " + name)
        if name in selected:
            continue
        selected.add(name)
        pending.extend(catalog[name].get("requires_skills", []))
    return sorted(selected)


def fingerprints(folder):
    # Include directories too: preserve extra empty directories on default skip.
    values = {}
    for path in sorted(folder.rglob("*")):
        key = path.relative_to(folder).as_posix()
        if path.is_file():
            values[key] = hashlib.sha256(path.read_bytes()).hexdigest()
        elif path.is_dir():
            values[key + "/"] = None
    return values


def destination(args):
    if args.dest:
        path = Path(args.dest).expanduser()
    elif args.agent == "claude":
        path = Path.home() / ".claude" / "skills"
    else:
        path = Path.home() / ".agents" / "skills"
    # Check before resolve() so a linked destination is not silently followed.
    if is_link(path):
        raise ValueError("Install destination must not be a link: " + str(path))
    path = path.resolve()
    source_root = (ROOT / "skills").resolve()
    if path == Path(path.anchor) or path == source_root or source_root in path.parents or path in source_root.parents:
        raise ValueError("Install destination overlaps source files or is a filesystem root.")
    if path.exists() and not path.is_dir():
        raise ValueError("Install destination is not a folder: " + str(path))
    return path


def install_one(source, target, dest, update, dry_run):
    exists = target.exists() or is_link(target)
    if exists and not update:
        print("SKIP " + target.name + " (already exists)")
        return
    if exists:
        if not target.is_dir():
            raise ValueError("Existing skill is not a folder: " + str(target))
        reject_links(target)
        if fingerprints(source) == fingerprints(target):
            print("UNCHANGED " + target.name)
            return
    action = "UPDATED" if exists else "INSTALLED"
    if dry_run:
        print("WOULD " + action + " " + target.name + (" (backup first)" if exists else ""))
        return
    dest.mkdir(parents=True, exist_ok=True)
    # Stage a complete copy before changing a previously installed skill.
    stage = Path(tempfile.mkdtemp(prefix=".project-skills-stage-", dir=str(dest)))
    backup = None
    try:
        staged_skill = stage / target.name
        shutil.copytree(source, staged_skill)
        if exists:
            backup_root = dest.parent / ".project-skills-backups"
            if is_link(backup_root):
                raise ValueError("Backup destination must not be a link: " + str(backup_root))
            stamp = datetime.now().strftime("%Y%m%d-%H%M%S") + "-" + uuid.uuid4().hex[:8]
            backup = backup_root / stamp / target.name
            backup.parent.mkdir(parents=True, exist_ok=False)
            target.rename(backup)
        try:
            staged_skill.rename(target)
        except OSError:
            if backup is not None and not target.exists():
                backup.rename(target)
            raise
        print(action + " " + target.name)
        if backup is not None:
            print("BACKUP " + str(backup))
    finally:
        # This path came from mkdtemp within the explicit installation destination.
        stage.relative_to(dest)
        if stage.exists():
            shutil.rmtree(stage)


def main(argv=None):
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--list", action="store_true", help="List repository skills; do not install.")
    parser.add_argument("--skills", nargs="+", help="Install selected names and their referenced skills.")
    parser.add_argument("--dest", help="Explicit destination folder (overrides --agent).")
    parser.add_argument("--agent", choices=["codex", "claude"], default="codex", help="Select default user folder.")
    parser.add_argument("--dry-run", action="store_true", help="Show planned actions without writing.")
    parser.add_argument("--update", action="store_true", help="Replace changed skills after backing up old folders.")
    args = parser.parse_args(argv)
    try:
        catalog = load_catalog()
        selected = select_skills(catalog, args.skills)
        if args.list:
            for name in selected:
                print(name + ": " + catalog[name]["description_ko"])
            print("TOTAL " + str(len(selected)))
            return 0
        dest = destination(args)
        # Validate all sources and update targets before any installation takes place.
        for name in selected:
            source = ROOT / catalog[name]["path"]
            reject_links(source)
            if not (source / "SKILL.md").is_file():
                raise ValueError("Missing SKILL.md: " + name)
            target = dest / name
            if args.update and (target.exists() or is_link(target)):
                reject_links(target)
                if not target.is_dir():
                    raise ValueError("Existing skill is not a folder: " + str(target))
        print("DEST " + str(dest))
        for name in selected:
            install_one(ROOT / catalog[name]["path"], dest / name, dest, args.update, args.dry_run)
        return 0
    except (OSError, ValueError, KeyError, TypeError) as exc:
        print("ERROR " + str(exc), file=sys.stderr)
        return 1


if __name__ == "__main__":
    raise SystemExit(main())
