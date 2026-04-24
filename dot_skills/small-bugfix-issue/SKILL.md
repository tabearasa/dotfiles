---
name: create-small-bugfix-for-a-project
description: Create a fix to a bug issue from gitlab
allowed-tools: read, write, edit, bash
---

Phases: Reproduce → Plan → Failing Test → Fix → Verify
Key Rule: Never fix without a failing test
Output: Minimal fix + test that prevents regression

Bug fixing workflow:
0. Setup
1. Reproduce
2. Plan
3. Failing Test
4. Fix
5. Verify

## 0 Setup

Before you start with anything. Make sure, that you are on the
devel branch (or a simular development branch) and start a new
branch for the upcoming work of yours from the devel branch
with the issue ticket id at the start like this:

```bash
git status
# Output should show, that you are on the main branch

git switch -c [issue-ticket-id]-bugfix-copilot
```

## 1 Reproduce the Bug

Goal: Confirm the bug exists and understand how to trigger it.

Procedure:

Read the ticket description and any error logs/screenshots.
You can read the bugfix description via:

```bash
glab issue view [args]
```

Only utilize tools for reading issues. The user will give you
an issue ticket

Identify the reproduction steps from the ticket
Execute reproduction steps in local environment
Document the observed behavior vs expected behavior
If cannot reproduce: ask user for more context, check environment differences
Output: Bug reproduction confirmed with clear steps

### Bug Reproduction
- **Steps to reproduce:**
  1. ...
  2. ...
- **Expected:** ...
- **Actual:** ...
- **Environment:** <runtime version>, <os/platform>
Key Rule: Cannot proceed without reproduction. If you can't trigger the bug, you can't verify the fix.

## 2 Plan (Root Cause + Fix)
Goal: Understand WHY the bug occurs and design the fix approach.

Procedure:

Trace the code path from reproduction steps
Read relevant source files
Form hypothesis about the cause
If root cause is unclear:
Add debug logging (logger.debug, NOT console.log)
Run with debug logs and analyze output
Do NOT change implementation code yet
Once root cause is identified, use /developer for code patterns
Design the minimal fix approach
Get user approval on the fix plan
Debug Logging Pattern:

# Add temporary debug logging to trace execution
# Python:     logger.debug(f"checkpoint: {var1=}, {var2=}")
Output: Root cause identified + fix plan approved

### Root Cause & Fix Plan
- **Location:** `<file>:<line>`
- **Cause:** Off-by-one error in array index comparison (uses `<` instead of `<=`)
- **Why it happens:** Edge case when index equals array length exactly
- **Fix:** Change `<` to `<=` in boundary comparison
- **Edge cases:** Empty array, single element, last element
Key Rule: Get user approval before proceeding. Never guess-and-fix.

## 3 Write Failing Test
Goal: Capture the bug in a test that fails with current code.

Procedure:

Identify the appropriate test file (unit or regression)
Write a test that exercises the exact reproduction scenario
Run the test to confirm it FAILS (this is expected)
The test should fail for the right reason (the bug, not a typo)
Output: A failing test that documents the bug

# Write a test that exercises the exact bug scenario
# The test MUST fail before the fix is applied

# Python/pytest:    def test_boundary(): assert fn(edge) == expected
Key Rule: Do NOT proceed to fixing until you have a failing test. The test is proof the bug exists and will prevent regression.

Goal: Implement the minimal fix that makes the failing test pass.
## 4 Fix and Verify Test Passes

Procedure:

Make the minimal change to fix the root cause
Run the failing test - it should now PASS
If test still fails: re-analyze, your fix may be incomplete
Remove any temporary debug logging added in Phase B2
Output: Failing test now passes, debug logs removed

# Example: Off-by-one fix (language agnostic)
# Before (bug):  if index < length
# After (fix):   if index <= length
Key Rule: Minimal fix only. Do not refactor, clean up, or "improve" surrounding code. That's a separate task.

## 5 Regression Testing
Goal: Ensure the fix doesn't break anything else.

Procedure:

Run full test suite (use project's configured test command)
If any tests fail:
Analyze if failure is related to the fix
If related: the fix may have unintended side effects, re-analyze
If unrelated: investigate separately (may be flaky test)
Run pre-commit checks (use project's configured precommit command)
All tests must pass before considering the bug fixed
Output: All tests pass, pre-commit succeeds

task test             # Run all tests
task precommit        # Run lint + tests
Flow Diagram
┌─────────────────┐
│ Bug reported    │
└────────┬────────┘
         │
         ▼
┌─────────────────┐     ┌─────────────────┐
│ B1: REPRODUCE   │────►│ Cannot reproduce│
│                 │     │ Ask for context │
└────────┬────────┘     └─────────────────┘
         │ ✓ Confirmed
         ▼
┌─────────────────┐     ┌─────────────────┐
│ B2: PLAN        │────►│ Unclear cause?  │
│ Root cause +    │     │ Add debug logs  │
│ fix approach    │◄────│ Re-analyze      │
│ (uses /developer)│     └─────────────────┘
└────────┬────────┘
         │ ✓ User approved
         ▼
┌─────────────────┐
│ B3: FAILING TEST│
│ Write test that │
│ captures bug    │
└────────┬────────┘
         │ ✓ Test fails
         ▼
┌─────────────────┐     ┌─────────────────┐
│ B4: FIX         │────►│ Test still fails│
│ Minimal change  │     │ Re-analyze fix  │
│                 │◄────│                 │
└────────┬────────┘     └─────────────────┘
         │ ✓ Test passes
         ▼
┌─────────────────┐     ┌─────────────────┐
│ B5: VERIFY      │────►│ Other tests fail│
│ Run all tests   │     │ Check side      │
│                 │◄────│ effects         │
└────────┬────────┘     └─────────────────┘
         │ ✓ All pass
         ▼
┌─────────────────┐
│ Ready for       │
│ /commit         │
└─────────────────┘
Bug Fix Context
When working on a bug fix, track progress in workflow context:

{
  "type": "fix",
  "bugfix": {
    "phase": "plan",
    "reproductionConfirmed": true,
    "rootCause": "Off-by-one in boundary comparison",
    "rootCauseLocation": "<file>:<line>",
    "planApproved": true,
    "failingTestFile": "<test-file>"
  }
}

Anti-Patterns
Don't	Do Instead
Jump straight to fixing	Reproduce first, plan the fix
Change code to debug	Add debug logs, analyze, then change
Fix without approval	Get user approval on fix plan
Fix + refactor together	Minimal fix only, refactor separately
Skip regression tests	Always run full test suite
Guess the root cause	Trace code path, add logs if unclear
Integration with Workflow

Invokes bugfix skill for phases B1-B5
After phase 5 passes: /commit → /pr-create
