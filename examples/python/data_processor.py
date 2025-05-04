#!/usr/bin/env python3

"""
Script Name: data_processor.py
Description: Example Python script demonstrating data processing
Author: Ibrahim (https://github.com/1B05H1N)
Date: 2025-05-04
"""

import argparse
import logging
import sys
from pathlib import Path
from typing import Dict, List, Optional

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class DataProcessor:
    """Process and analyze data from files."""
    
    def __init__(self, input_file: str):
        self.input_file = Path(input_file)
        if not self.input_file.exists():
            raise FileNotFoundError(f"Input file not found: {input_file}")

    def read_data(self) -> List[str]:
        """Read data from input file."""
        try:
            with open(self.input_file, 'r', encoding='utf-8') as f:
                return [line.strip() for line in f if line.strip()]
        except Exception as e:
            logger.error(f"Error reading file: {e}")
            raise

    def analyze_data(self, data: List[str]) -> Dict[str, int]:
        """Analyze data and return statistics."""
        stats = {
            'total_lines': len(data),
            'empty_lines': sum(1 for line in data if not line),
            'avg_length': sum(len(line) for line in data) / len(data) if data else 0
        }
        return stats

    def process(self) -> Dict[str, int]:
        """Process the input file and return analysis results."""
        logger.info(f"Processing file: {self.input_file}")
        data = self.read_data()
        return self.analyze_data(data)

def main() -> None:
    """Main function to parse arguments and run the processor."""
    parser = argparse.ArgumentParser(description='Process and analyze data from a file')
    parser.add_argument('input_file', help='Path to the input file')
    parser.add_argument('--debug', action='store_true', help='Enable debug logging')
    
    args = parser.parse_args()
    
    if args.debug:
        logger.setLevel(logging.DEBUG)
    
    try:
        processor = DataProcessor(args.input_file)
        results = processor.process()
        
        print("\nAnalysis Results:")
        for key, value in results.items():
            print(f"{key.replace('_', ' ').title()}: {value}")
            
    except Exception as e:
        logger.error(f"Error processing file: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main() 