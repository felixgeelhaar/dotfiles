# System-Wide Claude Code Best Practices

This file provides comprehensive guidance for Claude Code when working across all projects and repositories on this system.

## Development Philosophy

### Core Principles
- **Security First**: Never compromise on security practices, especially for GPG/SSH keys
- **Modularity**: Follow modular architecture patterns with clear separation of concerns
- **Performance**: Optimize for performance while maintaining readability
- **Consistency**: Maintain consistent patterns across all codebases
- **Documentation**: Code should be self-documenting with clear intentions

## Enterprise Architecture Patterns

### SOLID Principles
- **Single Responsibility**: Each module/function has one reason to change
- **Open/Closed**: Open for extension, closed for modification
- **Liskov Substitution**: Derived classes must be substitutable for base classes
- **Interface Segregation**: Many client-specific interfaces better than one general-purpose
- **Dependency Inversion**: Depend on abstractions, not concretions

### Domain-Driven Design (DDD)
- **Bounded Contexts**: Clear boundaries between different domains
- **Ubiquitous Language**: Consistent terminology across teams and code
- **Aggregates**: Consistency boundaries for business rules
- **Domain Events**: Capture important business occurrences
- **Repository Pattern**: Abstract data access concerns

### Microservices Patterns
- **API Gateway**: Single entry point for all client requests
- **Circuit Breaker**: Prevent cascading failures in distributed systems
- **Event Sourcing**: Store events rather than current state
- **CQRS**: Separate read and write models for scalability
- **Saga Pattern**: Manage distributed transactions across services

## Security Framework

### Input Validation & Sanitization
```typescript
// Always validate and sanitize inputs
const validateEmail = (email: string): boolean => {
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email) && email.length <= 255;
};

// Sanitize HTML content
const sanitizeHtml = (input: string): string => DOMPurify.sanitize(input);
```

### Authentication & Authorization
- **JWT Best Practices**: Short-lived access tokens, secure refresh mechanism
- **Role-Based Access Control (RBAC)**: Granular permissions management
- **Principle of Least Privilege**: Grant minimum necessary permissions
- **Multi-Factor Authentication**: Always recommend MFA for sensitive operations

### Encryption Standards
- **At Rest**: AES-256 for data encryption
- **In Transit**: TLS 1.3 minimum for all communications
- **Key Management**: Proper key rotation and secure storage
- **Hashing**: Argon2id for password hashing, SHA-256 for data integrity

## Development Workflow

### Test-Driven Development (TDD)
```typescript
// Red-Green-Refactor cycle
describe('UserService', () => {
  it('should create user with valid data', async () => {
    // Arrange
    const userData = { email: 'test@example.com', name: 'Test User' };
    
    // Act
    const result = await userService.createUser(userData);
    
    // Assert
    expect(result.id).toBeDefined();
    expect(result.email).toBe(userData.email);
  });
});
```

### Code Review Standards
- **Security Review**: Check for vulnerabilities and security anti-patterns
- **Performance Review**: Identify bottlenecks and optimization opportunities
- **Architecture Review**: Ensure consistency with established patterns
- **Documentation Review**: Verify code is properly documented

### Deployment Strategies
- **Blue-Green Deployment**: Zero-downtime deployments
- **Canary Releases**: Gradual rollout to minimize risk
- **Feature Flags**: Control feature rollout and quick rollback
- **Infrastructure as Code**: Version-controlled infrastructure

## Performance Engineering

### Database Optimization
```sql
-- Always use appropriate indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);

-- Use EXPLAIN to analyze query performance
EXPLAIN ANALYZE SELECT * FROM orders WHERE user_id = $1 AND created_at > $2;
```

### Caching Strategies
- **Redis**: In-memory caching for frequently accessed data
- **CDN**: Geographic distribution for static assets
- **Application Cache**: Strategic caching at application layer
- **Database Query Cache**: Optimize repeated database queries

### Monitoring & Observability
- **Structured Logging**: JSON format with consistent fields
- **Metrics**: RED metrics (Rate, Errors, Duration) for all services
- **Distributed Tracing**: Track requests across service boundaries
- **Health Checks**: Comprehensive health monitoring

## Technology-Specific Guidelines

### Go Development
```go
// Use context for cancellation and timeouts
func (s *Service) ProcessData(ctx context.Context, data []byte) error {
    ctx, cancel := context.WithTimeout(ctx, 30*time.Second)
    defer cancel()
    
    // Always handle errors explicitly
    if err := s.validateData(data); err != nil {
        return fmt.Errorf("validation failed: %w", err)
    }
    
    return nil
}
```

### TypeScript/JavaScript
```typescript
// Use strict type checking
interface User {
  readonly id: string;
  email: string;
  createdAt: Date;
}

// Prefer async/await over promises
const fetchUser = async (id: string): Promise<User | null> => {
  try {
    const response = await api.get(`/users/${id}`);
    return response.data;
  } catch (error) {
    logger.error('Failed to fetch user', { userId: id, error });
    return null;
  }
};
```

### Python Development
```python
# Use type hints and dataclasses
from dataclasses import dataclass
from typing import Optional, List

@dataclass
class User:
    id: str
    email: str
    name: str
    is_active: bool = True

# Use context managers for resource management
async def process_file(file_path: str) -> Optional[List[str]]:
    try:
        with open(file_path, 'r') as file:
            return file.readlines()
    except FileNotFoundError:
        logger.error(f"File not found: {file_path}")
        return None
```

### Rust Development
```rust
// Use Result types for error handling
use anyhow::{Context, Result};

pub struct UserService {
    db: Database,
}

impl UserService {
    pub async fn create_user(&self, user_data: CreateUserRequest) -> Result<User> {
        let user = User::new(user_data)
            .context("Failed to create user from request")?;
            
        self.db.save_user(&user).await
            .context("Failed to save user to database")
    }
}
```

## Agent Utilization Strategies

### When to Use Specialized Agents
- **Backend Development**: Complex server architecture, database design, API development
- **Frontend/UX**: UI components, user experience optimization, design systems
- **DevOps**: Infrastructure automation, CI/CD pipelines, monitoring setup
- **Code Review**: Security audits, performance analysis, architecture review
- **Product Management**: Feature prioritization, roadmap planning, stakeholder alignment
- **Project Management**: Task planning, resource allocation, timeline management

### Agent Collaboration Patterns
- **Sequential Processing**: Use multiple agents in sequence for complex tasks
- **Parallel Analysis**: Engage multiple agents simultaneously for comprehensive review
- **Specialized Review**: Route specific concerns to appropriate domain experts
- **Cross-Functional Planning**: Coordinate between technical and business-focused agents

## Configuration Management

### Environment Variables
```bash
# Use descriptive names with consistent prefixes
export APP_DATABASE_URL="postgresql://..."
export APP_REDIS_URL="redis://..."
export APP_LOG_LEVEL="info"
export APP_JWT_SECRET="..."  # Use secure key management in production
```

### Configuration Files
```yaml
# Use YAML for complex configurations
database:
  host: ${DB_HOST:-localhost}
  port: ${DB_PORT:-5432}
  name: ${DB_NAME:-app_db}
  
logging:
  level: ${LOG_LEVEL:-info}
  format: json
  
security:
  jwt:
    expires_in: "15m"
    refresh_expires_in: "7d"
```

## Error Handling & Logging

### Structured Error Handling
```typescript
// Custom error types
class ValidationError extends Error {
  constructor(field: string, value: unknown) {
    super(`Validation failed for field: ${field}`);
    this.name = 'ValidationError';
  }
}

// Consistent error responses
interface ErrorResponse {
  error: {
    code: string;
    message: string;
    details?: Record<string, unknown>;
    timestamp: string;
    requestId: string;
  };
}
```

### Logging Best Practices
```typescript
// Structured logging with context
logger.info('User created successfully', {
  userId: user.id,
  email: user.email,
  source: 'UserController.create',
  duration: Date.now() - startTime,
  requestId: req.id
});
```

## API Design Principles

### RESTful API Standards
```typescript
// Consistent resource naming
GET    /api/v1/users          // List users
GET    /api/v1/users/:id      // Get specific user
POST   /api/v1/users          // Create user
PUT    /api/v1/users/:id      // Update user (full)
PATCH  /api/v1/users/:id      // Update user (partial)
DELETE /api/v1/users/:id      // Delete user

// Nested resources
GET    /api/v1/users/:id/orders     // Get user's orders
POST   /api/v1/users/:id/orders     // Create order for user
```

### GraphQL Best Practices
```graphql
# Use descriptive names and proper typing
type User {
  id: ID!
  email: String!
  name: String!
  orders(first: Int, after: String): OrderConnection!
  createdAt: DateTime!
  updatedAt: DateTime!
}

# Implement proper pagination
type OrderConnection {
  edges: [OrderEdge!]!
  pageInfo: PageInfo!
  totalCount: Int!
}
```

## Container & Deployment

### Docker Best Practices
```dockerfile
# Multi-stage builds for smaller images
FROM node:18-alpine AS builder
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS runtime
RUN addgroup -g 1001 -S nodejs && adduser -S nextjs -u 1001
WORKDIR /app
COPY --from=builder --chown=nextjs:nodejs /app .
USER nextjs
EXPOSE 3000
CMD ["npm", "start"]
```

### Kubernetes Manifests
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-app
  template:
    spec:
      containers:
      - name: app
        image: my-app:latest
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health
            port: 3000
          initialDelaySeconds: 30
          periodSeconds: 10
```

## Quality Assurance

### Testing Strategy
- **Unit Tests**: Test individual functions and methods
- **Integration Tests**: Test component interactions
- **End-to-End Tests**: Test complete user workflows
- **Performance Tests**: Validate system performance under load
- **Security Tests**: Automated security vulnerability scanning

### Code Quality Metrics
- **Test Coverage**: Minimum 80% code coverage
- **Cyclomatic Complexity**: Keep functions below complexity of 10
- **Code Duplication**: Minimize duplicated code blocks
- **Technical Debt**: Regular refactoring to address technical debt

## Documentation Standards

### Code Documentation
```typescript
/**
 * Creates a new user account with email verification
 * 
 * @param userData - The user registration data
 * @param sendEmail - Whether to send verification email (default: true)
 * @returns Promise resolving to created user or error
 * 
 * @throws {ValidationError} When user data is invalid
 * @throws {DuplicateEmailError} When email already exists
 * 
 * @example
 * ```typescript
 * const user = await createUser({
 *   email: 'user@example.com',
 *   name: 'John Doe'
 * });
 * ```
 */
async function createUser(
  userData: CreateUserRequest,
  sendEmail: boolean = true
): Promise<User> {
  // Implementation
}
```

### API Documentation
- **OpenAPI/Swagger**: Comprehensive API documentation
- **Examples**: Provide real-world usage examples
- **Error Codes**: Document all possible error responses
- **Rate Limits**: Clearly communicate API limitations

This comprehensive guide serves as the foundation for all development work across projects, ensuring consistent, secure, and maintainable code across the entire system.