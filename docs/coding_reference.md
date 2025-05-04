# Coding Reference Guide

## Table of Contents
- [Template Scripts](#template-scripts)
- [Cross-Language Topics](#cross-language-topics)
- [Bash Scripting](#bash-scripting)
- [Python](#python)
- [JavaScript](#javascript)

## Template Scripts

### Bash Script Template
```bash
#!/usr/bin/env bash

# Script Name: script_name.sh
# Description: Brief description of what the script does
# Author: Your Name
# Date: $(date +%Y-%m-%d)

# Exit on error
set -e

# Enable debug mode if DEBUG is set
if [ "$DEBUG" = "true" ]; then
    set -x
fi

# Load environment variables
if [ -f .env ]; then
    source .env
fi

# Default variables
DEFAULT_VAR="default_value"

# Function to display usage
usage() {
    echo "Usage: $0 [options]"
    echo "Options:"
    echo "  -h, --help     Display this help message"
    echo "  -v, --version  Display version information"
    echo "  -f, --file     Specify input file"
    exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        -h|--help)
            usage
            ;;
        -v|--version)
            echo "Version 1.0.0"
            exit 0
            ;;
        -f|--file)
            FILE="$2"
            shift
            ;;
        *)
            echo "Unknown option: $1"
            usage
            ;;
    esac
    shift
done

# Main function
main() {
    echo "Starting script execution..."
    
    # Your code here
    
    echo "Script completed successfully"
}

# Cleanup function
cleanup() {
    echo "Cleaning up..."
    # Add cleanup code here
}

# Set up trap for cleanup
trap cleanup EXIT INT TERM

# Execute main function
main "$@"
```

### Python Script Template
```python
#!/usr/bin/env python3

"""
Script Name: script_name.py
Description: Brief description of what the script does
Author: Your Name
Date: YYYY-MM-DD
"""

import os
import sys
import logging
import argparse
from typing import Optional
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class ScriptError(Exception):
    """Custom exception for script errors."""
    pass

def parse_args() -> argparse.Namespace:
    """Parse command line arguments."""
    parser = argparse.ArgumentParser(description='Script description')
    parser.add_argument('-f', '--file', help='Input file')
    parser.add_argument('-v', '--verbose', action='store_true', help='Enable verbose output')
    return parser.parse_args()

def main() -> None:
    """Main function."""
    try:
        args = parse_args()
        
        # Your code here
        
        logger.info("Script completed successfully")
    except ScriptError as e:
        logger.error(f"Script error: {e}")
        sys.exit(1)
    except Exception as e:
        logger.error(f"Unexpected error: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
```

### JavaScript/Node.js Script Template
```javascript
#!/usr/bin/env node

/**
 * Script Name: script_name.js
 * Description: Brief description of what the script does
 * Author: Your Name
 * Date: YYYY-MM-DD
 */

const fs = require('fs');
const path = require('path');
require('dotenv').config();

// Configure logging
const log = console.log;
const error = console.error;

class ScriptError extends Error {
    constructor(message) {
        super(message);
        this.name = 'ScriptError';
    }
}

async function main() {
    try {
        // Your code here
        
        log('Script completed successfully');
    } catch (err) {
        error(`Error: ${err.message}`);
        process.exit(1);
    }
}

main();
```

## Environment Setup

### Python Virtual Environment
```bash
# Create virtual environment
python -m venv venv

# Activate virtual environment
# On Unix/macOS
source venv/bin/activate

# On Windows
.\venv\Scripts\activate

# Install packages
pip install -r requirements.txt

# Deactivate virtual environment
deactivate
```

### Environment Variables (.env)
```bash
# .env file template
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
```

### Cron Jobs
```bash
# Edit crontab
crontab -e

# Common cron patterns
# Run every minute
* * * * * /path/to/script.sh

# Run every hour at minute 0
0 * * * * /path/to/script.sh

# Run every day at 2:30 AM
30 2 * * * /path/to/script.sh

# Run every Monday at 3:00 AM
0 3 * * 1 /path/to/script.sh

# Run on the 1st of every month at midnight
0 0 1 * * /path/to/script.sh

# Run every 15 minutes
*/15 * * * * /path/to/script.sh
```

### Git Setup
```bash
# Initialize a new repository
git init

# Configure git
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

# Create .gitignore
cat > .gitignore << EOF
# Python
__pycache__/
*.py[cod]
*$py.class
venv/
.env

# Node.js
node_modules/
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# IDE
.idea/
.vscode/
*.swp
*.swo

# OS
.DS_Store
Thumbs.db
EOF
```

### Project Structure Templates

#### Python Project
```
project_name/
├── .env
├── .gitignore
├── README.md
├── requirements.txt
├── setup.py
├── src/
│   ├── __init__.py
│   ├── main.py
│   └── utils/
│       ├── __init__.py
│       └── helpers.py
├── tests/
│   ├── __init__.py
│   └── test_main.py
└── docs/
    └── README.md
```

#### Node.js Project
```
project_name/
├── .env
├── .gitignore
├── README.md
├── package.json
├── src/
│   ├── index.js
│   └── utils/
│       └── helpers.js
├── tests/
│   └── test.js
└── docs/
    └── README.md
```

### Common Development Tools

#### Python Development
```bash
# Install development tools
pip install black flake8 mypy pytest

# Format code
black .

# Lint code
flake8 .

# Type checking
mypy .

# Run tests
pytest
```

#### JavaScript Development
```bash
# Install development tools
npm install --save-dev eslint prettier jest

# Format code
npx prettier --write .

# Lint code
npx eslint .

# Run tests
npx jest
```

## Cross-Language Topics

### Version Control (Git)
```bash
# Clone a repository
git clone <repository-url>

# Create and switch to a new branch
git checkout -b feature/new-feature

# Stage changes
git add .

# Commit changes
git commit -m "Description of changes"

# Push changes
git push origin feature/new-feature

# Pull latest changes
git pull origin main

# Merge branches
git merge feature/new-feature

# Rebase current branch
git rebase main
```

### Package Managers
```bash
# Python (pip)
pip install package-name
pip install -r requirements.txt
python -m venv venv
source venv/bin/activate  # On Unix/macOS
.\venv\Scripts\activate   # On Windows

# JavaScript (npm)
npm install package-name
npm install --save-dev package-name  # For dev dependencies
npx create-react-app my-app

# Homebrew (macOS)
brew install package-name
```

### Testing Basics
```python
# Python (pytest)
def test_addition():
    assert 1 + 1 == 2

# JavaScript (Jest)
test('addition', () => {
    expect(1 + 1).toBe(2);
});

# Bash (bats)
@test "addition" {
    result=$((1 + 1))
    [ "$result" -eq 2 ]
}
```

### Debugging Tools
```bash
# Bash
set -x  # Enable debug mode
trap 'echo "Error on line $LINENO"' ERR

# Python
import pdb
pdb.set_trace()  # Set breakpoint

# JavaScript
console.log('Debug:', variable);
debugger;  # Set breakpoint
```

### Linting & Formatting
```bash
# Bash
shellcheck script.sh

# Python
flake8 script.py
black script.py

# JavaScript
eslint script.js
prettier --write script.js
```

### Environment Variables
```bash
# Bash
export VAR_NAME="value"
echo $VAR_NAME

# Python
import os
os.environ['VAR_NAME'] = 'value'
print(os.environ['VAR_NAME'])

# JavaScript
process.env.VAR_NAME = 'value';
console.log(process.env.VAR_NAME);
```

### Exit Codes & Error Handling
```bash
# Bash
set -e  # Exit on error
command || { echo "Error"; exit 1; }

# Python
import sys
sys.exit(1)  # Exit with error code

# JavaScript
process.exit(1);  # Exit with error code
```

## Bash Scripting

### Arrays & Associative Arrays
```bash
# Regular arrays
arr=(a b c)
echo "${arr[1]}"  # b
echo "${arr[@]}"  # all elements

# Associative arrays
declare -A map=([key1]=value1 [key2]=value2)
echo "${map[key1]}"  # value1
```

### Arithmetic Operations
```bash
# Using let
let "a = 5 + 3"
echo $a  # 8

# Using double parentheses
((counter++))
echo $((a + b))

# Using expr
result=$(expr 5 + 3)
```

### Case & Select Statements
```bash
# Case statement
case $option in
    "start")
        echo "Starting..."
        ;;
    "stop")
        echo "Stopping..."
        ;;
    *)
        echo "Invalid option"
        ;;
esac

# Select statement
select option in "Option 1" "Option 2" "Quit"; do
    case $option in
        "Option 1") echo "You chose 1";;
        "Option 2") echo "You chose 2";;
        "Quit") break;;
    esac
done
```

### Command Line Arguments with getopts
```bash
while getopts ":f:l:" opt; do
    case $opt in
        f) file="$OPTARG";;
        l) level="$OPTARG";;
        \?) echo "Invalid option: -$OPTARG" >&2;;
    esac
done
```

### I/O Redirection & Pipelines
```bash
# Redirect output
command > output.txt
command >> output.txt  # Append

# Redirect error
command 2> error.txt

# Redirect both
command > output.txt 2>&1

# Here-document
cat << EOF
This is a
multi-line
text
EOF

# Process substitution
diff <(command1) <(command2)
```

### Signals & Traps
```bash
trap 'cleanup' EXIT INT TERM

cleanup() {
    echo "Cleaning up..."
    rm -f temp_file
}
```

## Python

### Exception Handling
```python
try:
    result = 10 / 0
except ZeroDivisionError as e:
    print(f"Error: {e}")
except Exception as e:
    print(f"Unexpected error: {e}")
finally:
    print("Cleanup code")
```

### Modules & Packages
```python
# Importing modules
import math
from math import sqrt
import numpy as np

# Creating a package
# mypackage/
#     __init__.py
#     module1.py
#     module2.py

# Relative imports
from . import module1
from .. import parent_module
```

### Classes & OOP
```python
class Person:
    def __init__(self, name, age):
        self.name = name
        self.age = age
    
    def greet(self):
        return f"Hello, I'm {self.name}"

class Employee(Person):
    def __init__(self, name, age, position):
        super().__init__(name, age)
        self.position = position
```

### Decorators
```python
def timer(func):
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"Time taken: {end - start}")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
```

### Context Managers
```python
# Using context manager
with open('file.txt', 'r') as f:
    content = f.read()

# Creating custom context manager
class MyContext:
    def __enter__(self):
        print("Entering context")
        return self
    
    def __exit__(self, exc_type, exc_val, exc_tb):
        print("Exiting context")
```

### Generators
```python
def fibonacci(n):
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b

# Using generator
for num in fibonacci(5):
    print(num)
```

### Type Hints
```python
from typing import List, Dict, Optional

def greet(name: str) -> str:
    return f"Hello, {name}"

def process_data(data: List[int]) -> Dict[str, int]:
    return {"sum": sum(data)}
```

### Async IO
```python
import asyncio

async def fetch_data():
    await asyncio.sleep(1)
    return "Data"

async def main():
    result = await fetch_data()
    print(result)

asyncio.run(main())
```

## JavaScript

### Modules
```javascript
// Exporting
export const name = "John";
export function greet() { return "Hello"; }
export default class Person {}

// Importing
import { name, greet } from './module.js';
import Person from './person.js';
```

### Promises & Async/Await
```javascript
// Promises
const promise = new Promise((resolve, reject) => {
    setTimeout(() => resolve("Done"), 1000);
});

promise
    .then(result => console.log(result))
    .catch(error => console.error(error));

// Async/Await
async function fetchData() {
    try {
        const response = await fetch('url');
        const data = await response.json();
        return data;
    } catch (error) {
        console.error(error);
    }
}
```

### Classes & Prototypes
```javascript
class Person {
    constructor(name) {
        this.name = name;
    }
    
    greet() {
        return `Hello, ${this.name}`;
    }
}

class Employee extends Person {
    constructor(name, position) {
        super(name);
        this.position = position;
    }
}
```

### Modern JavaScript Features
```javascript
// Destructuring
const { name, age } = person;
const [first, ...rest] = array;

// Spread operator
const newArray = [...array1, ...array2];
const newObj = { ...obj1, ...obj2 };

// Template literals
const message = `Hello, ${name}!`;

// Map & Set
const map = new Map();
map.set('key', 'value');

const set = new Set([1, 2, 3]);
```

### Node.js Specific
```javascript
// File system
const fs = require('fs');
fs.readFile('file.txt', 'utf8', (err, data) => {
    if (err) throw err;
    console.log(data);
});

// Environment variables
require('dotenv').config();
console.log(process.env.API_KEY);
```

### TypeScript Basics
```typescript
// Type annotations
let name: string = "John";
let age: number = 25;

// Interfaces
interface Person {
    name: string;
    age: number;
    greet(): string;
}

// Classes with types
class Employee implements Person {
    constructor(public name: string, public age: number) {}
    
    greet(): string {
        return `Hello, ${this.name}`;
    }
}
```

## License & Contribution
This reference guide is open for contributions. Please submit a pull request for any improvements or additions you'd like to make. 