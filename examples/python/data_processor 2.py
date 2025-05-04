#!/usr/bin/env python3

"""
Script Name: data_processor.py
Description: Processes and analyzes data from CSV files
Author: Ibrahim (https://github.com/1B05H1N)
Date: 2025-05-04
"""

import os
import sys
import logging
import argparse
import pandas as pd
from typing import List, Dict, Any
from pathlib import Path

# Configure logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s'
)
logger = logging.getLogger(__name__)

class DataProcessor:
    def __init__(self, input_file: str, output_dir: str):
        self.input_file = input_file
        self.output_dir = output_dir
        self.data = None

    def load_data(self) -> None:
        """Load data from CSV file."""
        try:
            self.data = pd.read_csv(self.input_file)
            logger.info(f"Successfully loaded data from {self.input_file}")
        except Exception as e:
            logger.error(f"Error loading data: {str(e)}")
            raise

    def process_data(self) -> Dict[str, Any]:
        """Process the loaded data and generate statistics."""
        if self.data is None:
            raise ValueError("No data loaded. Call load_data() first.")

        stats = {
            "row_count": len(self.data),
            "column_count": len(self.data.columns),
            "missing_values": self.data.isnull().sum().to_dict(),
            "numeric_stats": self.data.describe().to_dict()
        }

        logger.info("Data processing completed")
        return stats

    def save_results(self, stats: Dict[str, Any]) -> None:
        """Save processing results to output directory."""
        os.makedirs(self.output_dir, exist_ok=True)
        
        # Save statistics to JSON
        stats_file = os.path.join(self.output_dir, "statistics.json")
        pd.DataFrame(stats).to_json(stats_file)
        logger.info(f"Statistics saved to {stats_file}")

        # Save processed data to CSV
        output_file = os.path.join(self.output_dir, "processed_data.csv")
        self.data.to_csv(output_file, index=False)
        logger.info(f"Processed data saved to {output_file}")

def main() -> None:
    parser = argparse.ArgumentParser(description="Process and analyze CSV data")
    parser.add_argument("input_file", help="Path to input CSV file")
    parser.add_argument("--output-dir", default="./output", help="Output directory for results")
    
    args = parser.parse_args()

    try:
        processor = DataProcessor(args.input_file, args.output_dir)
        processor.load_data()
        stats = processor.process_data()
        processor.save_results(stats)
        logger.info("Data processing completed successfully")
    except Exception as e:
        logger.error(f"Error in data processing: {str(e)}")
        sys.exit(1)

if __name__ == "__main__":
    main() 