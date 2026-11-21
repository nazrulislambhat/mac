# Brewfile — everything `install.sh` installs via `brew bundle`.
# Refresh from the current Mac:  ./dump.sh
# Check this Mac matches:        brew bundle check --file=Brewfile
# See untracked installs:        brew bundle cleanup --file=Brewfile

# ── Taps ──────────────────────────────────────────────
tap "simoarpe/ziggity"
tap "stripe/stripe-cli"

# ── CLI tools ─────────────────────────────────────────
brew "gh"
brew "git-lfs"
brew "mas"
brew "nvm"
brew "php"
brew "postgresql@16", restart_service: :changed
brew "powerlevel10k"
brew "python@3.11"
brew "scrcpy"
brew "simoarpe/ziggity/ziggity", trusted: true
brew "stripe/stripe-cli/stripe", trusted: true

# ── Dev apps ──────────────────────────────────────────
cask "1password-cli"
cask "android-platform-tools"
cask "antigravity"
cask "antigravity-ide"
cask "postman"
cask "visual-studio-code"
cask "warp"

# ── Everyday apps ─────────────────────────────────────
cask "1password"
cask "firefox"
cask "google-chrome"
cask "granola"
cask "notion"
cask "openlogi"
cask "slack"
cask "supernotes"
cask "telegram"
cask "todoist-app"
cask "vlc"
cask "whatsapp"

# ── Fonts ─────────────────────────────────────────────
cask "font-jetbrains-mono-nerd-font"
cask "font-meslo-lg-nerd-font"

# ── Mac App Store (sign in first) ─────────────────────
mas "Xcode", id: 497799835

# ── VS Code extensions ────────────────────────────────
vscode "aaron-bond.better-comments"
vscode "bradlc.vscode-tailwindcss"
vscode "christian-kohler.npm-intellisense"
vscode "davidanson.vscode-markdownlint"
vscode "dbaeumer.vscode-eslint"
vscode "donjayamanne.githistory"
vscode "dsznajder.es7-react-js-snippets"
vscode "esbenp.prettier-vscode"
vscode "formulahendry.auto-rename-tag"
vscode "github.vscode-github-actions"
vscode "github.vscode-pull-request-github"
vscode "graphql.vscode-graphql"
vscode "ms-python.python"
vscode "msjsdiag.vscode-react-native"
vscode "pkief.material-icon-theme"
vscode "pranaygp.vscode-css-peek"
vscode "ritwickdey.liveserver"
vscode "svelte.svelte-vscode"
vscode "vincaslt.highlight-matching-tag"
vscode "zhuangtongfa.material-theme"
