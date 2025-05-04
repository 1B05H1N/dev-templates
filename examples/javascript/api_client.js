#!/usr/bin/env node

/**
 * Script Name: api_client.js
 * Description: API client with retry mechanism and error handling
 * Author: Ibrahim (https://github.com/1B05H1N)
 * Date: 2025-05-04
 */

import axios from 'axios';
import winston from 'winston';
import { Command } from 'commander';

// Configure logger
const logger = winston.createLogger({
    level: 'info',
    format: winston.format.combine(
        winston.format.timestamp(),
        winston.format.json()
    ),
    transports: [
        new winston.transports.Console(),
        new winston.transports.File({ filename: 'api_client.log' })
    ]
});

// Custom error class
class ApiError extends Error {
    constructor(message, statusCode, details) {
        super(message);
        this.name = 'ApiError';
        this.statusCode = statusCode;
        this.details = details;
    }
}

// API client class
class ApiClient {
    constructor(config) {
        this.client = axios.create({
            baseURL: config.baseURL,
            timeout: config.timeout,
            headers: config.headers
        });
        this.maxRetries = config.maxRetries || 3;
        this.retryDelay = config.retryDelay || 1000;
    }

    async request(method, endpoint, data = null) {
        let lastError;
        
        for (let attempt = 1; attempt <= this.maxRetries; attempt++) {
            try {
                logger.info(`Attempt ${attempt} to ${method} ${endpoint}`);
                const response = await this.client.request({
                    method,
                    url: endpoint,
                    data
                });
                return response.data;
            } catch (error) {
                lastError = error;
                if (error.response) {
                    logger.error(`API Error: ${error.response.status} - ${error.response.statusText}`);
                    if (error.response.status >= 500) {
                        if (attempt < this.maxRetries) {
                            logger.info(`Retrying in ${this.retryDelay}ms...`);
                            await new Promise(resolve => setTimeout(resolve, this.retryDelay));
                            continue;
                        }
                    }
                    throw new ApiError(
                        error.response.data?.message || 'API request failed',
                        error.response.status,
                        error.response.data
                    );
                }
                throw new ApiError(
                    error.message,
                    error.code || 500,
                    error
                );
            }
        }
        
        throw lastError;
    }

    async get(endpoint) {
        return this.request('GET', endpoint);
    }

    async post(endpoint, data) {
        return this.request('POST', endpoint, data);
    }

    async put(endpoint, data) {
        return this.request('PUT', endpoint, data);
    }

    async delete(endpoint) {
        return this.request('DELETE', endpoint);
    }
}

// Command line interface
const program = new Command();

program
    .name('api-client')
    .description('CLI for making API requests')
    .version('1.0.0');

program
    .command('get')
    .description('Make a GET request')
    .argument('<endpoint>', 'API endpoint')
    .action(async (endpoint) => {
        try {
            const client = new ApiClient({
                baseURL: 'https://api.example.com',
                timeout: 5000,
                headers: {
                    'Authorization': `Bearer ${process.env.API_TOKEN}`,
                    'Content-Type': 'application/json'
                }
            });

            const response = await client.get(endpoint);
            console.log(JSON.stringify(response, null, 2));
        } catch (error) {
            console.error('Error:', error.message);
            process.exit(1);
        }
    });

program
    .command('post')
    .description('Make a POST request')
    .argument('<endpoint>', 'API endpoint')
    .argument('<data>', 'JSON data to send')
    .action(async (endpoint, data) => {
        try {
            const client = new ApiClient({
                baseURL: 'https://api.example.com',
                timeout: 5000,
                headers: {
                    'Authorization': `Bearer ${process.env.API_TOKEN}`,
                    'Content-Type': 'application/json'
                }
            });

            const jsonData = JSON.parse(data);
            const response = await client.post(endpoint, jsonData);
            console.log(JSON.stringify(response, null, 2));
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