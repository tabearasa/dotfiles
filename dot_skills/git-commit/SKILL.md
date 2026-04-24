---
name: git-commit
description: Create atomic commits in conventional commit style
---

# Commit

Create atomic commits in the conventional commit style using only non-interactive commands.

## Process

- Inspect current changes with `git status` and `git --no-pager diff HEAD`.
- Decide whether the changes should be one commit or several logical commits.
- If multiple logical changes exist, plan and split them into separate commits.
- For each commit:
  - Stage only the relevant changes with `git add ...`.
  - Review the staged diff (e.g. `git --no-pager diff --cached`) to confirm what’s included.
  - Commit with a message (`git commit -m "…"`) following the style below.
- Return the commits to the user.

## Style

- **Atomic**: One concern per commit.
- **Split big changes**: Separate features, fixes, refactors, docs, etc. when they are independent.
- **Subject line**:
  - Format: `type(optional scope): <description>` (see [the reference guide](./references/REFERENCE.md))
  - Under 72 characters.
  - No trailing period.
- Always ensure the commit message accurately reflects the diff.

## Splitting Commits

Split into multiple commits when:

- Changes touch unrelated parts of the codebase.
- Different types of work are mixed (feature, fix, refactor, docs, tests, chore).
- Different file types are mixed in a way that’s easier to review separately (e.g. code vs docs).
- The diff is very large and can be broken into smaller, easier-to-review steps.

