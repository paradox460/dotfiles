---
name: jj-commit
description: Describe the current jj working-copy change and commit it with `jj commit`. Use when the user asks to commit, describe, or finalize their current jujitsu change.
---

# jj-commit

Analyze the current jujitsu working-copy diff and commit it with a concise, descriptive message.

## Workflow

### Step 1: Inspect the current change

```bash
JJ_EDITOR=true jj diff --no-pager
```

If the diff is empty (no changes), report that there is nothing to commit and stop.

Also gather context on the current change description (if any):

```bash
JJ_EDITOR=true jj log --no-pager -r @ --template 'description'
```

### Step 2: Draft the commit message

Analyze the diff and write a commit message that:
- Is a single concise line (imperative mood, e.g. "Add X", "Fix Y", "Refactor Z")
- Describes **what** changed and **why** (when inferable from context)
- Follows the repository's commit style (check recent `jj log` entries if unsure)
- Does not exceed 72 characters

If the user supplied a message as an argument to `/jj-commit`, use that as-is (still validate it is non-empty).

### Step 3: Commit

```bash
JJ_EDITOR=true jj commit --no-pager --message "<message>"
```

`jj commit` finalizes the current working-copy change and opens a new empty working change on top.

### Step 4: Confirm

Show the user the committed change:

```bash
JJ_EDITOR=true jj log --no-pager -r '@-' --template 'change_id.short() ++ " " ++ description'
```

Report the short change ID and the message that was used.

## Notes

- Always use `--no-pager` to avoid interactive output.
- Always set `JJ_EDITOR=true` to suppress interactive editor prompts.
- Do **not** use `jj describe` here — `jj commit` both sets the description and seals the change in one step.
- If the user wants to only update the description without committing, they should use `jj describe --message "..."` instead.
