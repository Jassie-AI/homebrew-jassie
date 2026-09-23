# Jassie Code CLI

AI-powered CLI for building, debugging, and shipping code.

## Install

### macOS (Homebrew)

```bash
brew tap jassie-ai/jassie
brew install jassie
```

### Linux (Ubuntu/Debian)

```bash
curl -fsSL https://raw.githubusercontent.com/Jassie-AI/homebrew-jassie/main/install.sh | sudo bash
```

Or download the `.deb` directly from [Releases](https://github.com/Jassie-AI/homebrew-jassie/releases):

```bash
sudo dpkg -i jassie_*.deb
sudo apt-get install -f -y
```

### Windows (Chocolatey)

Download `jassie.<version>.nupkg` from [Releases](https://github.com/Jassie-AI/homebrew-jassie/releases), then:

```powershell
choco install jassie --source .
```

## Post-install

To enable browser-based web tools, install Playwright browsers:

```bash
jassie playwright-install
```

## Links

- [jassie.ai](https://jassie.ai)
