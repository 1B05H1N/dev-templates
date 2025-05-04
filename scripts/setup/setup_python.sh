#!/usr/bin/env bash

# Script Name: setup_python.sh
# Description: Script to set up a Python development environment
# Author: Ibrahim (https://github.com/1B05H1N)
# Date: 2025-05-04

# Create virtual environment
echo "Creating virtual environment..."
python -m venv venv

# Activate virtual environment
echo "Activating virtual environment..."
source venv/bin/activate

# Upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip

# Install development tools
echo "Installing development tools..."
pip install black flake8 mypy pytest pytest-cov

# Create requirements.txt if it doesn't exist
if [ ! -f requirements.txt ]; then
    echo "Creating requirements.txt..."
    cat > requirements.txt << EOF
# Development tools
black==23.12.1
flake8==7.0.0
mypy==1.8.0
pytest==8.0.0
pytest-cov==4.1.0

# Add your project dependencies below
EOF
fi

# Install project dependencies
echo "Installing project dependencies..."
pip install -r requirements.txt

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

echo "Setup complete! Virtual environment is activated."
echo "To deactivate the virtual environment, run: deactivate" 