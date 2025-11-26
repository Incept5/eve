#!/bin/zsh

# Script to fix better-sqlite3 bindings issue on Apple M4 Max with any recent Node.js version

# Exit on any error
set -e

# Variables
typeset -r ARCH="arm64"
typeset -r PROJECT_DIR="$PWD"
typeset -r HOMEBREW_PREFIX="/opt/homebrew"

# Detect Node.js version
typeset NODE_VERSION
NODE_VERSION=$(node -v 2>/dev/null | cut -d'v' -f2) || {
  echo "Node.js not found. Please install Node.js (e.g., via nvm) and rerun this script."
  exit 1
}

echo "Detected Node.js version: $NODE_VERSION"

echo "Starting fix for better-sqlite3 bindings issue..."

# 1. Install Xcode Command Line Tools
echo "Checking for Xcode Command Line Tools..."
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode Command Line Tools..."
  xcode-select --install
  echo "Please follow the prompts to install Xcode Command Line Tools, then rerun this script."
  exit 1
else
  echo "Xcode Command Line Tools already installed."
fi

# 2. Install Homebrew if not present
echo "Checking for Homebrew..."
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo "eval \"\$($HOMEBREW_PREFIX/bin/brew shellenv)\"" >> ~/.zshrc
  eval "$($HOMEBREW_PREFIX/bin/brew shellenv)"
else
  echo "Homebrew already installed."
fi

# 3. Install Python and SQLite
echo "Installing Python and SQLite via Homebrew..."
brew install python@3.13 sqlite

# Update PATH for SQLite and Python in current session and persist in ~/.zshrc
echo "Updating PATH for SQLite and Python..."
export PATH="$HOMEBREW_PREFIX/opt/sqlite/bin:$HOMEBREW_PREFIX/opt/python/libexec/bin:$PATH"
# Check if PATH update already exists in ~/.zshrc to avoid duplicates
if ! grep -Fx "export PATH=\"$HOMEBREW_PREFIX/opt/sqlite/bin:$HOMEBREW_PREFIX/opt/python/libexec/bin:\$PATH\"" ~/.zshrc &>/dev/null; then
  echo "export PATH=\"$HOMEBREW_PREFIX/opt/sqlite/bin:$HOMEBREW_PREFIX/opt/python/libexec/bin:\$PATH\"" >> ~/.zshrc
fi

# Verify installations
echo "Verifying Python and SQLite installations..."
python3 --version
sqlite3 --version

# 4. Install and verify node-gyp
echo "Installing node-gyp globally..."
npm install -g node-gyp
node-gyp --version

# 5. Clear npm/pnpm caches and node_modules
echo "Clearing caches and node_modules..."
if command -v pnpm &>/dev/null; then
  pnpm store prune
  rm -rf node_modules pnpm-lock.yaml
else
  npm cache clean --force
  rm -rf node_modules package-lock.json
fi

# 6. Rebuild better-sqlite3 from source
echo "Re-installing better-sqlite3 from source for Node.js $NODE_VERSION..."
if command -v pnpm &>/dev/null; then
  # Allow the build script to run (adds it to onlyBuiltDependencies)
  npm_config_build_from_source=1 \
  npm_config_arch=$ARCH \
  pnpm --allow-build=better-sqlite3 add better-sqlite3
  
  # Actually compile the native addon
  pnpm rebuild better-sqlite3
else
  # npm still understands the old flags directly
  npm install better-sqlite3 --build-from-source --arch=$ARCH
fi

# 7. Verify Node.js architecture
echo "Verifying Node.js architecture..."
typeset NODE_ARCH
NODE_ARCH=$(node -p "process.arch")
if [[ "$NODE_ARCH" != "$ARCH" ]]; then
  echo "Warning: Node.js is running under $NODE_ARCH, expected $ARCH. Consider reinstalling Node.js natively."
  echo "You can use nvm to reinstall: 'nvm install $NODE_VERSION --reinstall-packages-from=$NODE_VERSION'"
else
  echo "Node.js is running natively on $ARCH."
fi

# 8. Test better-sqlite3
echo "Testing better-sqlite3 installation..."
cat << 'EOF' > test-better-sqlite3.js
const Database = require('better-sqlite3');
const db = new Database(':memory:');
db.exec('CREATE TABLE test (id INTEGER PRIMARY KEY, value TEXT)');
db.exec("INSERT INTO test (value) VALUES ('Hello, world!')");
const result = db.prepare('SELECT * FROM test').get();
console.log('Test result:', result);
db.close();
EOF

node test-better-sqlite3.js && echo "better-sqlite3 test passed!" || {
  echo "better-sqlite3 test failed. Check the error above."
  echo "Try running with Node.js v20 LTS: 'nvm install 20 && nvm use 20 && rm -rf node_modules pnpm-lock.yaml && pnpm install'"
  echo "Or check verbose logs with: 'pnpm install better-sqlite3 --build-from-source --verbose'"
  exit 1
}

# 9. Clean up
rm -f test-better-sqlite3.js

echo "Fix completed successfully! Try running your NestJS app again."
echo "If issues persist, check verbose logs with: 'pnpm install better-sqlite3 --build-from-source --verbose' or contact the better-sqlite3 maintainers."