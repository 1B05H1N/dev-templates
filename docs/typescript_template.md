# TypeScript Script Template Documentation

## Overview
The TypeScript script template (`template.ts`) provides a type-safe foundation for creating Node.js scripts with modern JavaScript features.

## Features

### Type Safety
- Interface definitions
- Type annotations
- Generic types
- Type checking

### Error Handling
- Custom error types
- Retry mechanism
- Error logging
- Graceful shutdown

### Logging
- Configurable log levels
- Structured logging
- Error context
- Debug information

### Environment Configuration
- Environment variable loading
- Type-safe configuration
- Default values
- Validation

## Usage Examples

### Basic Usage
```typescript
// Import the template
import { Script } from './template';

// Create and run script
const script = new Script(defaultConfig);
await script.run(process.argv.slice(2));
```

### Type Definitions
```typescript
interface User {
    id: number;
    name: string;
    email: string;
}

interface ApiResponse<T> {
    success: boolean;
    data?: T;
    error?: Error;
}
```

### Error Handling
```typescript
try {
    await processData();
} catch (error) {
    if (error instanceof CustomError) {
        logger.error('Custom error occurred', error);
    } else {
        logger.error('Unexpected error', error);
    }
    process.exit(1);
}
```

### Logging
```typescript
// Configure logger
const logger = Logger.getInstance({
    logLevel: 'debug',
    debug: true
});

// Log messages
logger.info('Process started');
logger.debug('Debug information');
logger.error('Error occurred', error);
```

## Best Practices
1. Use TypeScript's strict mode
2. Implement comprehensive error handling
3. Use async/await for asynchronous operations
4. Follow SOLID principles
5. Write unit tests
6. Use ESLint and Prettier
7. Document complex types
8. Use environment variables for configuration 