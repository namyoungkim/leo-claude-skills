---
name: git-workflow
description: GitHub Flow branching strategy guide. Use for branch creation, naming conventions, PR workflows, and commit messages. Triggers on "branch strategy", "commit message", "create PR", "feature branch".
---

# Git Workflow (GitHub Flow)

## Branch Strategy

| Branch | Role |
|--------|------|
| `main` | Always deployable, triggers auto-deploy |
| Work branches | `feature/*`, `fix/*`, `refactor/*`, `docs/*`, `chore/*` |

## Branch Naming

| Prefix | Purpose | Example |
|--------|---------|---------|
| `feature/` | New feature | `feature/watchlist-export` |
| `fix/` | Bug fix | `fix/login-redirect` |
| `refactor/` | Code refactoring | `refactor/api-structure` |
| `docs/` | Documentation | `docs/api-guide` |
| `chore/` | Config/maintenance | `chore/update-deps` |

## Workflow

### 1. Create Branch
```bash
git checkout main
git pull origin main
git checkout -b feature/new-feature
```

### 2. Develop & Commit
```bash
git add .
git commit -m "feat: add feature description"
```

### 3. Push & Create PR
```bash
git push -u origin feature/new-feature
gh pr create --title "feat: description" --body "## Summary\n- Changes"
```

### 4. Merge & Cleanup
```bash
gh pr merge --merge
git checkout main
git pull
git branch -d feature/new-feature
```

## Commit Message Format

```
<type>: <subject>

<body> (optional)
```

### Types

| Type | Purpose |
|------|---------|
| `feat` | New feature |
| `fix` | Bug fix |
| `refactor` | Refactoring (no behavior change) |
| `docs` | Documentation only |
| `chore` | Config, deps, build |
| `test` | Add/modify tests |
| `style` | Formatting, semicolons |
| `perf` | Performance improvement |

### Examples

```bash
feat: add watchlist CSV export
fix: resolve login redirect issue
refactor: simplify API response handler
docs: add API documentation
chore: update dependencies
```

## Exceptions

- Typos, single-line fixes: direct commit to `main` allowed
- No `dev` branch needed (Preview deployment serves as staging)

## Common Commands

```bash
# List branches
git branch -a

# Fetch remote
git fetch origin

# Update main
git checkout main && git pull

# Merge main into feature branch
git checkout feature/xxx
git merge origin/main

# Stash changes
git stash
git stash pop

# Undo commit (keep changes)
git reset --soft HEAD~1

# Discard file changes
git checkout -- filename
```
