# Conn Castle Homebrew Tap

Official Homebrew tap for [Conn Castle](https://github.com/conn-castle) projects.

## Formulae

| Formula | Description |
|---------|-------------|
| `agent-layer` | Unified instructions, tools, and MCP servers for AI coding agents |

## Installation

```bash
brew install conn-castle/tap/agent-layer
```

Or tap first, then install:

```bash
brew tap conn-castle/tap
brew install agent-layer
```

## Agent Layer

Agent Layer keeps AI-assisted development consistent across tools by generating each client's required config from one repo-local source of truth.

**Supported clients:** Gemini CLI, Claude Code CLI, VS Code / Copilot Chat, Codex CLI, Codex VS Code extension, Antigravity

### Quick Start

```bash
# Initialize a repo
cd /path/to/repo
al init

# Run an agent
al gemini
```

For full documentation, see the [Agent Layer repository](https://github.com/conn-castle/agent-layer).

## Updating

```bash
brew upgrade conn-castle/tap/agent-layer
```

## License

See individual formula repositories for license information.
