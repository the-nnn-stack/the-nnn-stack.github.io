# NNN STACK

**NixOS · Niri · Noctalia-shell**

A single-page site for people running the NNN stack. Zero build step,
zero framework. Deploys straight to GitHub Pages.

## Add yourself

1. Fork
2. Append to [`members.json`](./members.json):

   ```json
   { "github": "yourhandle", "dotfiles": "https://github.com/yourhandle/nixos-config" }
   ```

3. PR

`dotfiles` is optional. If omitted, your avatar links to your GitHub
profile instead.

Your avatar is pulled from `github.com/<handle>.png`. Keep entries
alphabetical by handle to reduce merge conflicts.

## Local preview

```sh
nix run .#serve
# → http://localhost:8080
```

or any static server pointed at the repo root.

## Deploy

Push to `main` → GitHub Actions publishes to Pages. See
[`.github/workflows/pages.yml`](.github/workflows/pages.yml).
