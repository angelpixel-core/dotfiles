#!/usr/bin/env zsh

set -e

echo "🔷 Setting up Solidity toolchain with ASDF..."

# ----------------------------
# Solidity (solc)
# ----------------------------
if ! asdf plugin list | grep -q solidity; then
  echo "➕ Adding ASDF plugin: solidity"
  asdf plugin add solidity
fi

echo "📦 Installing Solidity (solc)..."
asdf install solidity ${VERSION}
asdf global solidity ${VERSION}

# ----------------------------
# Foundry (forge, cast, anvil)
# ----------------------------
if ! asdf plugin list | grep -q foundry; then
  echo "➕ Adding ASDF plugin: foundry"
  asdf plugin add foundry
fi

echo "📦 Installing Foundry..."
asdf install foundry latest
asdf global foundry latest

echo "✅ Solidity + Foundry setup complete."
echo "Run 'solc --version' and 'forge --version' to verify."
