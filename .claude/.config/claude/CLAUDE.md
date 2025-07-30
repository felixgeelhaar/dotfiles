# Claude Best Practices Guide

## Project Context & Communication

### Clear Instructions
Effective communication with Claude requires specificity and structure. Provide concrete requirements rather than vague descriptions, using positive and negative examples to illustrate expectations. Define scope clearly by specifying what's included and excluded from tasks. Set clear expectations about desired output format, length, and style to ensure alignment with project needs.

### Effective Prompting Techniques
Leverage systematic approaches for complex problem-solving by requesting step-by-step reasoning and explanations of thought processes. Structure requests using XML tags like `<requirements>`, `<examples>`, and `<constraints>` for maximum clarity. Implement role-based prompting by asking Claude to "Act as a [specific role] and help me with [specific task]" to get contextually appropriate responses. Request chain of thought explanations to understand reasoning processes and validate approach quality.

## Code Development

### Enterprise-Grade Architecture & Design
- **Follow SOLID principles** - Single responsibility, open/closed, Liskov substitution, interface segregation, dependency inversion
- **Enterprise patterns** - Implement Command Query Responsibility Segregation (CQRS), Event Sourcing where appropriate
- **Hexagonal Architecture** - Port and adapter pattern for maintainable, testable code
- **Clean Architecture** - Dependency inversion with business logic at the center
- **Microservices patterns** - API Gateway, Circuit Breaker, Saga pattern for distributed systems
- **Event-driven architecture** - Publish/subscribe patterns for loose coupling
- **Dependency injection** - Use IoC containers and DI frameworks for enterprise-grade applications

### Domain Driven Design (DDD)
- **Ubiquitous language** - Establish shared vocabulary between business and technical teams
- **Bounded contexts** - Define clear boundaries between different business domains
- **Aggregates and entities** - Model business logic with proper aggregate roots and entity relationships
- **Domain services** - Implement complex business logic that doesn't belong to a single entity
- **Value objects** - Use immutable value objects for concepts without identity
- **Domain events** - Publish events for significant business state changes
- **Anti-corruption layer** - Protect domain model from external system influences
- **Strategic design** - Context mapping and relationship patterns between bounded contexts

### Production Readiness Best Practices
- **12-Factor App methodology** - Config, dependencies, backing services, build/release/run separation
- **Health checks** - Implement liveness, readiness, and startup probes
- **Graceful shutdown** - Handle SIGTERM signals and drain connections properly
- **Circuit breakers** - Implement fault tolerance patterns for external dependencies
- **Rate limiting** - Protect APIs from abuse and ensure fair usage
- **Bulkhead pattern** - Isolate critical resources to prevent cascade failures
- **Timeout configurations** - Set appropriate timeouts for all external calls
- **Retry with exponential backoff** - Implement intelligent retry mechanisms
- **Database connection pooling** - Manage database connections efficiently
- **Resource limits** - Set CPU, memory, and file descriptor limits

### Test-Driven Development (TDD)
- **Red-Green-Refactor cycle** - Write failing test, make it pass, refactor
- **Atomic commits** - Each commit should represent a single, complete change
- **Test first approach** - Always write tests before implementation code
- **Commit message standards** - Follow conventional commits (feat:, fix:, docs:, etc.)
- **Unit test isolation** - Each test should be independent and repeatable
- **Test doubles strategy** - Use mocks, stubs, and fakes appropriately
- **BDD integration** - Use Gherkin syntax for acceptance criteria when appropriate
- **Mutation testing** - Verify test quality with mutation testing tools

### Solution-First Development Philosophy
- **Fix, don't workaround** - Always implement proper solutions rather than temporary fixes
- **Production-grade from day one** - Build with production standards from the start
- **Workarounds only when blocked** - Use workarounds only for external dependencies or third-party limitations
- **Cleanup commitment** - Always remove demo code, test scaffolding, and temporary solutions before production
- **Technical debt prevention** - Address root causes rather than symptoms
- **Refactor continuously** - Improve code quality with each iteration, never postpone refactoring
- **Complete implementation** - Finish features properly rather than leaving partial implementations

### Code Quality Standards
- **Enterprise coding standards** - Enforce consistent style across teams with automated tools
- **Static analysis** - Use SonarQube, CodeClimate, or similar for code quality metrics
- **Security scanning** - Integrate SAST/DAST tools in CI/CD pipeline
- **Meaningful names** - Variables, functions, and classes should be self-documenting
- **Small functions** - Keep functions focused on a single task (max 20 lines)
- **Error handling** - Implement proper error handling with structured logging
- **Type safety** - Use TypeScript, Go types, Python type hints, Java generics consistently
- **Code complexity metrics** - Monitor cyclomatic complexity and maintain low complexity scores

### Testing Strategy & Automation
- **Test pyramid** - Unit tests (70%), integration tests (20%), e2e tests (10%)
- **Playwright for UI testing** - Use Playwright for cross-browser end-to-end testing
- **Test automation pipeline** - Automated test execution in CI/CD with proper test reporting
- **Coverage goals** - Maintain 90%+ test coverage on critical business logic
- **Contract testing** - Use Pact or similar for API contract verification
- **Performance testing** - Include load testing in CI/CD pipeline
- **Accessibility testing** - Automated a11y testing with axe-core integration
- **Visual regression testing** - Use Playwright's screenshot comparison features
- **Database testing** - Test with real database instances, not just mocks

### Demo & Development Environment Strategy
- **Production-grade demos** - Demos should showcase actual production-quality software
- **Docker demo environment** - Separate containerized environment specifically for demonstrations
- **Database seeding strategy** - Use database migrations and seeders for realistic demo data
- **Demo data separation** - Keep demo data completely separate from production code
- **Environment-specific configuration** - Use docker-compose for demo environment setup
- **No mock data in code** - Never embed mock data in application code or components
- **Realistic data scenarios** - Demo data should represent real-world use cases and edge cases
- **Demo environment automation** - Automated setup and teardown of demo environments
- **Clean production code** - Application code remains free of demo, mock, or test data

### Documentation & Research Tools
- **Ref MCP integration** - Use ref MCP for accessing and maintaining technical documentation
- **Exa MCP utilization** - Leverage exa MCP for research and staying current with best practices
- **Living documentation** - Maintain documentation as code with automatic updates
- **Architecture Decision Records (ADR)** - Document significant architectural decisions
- **API documentation** - OpenAPI/Swagger specifications with automated generation
- **Runbooks** - Operational documentation for production support
- **Technical debt tracking** - Document and prioritize technical debt items

### Version Control & Collaboration
- **GitHub MCP integration** - Use github MCP for seamless repository management and communication
- **Atomic commits** - Each commit should be a logical, complete unit of work
- **Conventional commits** - Follow semantic commit message format
- **Branch protection rules** - Require reviews, status checks, and up-to-date branches
- **Pull request templates** - Standardize PR descriptions with checklists
- **Code review standards** - Mandatory reviews focusing on architecture, security, and testing
- **Semantic versioning** - Use semver for all releases and API changes

### Agent Utilization Strategy
- **Backend Expert Agent** - For complex server-side architecture and database design
- **Frontend UI/UX Agent** - For user interface development and user experience optimization
- **DevOps Infrastructure Agent** - For deployment, monitoring, and infrastructure management
- **Code Review Agent** - For comprehensive code quality and security reviews
- **Project Manager Agent** - For planning, coordination, and delivery tracking
- **TypeScript/JavaScript Agent** - For frontend and Node.js development expertise
- **Golang Agent** - For high-performance backend services and system programming
- **UX/UI Designer Agent** - For design system creation and user experience research
- **Product Manager Agent** - For feature prioritization and business value alignment

### Enterprise Integration Patterns
- **Message queues** - RabbitMQ, Apache Kafka for reliable messaging
- **API Gateway pattern** - Centralized API management with authentication and rate limiting
- **Service mesh** - Istio or Linkerd for service-to-service communication
- **Configuration management** - Externalized configuration with Consul, etcd, or similar
- **Distributed caching** - Redis Cluster or Hazelcast for scalable caching
- **Database per service** - Each microservice owns its data
- **Saga pattern** - Manage distributed transactions across microservices
- **Event sourcing** - Persist events rather than current state for auditability

## Security Best Practices

### General Security Framework
Input validation forms the foundation of secure applications, requiring sanitization and validation of all user inputs before processing. Authentication systems must implement proper session management with secure password policies, multi-factor authentication where appropriate, and secure session handling. Authorization should follow role-based access control (RBAC) principles, implementing least privilege access patterns. HTTPS must be enforced across all connections, with proper security headers including Content Security Policy (CSP), HTTP Strict Transport Security (HSTS), X-Frame-Options, and X-Content-Type-Options to prevent common attack vectors.

### Data Protection Standards
Sensitive data requires encryption both at rest and in transit using industry-standard algorithms and key management practices. Environment variables must be used for all secrets and configuration, with strict policies preventing secrets from being committed to version control systems. Access controls should implement least privilege principles, granting only minimum necessary permissions to users and systems. Regular security updates for dependencies and systems are mandatory, with automated vulnerability scanning integrated into CI/CD pipelines. Comprehensive audit logging must capture all security-relevant events with proper log retention and monitoring policies.

## Performance & Scalability

### Database Optimization Strategies
Proper indexing strategy requires analyzing query patterns and creating indexes on frequently queried columns while monitoring index usage and maintenance overhead. Query optimization involves eliminating N+1 query problems, using appropriate join strategies, and implementing query result caching where beneficial. Connection pooling ensures efficient database connection management with proper pool sizing based on application load patterns. Caching strategies should implement Redis or Memcached for frequently accessed data, with appropriate cache invalidation patterns and TTL configurations.

### Application Performance Engineering
Lazy loading implementations should load resources only when needed to reduce initial application startup time and memory footprint. Pagination must be implemented for all large dataset operations to prevent memory exhaustion and improve user experience. Response compression using gzip or brotli should be enabled for all text-based responses to reduce bandwidth usage. Content Delivery Network (CDN) usage is essential for serving static assets with proper cache headers and geographic distribution. Comprehensive monitoring through Application Performance Monitoring (APM) tools provides visibility into application behavior, with alerting on performance degradation and resource utilization thresholds.

## DevOps & Infrastructure

### CI/CD Pipeline Excellence
Automated testing integration ensures every commit triggers comprehensive test suites including unit, integration, and end-to-end tests with proper test result reporting and failure notifications. Code quality gates implement automated linting, static code analysis, security vulnerability scanning, and code coverage thresholds that must be met before deployment progression. Staged deployment workflows follow development, staging, and production progression with environment-specific configurations and validation checks at each stage. Rollback strategies must be implemented and tested regularly, ensuring quick recovery from deployment issues with automated rollback triggers based on health check failures or performance degradation.

Infrastructure as Code practices use tools like Terraform, AWS CloudFormation, or Azure Resource Manager to define and manage infrastructure with version control, peer review, and automated provisioning processes.

### Monitoring & Observability Framework
Structured logging strategy implements consistent log formats across all services with appropriate log levels (DEBUG, INFO, WARN, ERROR, FATAL) and correlation IDs for distributed tracing. Metrics collection encompasses both business metrics (user engagement, conversion rates, feature usage) and technical metrics (response times, error rates, resource utilization) with proper alerting thresholds. Alert management systems provide escalation paths for critical issues with clear runbooks and response procedures. Distributed tracing enables request flow visualization across microservices with tools like Jaeger or Zipkin. Health check endpoints provide comprehensive system status including database connectivity, external service dependencies, and resource availability with appropriate HTTP status codes and detailed status information.

## Frontend Development

### User Experience
- **Mobile-first design** - Design for mobile, enhance for desktop
- **Accessibility** - Follow WCAG guidelines, use semantic HTML
- **Performance budget** - Set and maintain performance budgets
- **Progressive enhancement** - Ensure basic functionality without JavaScript
- **Error boundaries** - Implement proper error handling in React/Vue

### Code Organization
- **Component architecture** - Create reusable, composable components
- **State management** - Use appropriate state management patterns
- **Bundle optimization** - Code splitting, tree shaking, lazy loading
- **CSS methodology** - Use BEM, CSS modules, or CSS-in-JS consistently
- **Design systems** - Implement consistent design tokens and components

## API Design

### RESTful APIs
- **Resource-oriented URLs** - Use nouns, not verbs in endpoint paths
- **HTTP methods correctly** - GET, POST, PUT, DELETE, PATCH as intended
- **Status codes** - Use appropriate HTTP status codes
- **Versioning strategy** - Plan for API evolution
- **Documentation** - Provide comprehensive API documentation

### GraphQL APIs
- **Schema design** - Design schema around business domains
- **Query optimization** - Implement DataLoader pattern to avoid N+1
- **Error handling** - Provide meaningful error messages
- **Security** - Implement query depth limiting and rate limiting

## Project Management

### Documentation
- **README files** - Clear setup instructions and project overview
- **API documentation** - Keep API docs up to date
- **Architecture docs** - Document key architectural decisions
- **Runbooks** - Create operational runbooks for production issues
- **Change logs** - Maintain version history and breaking changes

### Version Control
- **Meaningful commits** - Write clear, descriptive commit messages
- **Branch strategy** - Use Git Flow or similar branching strategy
- **Pull request process** - Require code reviews before merging
- **Release tags** - Tag releases with semantic versioning
- **.gitignore** - Properly exclude files that shouldn't be tracked

## Team Collaboration

### Code Review Process
- **Review checklist** - Use consistent review criteria
- **Constructive feedback** - Focus on code, not the person
- **Security review** - Check for security vulnerabilities
- **Performance review** - Consider performance implications
- **Testing review** - Ensure adequate test coverage

### Communication
- **Clear specifications** - Document requirements thoroughly
- **Regular standup** - Keep team aligned on progress and blockers
- **Retrospectives** - Continuously improve team processes
- **Knowledge sharing** - Document decisions and share learning
- **Onboarding** - Create comprehensive onboarding documentation

## Common Patterns & Anti-Patterns

### Good Patterns
- **Repository pattern** - Abstract data access logic
- **Factory pattern** - Create objects without specifying exact classes
- **Observer pattern** - Implement event-driven architectures
- **Middleware pattern** - Handle cross-cutting concerns
- **Command pattern** - Encapsulate requests as objects

### Anti-Patterns to Avoid
- **God objects** - Classes that do too much
- **Tight coupling** - Components that are too dependent on each other
- **Magic numbers** - Use named constants instead
- **Copy-paste programming** - Extract common logic into functions
- **Premature optimization** - Optimize only when needed

## Technology-Specific Guidelines

### JavaScript/TypeScript
- **Use TypeScript** - Prefer TypeScript over JavaScript for better type safety
- **ESLint + Prettier** - Consistent code formatting and linting
- **Modern syntax** - Use ES6+ features appropriately
- **Package management** - Use npm/yarn/pnpm consistently
- **Testing libraries** - Jest, Vitest, Cypress for comprehensive testing

### Python
- **PEP 8 compliance** - Follow Python style guidelines
- **Type hints** - Use type annotations for better code clarity
- **Virtual environments** - Always use virtual environments
- **Requirements management** - Use requirements.txt or Poetry
- **Testing frameworks** - pytest for testing, black for formatting

### Go
- **Go conventions** - Follow Go naming and formatting conventions
- **Error handling** - Proper error handling patterns
- **Concurrency** - Use goroutines and channels appropriately
- **Package organization** - Organize packages by domain, not layer
- **Testing** - Use built-in testing package with table-driven tests

### Docker & Containers
- **Multi-stage builds** - Minimize image size with multi-stage builds
- **Security scanning** - Scan images for vulnerabilities
- **Non-root user** - Run containers as non-root user
- **Health checks** - Implement proper container health checks
- **Resource limits** - Set appropriate CPU/memory limits

## Troubleshooting & Debugging

### Debugging Strategies
- **Reproduce the issue** - Create minimal reproduction cases
- **Logging** - Use structured logging to understand flow
- **Debugging tools** - Use appropriate debuggers and profilers
- **Monitoring data** - Leverage metrics and traces for insights
- **Systematic approach** - Isolate variables and test hypotheses

### Common Issues
- **Memory leaks** - Monitor memory usage and identify leaks
- **Performance bottlenecks** - Profile code to identify slow paths
- **Race conditions** - Use proper synchronization mechanisms
- **Configuration issues** - Validate configuration at startup
- **Dependency conflicts** - Manage dependency versions carefully

---

## Demo Environment Setup

### Docker Demo Configuration
```yaml
# docker-compose.demo.yml
version: '3.8'
services:
  app-demo:
    build: .
    environment:
      - ENV=demo
      - DATABASE_URL=postgresql://demo:demo@demo-db:5432/demo_db
    depends_on:
      - demo-db
    ports:
      - "3000:3000"
  
  demo-db:
    image: postgres:15
    environment:
      - POSTGRES_DB=demo_db
      - POSTGRES_USER=demo
      - POSTGRES_PASSWORD=demo
    volumes:
      - ./demo/seeds:/docker-entrypoint-initdb.d
      - demo_data:/var/lib/postgresql/data

volumes:
  demo_data:
```

### Demo Data Seeding
```sql
-- demo/seeds/01_users.sql
INSERT INTO users (id, name, email, created_at) VALUES
('demo-user-1', 'Alice Johnson', 'alice@demo.local', NOW()),
('demo-user-2', 'Bob Smith', 'bob@demo.local', NOW()),
('demo-user-3', 'Carol Davis', 'carol@demo.local', NOW());

-- demo/seeds/02_projects.sql
INSERT INTO projects (id, name, description, owner_id, created_at) VALUES
('demo-project-1', 'E-commerce Platform', 'Modern e-commerce solution', 'demo-user-1', NOW()),
('demo-project-2', 'Analytics Dashboard', 'Real-time analytics platform', 'demo-user-2', NOW());
```

### Demo Environment Commands
```bash
# Start demo environment
docker-compose -f docker-compose.demo.yml up -d

# Reset demo data
docker-compose -f docker-compose.demo.yml down -v
docker-compose -f docker-compose.demo.yml up -d

# Clean up demo environment
docker-compose -f docker-compose.demo.yml down
docker system prune -f
```

### Git
```bash
# Create feature branch
git checkout -b feature/feature-name

# Interactive rebase
git rebase -i HEAD~n

# Squash commits
git reset --soft HEAD~n && git commit
```

### Docker
```bash
# Build and tag
docker build -t app:latest .

# Run with environment
docker run --env-file .env -p 8080:8080 app:latest

# Clean up
docker system prune -a
```

### Database
```sql
-- Check query performance
EXPLAIN ANALYZE SELECT ...;

-- Create index
CREATE INDEX CONCURRENTLY idx_name ON table (column);
```

---

*This guide should be regularly updated as best practices evolve and new technologies are adopted.*