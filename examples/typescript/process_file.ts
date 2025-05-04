/**
 * Script Name: process_file.ts
 * Description: Example script using the TypeScript template
 * Author: Ibrahim (https://github.com/1B05H1N)
 * Date: 2025-05-04
 */

import { promises as fs } from 'fs';
import path from 'path';

// Type definitions
interface FileStats {
    size: number;
    lines: number;
    words: number;
}

// Main function
async function processFile(filePath: string): Promise<FileStats> {
    try {
        // Read file content
        const content = await fs.readFile(filePath, 'utf-8');
        
        // Calculate statistics
        const lines = content.split('\n').length;
        const words = content.split(/\s+/).filter(word => word.length > 0).length;
        const size = Buffer.byteLength(content);
        
        return {
            size,
            lines,
            words
        };
    } catch (error) {
        throw new Error(`Failed to process file: ${error instanceof Error ? error.message : 'Unknown error'}`);
    }
}

// Command line interface
async function main() {
    try {
        // Get file path from command line arguments
        const filePath = process.argv[2];
        if (!filePath) {
            throw new Error('Please provide a file path as an argument');
        }

        // Process file
        const stats = await processFile(filePath);
        
        // Display results
        console.log('File Statistics:');
        console.log(`Size: ${stats.size} bytes`);
        console.log(`Lines: ${stats.lines}`);
        console.log(`Words: ${stats.words}`);
        
    } catch (error) {
        console.error('Error:', error instanceof Error ? error.message : 'Unknown error');
        process.exit(1);
    }
}

// Run the script
main(); 