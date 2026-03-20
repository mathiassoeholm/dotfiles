---
description: Decompose a plan into thin, test-first, end-to-end increments
agent: plan
---

Take the plan and decompose it into thin, end-to-end increments where each slice starts with a test and delivers something I can verify and commit.

DO NOT START IMPLEMENTING YET.

Testing guidance:
- Prefer fewer tests that test multiple things; you don't need a test in every slice if it is covered by another slice
- Prefer deep/sociable tests with less mocking
- Check if existing test cases can cover the new functionality if they are updated
