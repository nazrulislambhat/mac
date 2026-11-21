# mac-setup

One command to rebuild my Mac after a reset or on a new machine: apps, CLI tools, fonts, VS Code extensions and Node.

## Restore

1. Sign in to the **App Store** (needed for Xcode).
2. Run:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/nazrulislambhat/mac-setup/main/install.sh)"
```

Re-running is safe: anything already installed is skipped. Xcode is a very large download, so expect it to take a while.

Prefer to read it first? Clone the repo and run `./install.sh`.

## What's in here

| File | Purpose |
|---|---|
| `Brewfile` | Everything installed through Homebrew: CLI tools, GUI apps, fonts, App Store apps, VS Code extensions |
| `install.sh` | Bootstraps CLT and Homebrew, runs `brew bundle`, installs Node 22 via nvm, wires up `.zshrc` |
| `dump.sh` | Rewrites the Brewfile from what's installed on this Mac |

## Day to day

```bash
brew install <thing>                      # install something new
./dump.sh && git commit -am "Update"      # record it
brew bundle check --file=Brewfile         # does this Mac match the Brewfile?
brew bundle cleanup --file=Brewfile       # list installed-but-untracked items (dry run)
brew bundle cleanup --file=Brewfile --force   # ...and uninstall them
```

## Not managed here

- **Python packages:** use a virtualenv and a `requirements.txt` per project instead of global `pip` installs.
- **Manual installs:** Mi Home, Samsung Smart Switch (not in Homebrew).
- **Dotfiles, SSH keys, secrets:** keep them in 1Password or a separate private repo, never here.

## Trimmed on purpose

| Removed | Why |
|---|---|
| `docker` CLI + 2 container extensions | No Docker runtime was installed, so the CLI was unusable. If needed: `brew install orbstack` or `colima` + `docker` |
| `postgresql@14` | Duplicate of `postgresql@16` |
| `git-filter-repo` | Rarely used; `brew install git-filter-repo` when needed |
| `applite` | GUI for Homebrew; the CLI does the same |
| 3 of 5 Nerd Fonts | Kept Meslo (for powerlevel10k) and JetBrains Mono |
| `logi-options+` | Overlaps with `openlogi` |
| `lookaway`, `tomatobar` | Break and pomodoro timers, not needed |
| 2 unused taps | `antoniorodr/memo` and `steipete/tap` had no formulae installed |
| 14 VS Code extensions | Duplicate icon themes, snippet packs and Live Server; Codespaces/Remote Repos; Python and GraphQL extensions that install automatically with their parent |
