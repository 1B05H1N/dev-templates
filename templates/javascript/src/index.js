#!/usr/bin/env node

/**
 * Script Name: index.js
 * Description: JavaScript script template with error handling and logging
 * Author: Ibrahim (https://github.com/1B05H1N)
 * Date: 2025-05-04
 */

import dotenv from 'dotenv';
import winston from 'winston';
import { Command } from 'commander';

// Load environment variables
dotenv.config();

// Configure logger
const logger = winston.createLogger({
    level: process.env.LOG_LEVEL || 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: 'error.log', level: 'error' }),
        new winston.transports.File({ filename: 'combined.log' })
    ]
});

// Configuration
const config = {
    apiUrl: process.env.API_URL || 'https://api.example.com',
    timeout: Number(process.env.TIMEOUT) || 5000,
    retries: process.env.RETRIES ? Number(process.env.RETRIES) : 3
};

// Custom error class
class AppError extends Error {
    constructor(message, statusCode) {
        super(message);
        this.name = 'AppError';
        this.statusCode = statusCode;
    }
}

// Main application class
class Application {
    constructor(config) {
        this.config = config;
        this.logger = logger;
    }

    async initialize() {
        try {
            this.logger.info('Initializing application...');
            // Add initialization logic here
            this.logger.info('Application initialized successfully');
        } catch (error) {
            this.logger.error('Failed to initialize application:', error);
            throw error;
        }
    }

    async processData(data) {
        try {
            this.logger.info('Processing data...');
            // Add data processing logic here
            return { success: true, data };
        } catch (error) {
            this.logger.error('Failed to process data:', error);
            throw new AppError('Data processing failed', 500);
        }
    }
}

// Command line interface
const program = new Command();

program
    .name('app')
    .description('JavaScript application template')
    .version('1.0.0');

program
    .command('process')
    .description('Process data')
    .argument('<data>', 'Data to process')
    .action(async (data) => {
        try {
            const app = new Application(config);
            await app.initialize();
            const result = await app.processData(data);
            console.log('Result:', result);
        } catch (error) {
            console.error('Error:', error.message);
            process.exit(1);
        }
    });

// Main function
async function main() {
    try {
        await program.parseAsync(process.argv);
    } catch (error) {
        logger.error('Application error:', error);
        process.exit(1);
    }
}

// Run the application
if (require.main === module) {
    main().catch((error) => {
        logger.error('Fatal error:', error);
        process.exit(1);
    });
} 