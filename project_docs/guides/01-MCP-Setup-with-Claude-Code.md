# Complete Guide to Setting Up MCPs with Claude Code

## Understanding MCPs and Prerequisites

**Model Context Protocol (MCP)** is an open standard that connects AI applications like Claude Code to external data sources and tools. Think of it as "USB-C for AI" - a universal way to extend Claude's capabilities with specialized servers.

### System Prerequisites
Before installing any MCPs, ensure you have:
- **Claude Code**: Latest version installed with valid Anthropic API key
- **Node.js 18+**: Required for most MCPs (verify with `node --version`)
- **NPM**: Comes with Node.js (verify with `npm --version`)
- **Operating System**: Windows, macOS, or Linux

Set your Anthropic API key:
```bash
export ANTHROPIC_API_KEY="your-api-key-here"
```

## 1. Official MCP Setup Process

### Configuration Methods

**Method 1: CLI Wizard (Recommended)**
```bash
# Add MCP server interactively
claude mcp add [server-name]

# Add with specific scope
claude mcp add server-name -s local|project|user

# Add with environment variables
claude mcp add server-name -e KEY=value
```

**Method 2: Direct Configuration**
Edit `~/.claude.json`:
```json
{
  "mcpServers": {
    "server-name": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-package"],
      "env": {
        "API_KEY": "your-key-here"
      }
    }
  }
}
```

### Managing MCPs
```bash
# Check MCP server status
/mcp

# List configured servers
claude mcp list

# Import from Claude Desktop
claude mcp import-from-desktop
```

## 2. Sequential-Thinking MCP Setup

The Sequential-Thinking MCP helps break down complex problems into manageable steps with dynamic revision capabilities.

### Installation
```bash
claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
```

### Configuration for Claude Code
Add to your configuration:
```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    }
  }
}
```

### Disable Logging (Optional)
```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"],
      "env": {
        "DISABLE_THOUGHT_LOGGING": "true"
      }
    }
  }
}
```

### Verification
1. Restart Claude Code
2. Check available tools with `/mcp`
3. Test with: "Help me think through solving a complex programming problem using sequential thinking"

## 3. Playwright-MCP Setup

Playwright-MCP enables browser automation within Claude Code, perfect for web testing and scraping.

### Prerequisites
- Node.js 18 or newer
- Browsers are automatically managed by Playwright

### Installation
```bash
claude mcp add playwright npx @playwright/mcp@latest
```

### Basic Configuration
```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

### Advanced Configuration with Options
Create `playwright-config.json`:
```json
{
  "browser": {
    "browserName": "chromium",
    "launchOptions": {
      "headless": false,
      "channel": "chrome"
    },
    "contextOptions": {
      "viewport": { "width": 1280, "height": 720 }
    }
  },
  "capabilities": ["tabs", "pdf", "files", "install"],
  "outputDir": "./playwright-outputs"
}
```

Then reference it:
```json
{
  "mcpServers": {
    "playwright": {
      "command": "npx",
      "args": [
        "@playwright/mcp@latest",
        "--config", "playwright-config.json"
      ]
    }
  }
}
```

### Browser Installation
If browsers aren't automatically installed:
```bash
npx playwright install
```

### Verification
Test with: "Use playwright mcp to open a browser to example.com"

### Troubleshooting Windows Issues
If you encounter path issues on Windows:
```json
{
  "mcpServers": {
    "playwright": {
      "command": "C:\\Program Files\\nodejs\\npx.cmd",
      "args": ["@playwright/mcp@latest"]
    }
  }
}
```

## 4. Magic-MCP Setup

Magic-MCP generates beautiful UI components through natural language descriptions.

### Get API Key
1. Visit [21st.dev Magic Console](https://21st.dev/magic/console)
2. Create an account
3. Generate and save your API key

### Installation
```bash
# One-command installation
npx @21st-dev/cli@latest install claude --api-key your-api-key
```

### Manual Configuration
```json
{
  "mcpServers": {
    "@21st-dev/magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "your-api-key"
      }
    }
  }
}
```

### Usage Limits
- **Free Tier**: 5 tokens for component generation
- **Pro Plan**: $16/month for 50 tokens
- **Pro Plus**: $32/month for 200 tokens

### Verification
1. Restart Claude Code
2. Type `/ui create a modern navigation bar`
3. Check that Magic generates component variations

### Common Issues
If you encounter connection problems, try:
```bash
# Fresh Node.js installation with NVM
nvm install node && nvm use node

# Clear NPM cache
npm cache clean --force
```

## 5. Context7 Setup

Context7 provides real-time, version-specific documentation for libraries and frameworks.

### Installation (No API Key Required!)
```bash
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest
```

### Configuration
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

### Adjust Token Limits (Optional)
```json
{
  "mcpServers": {
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"],
      "env": {
        "DEFAULT_MINIMUM_TOKENS": "15000"
      }
    }
  }
}
```

### Alternative Runtime (Bun)
If you encounter issues with npx:
```json
{
  "mcpServers": {
    "context7": {
      "command": "bunx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

### Verification
Test with: "Show me how to create a Next.js API route with TypeScript. use context7"

## Complete Configuration Example

Here's a complete `~/.claude.json` with all five MCPs configured:

```json
{
  "mcpServers": {
    "sequential-thinking": {
      "command": "npx",
      "args": ["-y", "@modelcontextprotocol/server-sequential-thinking"]
    },
    "playwright": {
      "command": "npx",
      "args": ["@playwright/mcp@latest"]
    },
    "@21st-dev/magic": {
      "command": "npx",
      "args": ["-y", "@21st-dev/magic@latest"],
      "env": {
        "API_KEY": "your-magic-api-key"
      }
    },
    "context7": {
      "command": "npx",
      "args": ["-y", "@upstash/context7-mcp@latest"]
    }
  }
}
```

## Verification and Testing

### Check All MCPs
```bash
# List all configured MCPs
claude mcp list

# Check status in Claude Code
/mcp
```

### Test Each MCP
1. **Sequential-Thinking**: "Help me solve this algorithm problem step by step using sequential thinking"
2. **Playwright**: "Use playwright to navigate to google.com and search for 'MCP'"
3. **Magic**: "/ui create a modern login form with validation"
4. **Context7**: "Show me React hooks examples. use context7"

## Common Troubleshooting

### General MCP Issues

**Connection Problems**
1. Restart Claude Code after configuration changes
2. Validate JSON syntax in configuration files
3. Check Node.js is in system PATH
4. Clear NPM cache: `npm cache clean --force`

**Permission Issues**
- Windows: Run as administrator if needed
- macOS/Linux: Check file permissions on config files
- Use `sudo` cautiously for npm installations

**Version Conflicts**
```bash
# Update npm
npm install -g npm@latest

# Use exact versions if latest fails
"@modelcontextprotocol/server-sequential-thinking@2025.7.1"
```

### Platform-Specific Issues

**Windows**
- Use full paths for commands: `C:\\Program Files\\nodejs\\npx.cmd`
- Check Windows Defender/firewall settings
- Use PowerShell or WSL for better compatibility

**macOS**
- Grant terminal/IDE full disk access in System Preferences
- Check Gatekeeper settings for unsigned binaries

### MCP-Specific Issues

**Sequential-Thinking**: If tool doesn't appear, check JSON syntax
**Playwright**: Run `npx playwright install` if browsers missing
**Magic**: Verify API key is correctly formatted with quotes
**Context7**: Try `bunx` instead of `npx` for module errors

## Best Practices

### Security
- Store API keys in environment variables when possible
- Regularly rotate API keys for services like Magic
- Use project-specific configurations for sensitive projects
- Review MCP permissions and capabilities

### Performance
- Enable only needed capabilities (e.g., Playwright's `--caps`)
- Monitor resource usage for browser automation
- Set appropriate timeouts for long-running operations
- Use headless mode for Playwright in production

### Maintenance
- Keep MCPs updated: add `@latest` to package names
- Regularly check for security updates
- Document custom configurations
- Back up configuration files

## Quick Reference Commands

```bash
# Add MCPs
claude mcp add sequential-thinking -- npx -y @modelcontextprotocol/server-sequential-thinking
claude mcp add playwright npx @playwright/mcp@latest
claude mcp add magic -- npx -y @21st-dev/magic@latest
claude mcp add context7 -- npx -y @upstash/context7-mcp@latest

# Check status
claude mcp list
/mcp

# Remove an MCP
claude mcp remove [server-name]

# Reset configurations
claude mcp reset-project-choices
```

With these MCPs installed, Claude Code gains powerful new capabilities for structured thinking, browser automation, UI generation, and real-time documentation access. Each MCP extends Claude's abilities in unique ways, creating a comprehensive development environment.
