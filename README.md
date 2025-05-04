# Dev Templates

A comprehensive collection of development templates, examples, and best practices for Bash, Python, and JavaScript/TypeScript.

## Project Structure

```
.
├── docs/                    # Documentation files
│   ├── bash/               # Bash documentation
│   ├── python/             # Python documentation
│   ├── javascript/         # JavaScript documentation
│   └── coding_reference.md # Comprehensive coding reference guide
├── templates/              # Template files
│   ├── bash/              # Bash templates
│   ├── python/            # Python templates
│   └── javascript/        # JavaScript templates
├── examples/              # Example implementations
│   ├── bash/             # Bash examples
│   ├── python/           # Python examples
│   └── typescript/       # TypeScript examples
├── config/               # Configuration files
│   └── env.example      # Environment variables template
├── scripts/             # Utility scripts
│   └── setup/          # Setup scripts
└── README.md           # This file
```

## Quick Start

1. Clone the repository:
   ```bash
   git clone https://github.com/1B05H1N/dev-templates.git
   cd dev-templates
   ```

2. Choose your language:
   - [Bash Documentation](docs/bash/README.md)
   - [Python Documentation](docs/python/README.md)
   - [JavaScript Documentation](docs/javascript/README.md)

3. Copy the appropriate template:
   - Bash: `templates/bash/template.sh`
   - Python: `templates/python/template.py`
   - JavaScript: `templates/javascript/src/index.js`

4. Copy and edit the environment configuration:
   ```bash
   cp config/env.example .env
   # Edit .env with your settings
   ```

5. Run the setup script for your language:
   ```bash
   # For Python
   ./scripts/setup/setup_python.sh

   # For Node.js
   ./scripts/setup/setup_node.sh
   ```

## Documentation

- [Comprehensive Coding Reference Guide](docs/coding_reference.md) - Detailed guide with code examples and best practices
- [Bash Documentation](docs/bash/README.md) - Bash scripting guide
- [Python Documentation](docs/python/README.md) - Python development guide
- [JavaScript Documentation](docs/javascript/README.md) - JavaScript/TypeScript guide

## Environment Configuration

The `config/env.example` file provides a template for setting up your environment variables. To use it:

1. Copy the example file:
   ```bash
   cp config/env.example .env
   ```

2. Edit the `.env` file with your specific settings:
   ```bash
   # API Configuration
   API_URL=http://api.example.com
   API_KEY=your_api_key_here
   
   # Database Configuration
   DB_HOST=localhost
   DB_PORT=5432
   DB_NAME=your_database
   DB_USER=your_username
   DB_PASSWORD=your_password
   
   # Application Settings
   DEBUG=true
   LOG_LEVEL=INFO
   ```

3. Add `.env` to your `.gitignore` file to keep sensitive information secure:
   ```bash
   echo ".env" >> .gitignore
   ```

## Features

### Bash Template
- Error handling with `set -e`
- Command line argument parsing
- Environment variable management
- Logging and debugging support
- Example: [File Backup Script](examples/bash/file_backup.sh)

### Python Template
- Type hints and documentation
- Logging configuration
- Command line interface with argparse
- Error handling and custom exceptions
- Example: [Data Processor](examples/python/data_processor.py)

### JavaScript/TypeScript Template
- Modern ES6+ features
- Async/await support
- Environment configuration
- Logging with Winston
- Example: [File Processor](examples/typescript/process_file.ts)

## Examples

Each language directory contains practical examples:

- **Bash**: `examples/bash/file_backup.sh` - Automated file backup script
- **Python**: `examples/python/data_processor.py` - Data processing with error handling
- **TypeScript**: `examples/typescript/process_file.ts` - File processing with async operations

## Setup Scripts

The `scripts/setup` directory contains scripts to help set up your development environment:

- `setup_python.sh`: Sets up Python virtual environment and installs dependencies
- `setup_node.sh`: Sets up Node.js project and installs dependencies

## Contributing

Feel free to contribute to this project by:
1. Adding new templates
2. Improving documentation
3. Adding more examples
4. Fixing issues

## Author

[1B05H1N](https://github.com/1B05H1N) 