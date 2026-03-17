---
name: gstack-local-only
description: gstack must stay project-local — never install globally or in ~/.claude/
type: feedback
---

All gstack installations, upgrades, and dependencies must remain within the project folder only. Never install anything to ~/.claude/skills/gstack/ or any global/home directory.

**Why:** User explicitly requires no global commands or dependencies. Everything project-scoped.
**How to apply:** During gstack upgrades, skip any "sync local vendored copy" steps that reference ~/.claude/. Only operate on the project's .claude/skills/gstack/ directory.
