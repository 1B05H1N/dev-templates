#!/usr/bin/env bash

# Script Name: setup_node.sh
# Description: Script to set up a Node.js development environment
# Author: Ibrahim (https://github.com/1B05H1N)
# Date: 2025-05-04

# Initialize npm project if package.json doesn't exist
if [ ! -f package.json ]; then
    echo "Initializing npm project..."
    npm init -y
fi

# Install development tools
echo "Installing development tools..."
npm install --save-dev eslint prettier jest @types/node typescript

# Create .env file if it doesn't exist
if [ ! -f .env ]; then
    echo "Creating .env file..."
    cat > .env << EOF
# Database
DB_HOST=localhost
DB_PORT=5432
DB_NAME=mydb
DB_USER=user
DB_PASSWORD=password

# API Keys
API_KEY=your_api_key
SECRET_KEY=your_secret_key

# Application Settings
DEBUG=true
LOG_LEVEL=INFO
EOF
fi

# Create TypeScript configuration if it doesn't exist
if [ ! -f tsconfig.json ]; then
    echo "Creating TypeScript configuration..."
    cat > tsconfig.json << EOF
{
  "compilerOptions": {
    "target": "ES2020",
    "module": "commonjs",
    "lib": ["ES2020"],
    "strict": true,
    "esModuleInterop": true,
    "skipLibCheck": true,
    "forceConsistentCasingInFileNames": true,
    "outDir": "./dist",
    "rootDir": "./src"
  },
  "include": ["src/**/*"],
  "exclude": ["node_modules", "**/*.test.ts"]
}
EOF
fi

# Create ESLint configuration if it doesn't exist
if [ ! -f .eslintrc.json ]; then
    echo "Creating ESLint configuration..."
    cat > .eslintrc.json << EOF
{
  "env": {
    "node": true,
    "es2020": true
  },
  "extends": [
    "eslint:recommended",
    "plugin:@typescript-eslint/recommended"
  ],
  "parser": "@typescript-eslint/parser",
  "parserOptions": {
    "ecmaVersion": 2020,
    "sourceType": "module"
  },
  "plugins": [
    "@typescript-eslint"
  ],
  "rules": {
    "indent": ["error", 2],
    "linebreak-style": ["error", "unix"],
    "quotes": ["error", "single"],
    "semi": ["error", "always"]
  }
}
EOF
fi

# Create Prettier configuration if it doesn't exist
if [ ! -f .prettierrc ]; then
    echo "Creating Prettier configuration..."
    cat > .prettierrc << EOF
{
  "semi": true,
  "trailingComma": "es5",
  "singleQuote": true,
  "printWidth": 80,
  "tabWidth": 2
}
EOF
fi

# Create basic project structure
echo "Creating project structure..."
mkdir -p src tests

# Create a basic TypeScript file
if [ ! -f src/index.ts ]; then
    echo "Creating basic TypeScript file..."
    cat > src/index.ts << EOF
/**
 * Main application entry point
 * Author: Ibrahim (https://github.com/1B05H1N)
 * Date: 2025-05-04
 */

function main(): void {
    console.log('Hello, World!');
}

main();
EOF
fi

echo "Setup complete! You can start developing in the src directory."
echo "To run the project: npm start"
echo "To run tests: npm test"
echo "To build: npm run build" 