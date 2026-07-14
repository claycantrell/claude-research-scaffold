---
name: git-for-beginners
description: Plain-language Git for a non-technical user — snapshots, backups, undo, and disaster recovery. Use for any Git operation beyond a routine commit, and whenever the user says save, back up, undo, or go back.
---

# Git for Beginners

The user thinks in "saving" and "backing up." Never make them learn Git. The forbidden-commands list lives in CLAUDE.md and always applies.

## Vocabulary — say this, not that

| Instead of... | Say... |
|--------------|--------|
| "Let me commit your changes" | "Let me save a snapshot of your progress" |
| "I'll push to origin" | "I'll back up your work to GitHub" |
| "There are uncommitted changes" | "You have unsaved work — want me to save it?" |
| "Let me checkout that branch" | "Let me switch to a different version" |
| "There's a merge conflict" | "Two versions of the same section got edited differently — let me help you pick" |
| "I'll revert that commit" | "I'll undo those changes and save a new snapshot" |
| "Your working tree is dirty" | "You have some unsaved edits" |

## Saving a snapshot

```bash
git status && git diff              # see what changed
git add manuscript/main.md notes/new-note.md   # by name — never -A or .
git commit -m "Draft introduction and add 3 source papers"
```
Then: "I've saved a snapshot of your progress."

**Offer to save after:** drafting/editing a section, adding sources, creating notes, changing the outline or bibliography, before AND after any bulk operation, at session end, and before anything that touches many files.

## Backing up

`git push` → "Your work is backed up online. Even if something happens to your computer, everything is safe."

Never amend a pushed commit — it desyncs the user's backup.

## Undo — always confirm before undoing anything

1. First understand what they want to undo: the last edit? today? back to yesterday?
2. Recent unsaved edits: `git diff` to see, then `git checkout -- <specific file>` — never `git checkout .`
3. Back to a previous snapshot: `git log --oneline` to find it, `git show <hash>:<file>` to view; recreate the old content as a new save rather than rewriting history
4. Confirm scope: "I can undo the changes to your introduction. Your notes and sources won't be affected. Go ahead?"

## Disasters

- **User asks to delete files:** confirm exactly which, explain, snapshot BEFORE deleting
- **Something looks wrong:** `git status` + `git log --oneline -5`. Almost everything is recoverable. Don't panic, don't run destructive commands to "fix" it
- **Bad state:** set work aside with a temporary WIP commit, fix the issue, then continue — explain in plain language
- **Pull conflicts:** never auto-resolve; show the user both versions and ask which to keep
- **Before anything risky** (switching versions, pulling updates, bulk changes): "Let me save your current work first, just to be safe."
