# Python Scripting Best Practices

## 1. Code Structure

### Imports
- Group imports in this order:
  1. Standard library imports
  2. Third-party imports
  3. Local application imports
- Use absolute imports
- Avoid wildcard imports
- Use `from __future__ import` at the top

### Example
```python
from __future__ import annotations

import os
import sys
from typing import List, Dict

import pandas as pd
import requests

from .utils import logger
```

## 2. Error Handling

### Try-Except Blocks
- Be specific with exception types
- Log exceptions properly
- Clean up resources in finally blocks
- Use custom exceptions for business logic

### Example
```python
try:
    result = process_data()
except FileNotFoundError as e:
    logger.error(f"File not found: {e}")
    raise
except ValueError as e:
    logger.error(f"Invalid data: {e}")
    raise
finally:
    cleanup_resources()
```

## 3. Type Hints

### Usage
- Use type hints for function parameters and return values
- Use `Optional` for nullable types
- Use `Union` for multiple possible types
- Use `Any` sparingly

### Example
```python
from typing import Optional, Union, List

def process_data(
    data: List[Dict[str, Union[str, int]]],
    threshold: Optional[float] = None
) -> Dict[str, float]:
    # Function implementation
    pass
```

## 4. Logging

### Configuration
- Use the built-in logging module
- Configure logging at the module level
- Use appropriate log levels
- Include context in log messages

### Example
```python
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

formatter = logging.Formatter(
    '%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)

handler = logging.StreamHandler()
handler.setFormatter(formatter)
logger.addHandler(handler)
```

## 5. Documentation

### Docstrings
- Follow Google style docstrings
- Document all public functions and classes
- Include type information
- Provide usage examples

### Example
```python
def process_data(data: List[Dict[str, Any]]) -> Dict[str, float]:
    """Process the input data and return statistics.

    Args:
        data: List of dictionaries containing the input data.

    Returns:
        Dictionary containing processed statistics.

    Raises:
        ValueError: If the input data is empty or invalid.

    Example:
        >>> data = [{"value": 1}, {"value": 2}]
        >>> process_data(data)
        {"mean": 1.5, "max": 2}
    """
    pass
```

## 6. Testing

### Unit Tests
- Use pytest or unittest
- Follow AAA pattern (Arrange, Act, Assert)
- Use fixtures for setup
- Mock external dependencies

### Example
```python
import pytest
from unittest.mock import patch

def test_process_data():
    # Arrange
    input_data = [{"value": 1}, {"value": 2}]
    
    # Act
    result = process_data(input_data)
    
    # Assert
    assert result["mean"] == 1.5
    assert result["max"] == 2
```

## 7. Performance

### Optimization
- Use list comprehensions
- Avoid unnecessary object creation
- Use generators for large datasets
- Profile code before optimizing

### Example
```python
# Good
squares = [x**2 for x in range(10)]

# Better for large datasets
squares = (x**2 for x in range(1000000))
```

## 8. Security

### Best Practices
- Validate input data
- Use parameterized queries
- Sanitize file paths
- Handle sensitive data properly

### Example
```python
import os
from pathlib import Path

def safe_file_path(user_input: str) -> Path:
    base_path = Path("/safe/directory")
    return base_path / os.path.basename(user_input)
```

## 9. Configuration

### Management
- Use environment variables
- Implement configuration classes
- Validate configuration values
- Provide default values

### Example
```python
from dataclasses import dataclass
from typing import Optional

@dataclass
class Config:
    api_key: str
    timeout: int = 30
    retries: Optional[int] = None

    @classmethod
    def from_env(cls) -> "Config":
        return cls(
            api_key=os.getenv("API_KEY"),
            timeout=int(os.getenv("TIMEOUT", "30")),
            retries=int(os.getenv("RETRIES")) if os.getenv("RETRIES") else None
        )
```

## 10. Code Style

### Guidelines
- Follow PEP 8
- Use meaningful variable names
- Keep functions small and focused
- Use consistent formatting

### Tools
- Use black for formatting
- Use isort for import sorting
- Use flake8 for linting
- Use mypy for type checking

### Example
```python
# Good
def calculate_average(numbers: List[float]) -> float:
    return sum(numbers) / len(numbers)

# Bad
def avg(n): return sum(n)/len(n)
``` 