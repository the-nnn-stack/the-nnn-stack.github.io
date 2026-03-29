#!/usr/bin/env python3
"""Validate members.json so bad PRs fail CI instead of breaking the site."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path

GITHUB_RE = re.compile(r"^[A-Za-z0-9](?:[A-Za-z0-9-]{0,37}[A-Za-z0-9])?$")


def main() -> int:
    path = Path(sys.argv[1] if len(sys.argv) > 1 else "members.json")
    data = json.loads(path.read_text())

    if not isinstance(data, list):
        print("members.json must be a JSON array", file=sys.stderr)
        return 1

    errors: list[str] = []
    seen: set[str] = set()

    for i, m in enumerate(data):
        where = f"entry[{i}]"
        if not isinstance(m, dict):
            errors.append(f"{where}: must be an object")
            continue

        gh = m.get("github")
        if not isinstance(gh, str) or not GITHUB_RE.match(gh):
            errors.append(f"{where}: 'github' must be a valid GitHub username")
        else:
            key = gh.lower()
            if key in seen:
                errors.append(f"{where}: duplicate github handle '{gh}'")
            seen.add(key)

        dot = m.get("dotfiles")
        if dot is not None:
            if not isinstance(dot, str) or not dot.startswith(("http://", "https://")):
                errors.append(f"{where}: 'dotfiles' must be an http(s) URL")

        extra = set(m) - {"github", "dotfiles"}
        if extra:
            errors.append(f"{where}: unknown keys {sorted(extra)}")

    if errors:
        print("\n".join(errors), file=sys.stderr)
        return 1

    print(f"ok: {len(data)} member(s)")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
