# Bash Script Template Documentation

## Overview
The Bash script template (`template.sh`) provides a robust foundation for creating shell scripts with common patterns and best practices.

## Features

### Error Handling
- `set -e`: Exits immediately if any command fails
- `set -x`: Enables debug mode when DEBUG=true
- Trap for cleanup on script exit

### Environment Variables
- Loads `.env` file if present
- Sets default variables
- Supports overriding through environment

### Text Processing
- Examples for `sed`, `grep`, and `awk`
- Common patterns for text manipulation
- File content processing

### File Operations
- File existence checks
- Directory creation
- File copying and moving
- Safe file operations

### Command Line Arguments
- Support for short and long options
- Help and version information
- Argument validation

## Usage Examples

### Basic Usage
```bash
# Make the script executable
chmod +x template.sh

# Run with debug mode
DEBUG=true ./template.sh

# Run with specific options
./template.sh -f input.txt
```

### Text Processing
```bash
# Replace text in a file
sed -i 's/old_text/new_text/g' file.txt

# Search for pattern
grep "pattern" file.txt

# Process columns
awk '{print $1, $3}' file.txt
```

### File Operations
```bash
# Check if file exists
if [ -f "file.txt" ]; then
    echo "File exists"
fi

# Create directory
mkdir -p "new_directory"
```

## Best Practices
1. Always use `set -e` for error handling
2. Use descriptive variable names
3. Add comments for complex operations
4. Implement cleanup in trap
5. Validate input and arguments
6. Use proper quoting for variables
7. Implement logging for important operations 