# Bash Scripting Best Practices

## 1. Script Structure

### Header
- Always include a shebang (`#!/usr/bin/env bash`)
- Add script metadata (name, description, author, date)
- Include a brief description of the script's purpose

### Error Handling
- Use `set -e` to exit on error
- Use `set -u` to treat unset variables as errors
- Use `set -o pipefail` to catch pipeline errors
- Implement proper error messages and exit codes

### Functions
- Keep functions small and focused
- Use descriptive function names
- Document function parameters and return values
- Use local variables within functions

## 2. Variable Usage

### Naming
- Use uppercase for environment variables
- Use lowercase for local variables
- Use descriptive names
- Avoid single-letter variables

### Declaration
- Always quote variables
- Use `${VAR}` instead of `$VAR`
- Initialize variables with default values
- Use readonly for constants

## 3. Command Substitution

### Best Practices
- Use `$(command)` instead of backticks
- Quote command substitutions
- Handle command output carefully

### Examples
```bash
# Good
files=$(find . -type f)

# Bad
files=`find . -type f`
```

## 4. File Operations

### Safety
- Check if files exist before operations
- Use `-f` for files, `-d` for directories
- Handle file permissions properly
- Use temporary files safely

### Examples
```bash
# Check file existence
if [ -f "$file" ]; then
    # Process file
fi

# Create temporary file
temp_file=$(mktemp)
trap 'rm -f "$temp_file"' EXIT
```

## 5. Text Processing

### Tools
- Use `grep` for pattern matching
- Use `sed` for text substitution
- Use `awk` for field processing
- Use `cut` for column extraction

### Examples
```bash
# Extract specific columns
cut -d',' -f1,3 file.csv

# Replace text
sed 's/old/new/g' file.txt

# Process fields
awk -F',' '{print $1, $3}' file.csv
```

## 6. Command Line Arguments

### Parsing
- Use `getopts` for short options
- Use `getopt` for long options
- Document all options
- Provide help messages

### Examples
```bash
while getopts ":f:o:" opt; do
    case $opt in
        f) file="$OPTARG" ;;
        o) output="$OPTARG" ;;
        \?) echo "Invalid option: -$OPTARG" >&2 ;;
    esac
done
```

## 7. Logging

### Implementation
- Use different log levels
- Include timestamps
- Log to both file and console
- Use proper log rotation

### Examples
```bash
log() {
    local level=$1
    local message=$2
    echo "$(date '+%Y-%m-%d %H:%M:%S') [$level] $message" | tee -a "$log_file"
}
```

## 8. Security

### Best Practices
- Validate user input
- Sanitize file paths
- Use proper permissions
- Avoid command injection

### Examples
```bash
# Sanitize input
input=$(echo "$1" | tr -cd '[:alnum:]')

# Check permissions
if [ ! -w "$file" ]; then
    echo "Error: No write permission"
    exit 1
fi
```

## 9. Performance

### Optimization
- Minimize subshell usage
- Use built-in commands
- Avoid unnecessary loops
- Use efficient text processing

### Examples
```bash
# Use built-in string operations
${var#prefix}  # Remove prefix
${var%suffix}  # Remove suffix
```

## 10. Testing

### Implementation
- Write test cases
- Use shellcheck
- Test edge cases
- Document test results

### Examples
```bash
# Test function
test_function() {
    local input=$1
    local expected=$2
    local result=$(process "$input")
    
    if [ "$result" = "$expected" ]; then
        echo "PASS"
    else
        echo "FAIL"
    fi
}
``` 