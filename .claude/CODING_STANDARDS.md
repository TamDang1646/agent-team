# Coding Standards

## Code Quality Requirements

All code MUST follow these standards before being considered complete.

## Comments & Documentation

### Required Comments

1. **Function/Method Headers**
   ```typescript
   /**
    * Description of what this function does
    * @param param1 - Description of parameter
    * @param param2 - Description of parameter
    * @returns Description of return value
    */
   async function process(param1: string, param2: number): Promise<Result> { }
   ```

2. **Complex Logic Blocks**
   ```typescript
   // Calculate weighted score based on recency and frequency
   // Formula: (recencyWeight * 0.6) + (frequencyWeight * 0.4)
   const score = recencyWeight * 0.6 + frequencyWeight * 0.4;
   ```

3. **Workarounds & Non-obvious Choices**
   ```typescript
   // Using setTimeout instead of requestAnimationFrame for
   // consistent behavior across browsers (see issue #123)
   setTimeout(() => updateUI(), 0);
   ```

### When to Comment

- **ALWAYS** comment:
  - Public APIs and their purpose
  - Non-obvious algorithm choices
  - Workarounds for library/framework bugs
  - Business logic that isn't self-explanatory
  - Performance optimizations and why they're needed

- **NEVER** comment:
  - Obvious code (e.g., `i++ // increment i`)
  - Getter/setter trivial accessors
  - Comments that become outdated quickly

## Code Conventions

### Naming Conventions

| Type | Convention | Example |
|------|------------|---------|
| Variables/Functions | camelCase | `getUserById`, `isActive` |
| Classes/Components | PascalCase | `UserManager`, `Button` |
| Constants | UPPER_SNAKE_CASE | `MAX_RETRY_COUNT` |
| Private fields | # or _prefix | `#internalData`, `_cache` |
| Types/Interfaces | PascalCase | `UserResponse`, `FetchResult` |
| Boolean | is/has/can prefix | `isValid`, `hasPermission` |

### File Structure

```typescript
// 1. Imports
import { something } from 'somewhere';

// 2. Type/Interface definitions
interface UserData { }

// 3. Constants
const MAX_SIZE = 100;

// 4. Class/Function definitions
class UserManager { }

// 5. Export
export { UserManager };
```

### Error Handling

```typescript
// GOOD: Specific error handling
try {
  await db.query(sql);
} catch (error) {
  if (error instanceof PostgreSQLError) {
    logger.error('DB connection failed:', error);
    throw new ServiceUnavailableError('Database unavailable');
  }
  throw error;
}

// BAD: Swallowing errors
try {
  await db.query(sql);
} catch (error) {
  // Don't do this
}
```

### Async/Await Patterns

```typescript
// GOOD: Proper async handling
async function fetchUser(id: string): Promise<User> {
  const response = await api.get(`/users/${id}`);
  if (!response.ok) {
    throw new UserNotFoundError(id);
  }
  return response.json();
}

// BAD: Missing error handling
async function fetchUser(id: string): Promise<User> {
  return api.get(`/users/${id}`).then(r => r.json());
}
```

### Input Validation

```typescript
// GOOD: Validate at boundaries
function createUser(data: unknown): User {
  if (!isRecord(data)) {
    throw new ValidationError('Expected object');
  }
  if (!isString(data.name)) {
    throw new ValidationError('name must be string');
  }
  return { name: data.name };
}

// Use schema validation for complex inputs
const UserSchema = z.object({
  name: z.string().min(1),
  email: z.string().email(),
  age: z.number().int().positive().optional(),
});
```

## Language-Specific Rules

### TypeScript/JavaScript

1. **Strict Mode Required**
   ```typescript
   // tsconfig.json
   {
     "compilerOptions": {
       "strict": true,
       "noImplicitAny": true,
       "strictNullChecks": true,
       "noUnusedLocals": true
     }
   }
   ```

2. **Type Safety**
   ```typescript
   // GOOD: Explicit types
   function getUser(id: string): Promise<User | null> { }

   // BAD: Using any
   function getUser(id: any): any { }
   ```

3. **Avoid Side Effects**
   ```typescript
   // GOOD: Immutable
   const updated = { ...user, name: 'New Name' };

   // BAD: Mutation
   user.name = 'New Name';
   ```

### Python

1. **Type Hints**
   ```python
   # GOOD
   def get_user(user_id: str) -> User | None:
       pass

   # BAD
   def get_user(user_id):
       pass
   ```

2. **Docstrings**
   ```python
   def process_data(data: list[str], limit: int = 100) -> dict:
       """
       Process a list of data items with optional limiting.

       Args:
           data: List of string items to process
           limit: Maximum number of items to process (default: 100)

       Returns:
           Dictionary containing processed results

       Raises:
           ValueError: If data contains None values
       """
       pass
   ```

3. **Error Handling**
   ```python
   # GOOD: Specific exceptions
   try:
       result = db.query(sql)
   except psycopg2.OperationalError as e:
       logger.error(f"DB error: {e}")
       raise ServiceUnavailableError("Database unavailable") from e
   ```

### C# / .NET

1. **Async/Await**
   ```csharp
   // GOOD
   public async Task<User?> GetUserAsync(string id) {
       var result = await _db.Users.FindAsync(id);
       return result;
   }

   // BAD: Sync over async
   public User GetUser(string id) {
       return _db.Users.Find(id);
   }
   ```

2. **Dependency Injection**
   ```csharp
   public class UserService {
       private readonly IUserRepository _repo;
       private readonly ILogger _logger;

       public UserService(IUserRepository repo, ILogger logger) {
           _repo = repo;
           _logger = logger;
       }
   }
   ```

### Unity C#

1. **Performance**
   ```csharp
   // GOOD: Cache references
   private Rigidbody _rb;

   void Awake() {
       _rb = GetComponent<Rigidbody>();
   }

   void FixedUpdate() {
       _rb.AddForce(force);
   }

   // BAD: Don't call every frame
   void Update() {
       GetComponent<Rigidbody>().AddForce(force);
   }
   ```

2. **Object Pooling**
   ```csharp
   // GOOD: Use object pool for frequent spawning
   private ObjectPool<Projectile> _pool;

   void Shoot() {
       var projectile = _pool.Get();
       projectile.transform.position = spawnPoint.position;
   }

   // BAD: Don't Instantiate/Destroy frequently
   void Shoot() {
       var proj = Instantiate(projectilePrefab);
       Destroy(proj, 5f);
   }
   ```

### SQL / Database

1. **Query Safety**
   ```sql
   -- GOOD: Parameterized queries
   SELECT * FROM users WHERE id = $1;

   -- BAD: String concatenation (SQL injection)
   SELECT * FROM users WHERE id = '""" + userId + """';
   ```

2. **Indexing**
   ```sql
   -- Create indexes for frequently queried columns
   CREATE INDEX idx_users_email ON users(email);
   CREATE INDEX idx_orders_user_id ON orders(user_id);
   ```

3. **Transactions**
   ```sql
   BEGIN;
   UPDATE accounts SET balance = balance - 100 WHERE id = 1;
   UPDATE accounts SET balance = balance + 100 WHERE id = 2;
   COMMIT;
   ```

## API Design

### REST Conventions

```typescript
// GOOD: RESTful patterns
GET    /users           - List users
GET    /users/:id       - Get user
POST   /users           - Create user
PUT    /users/:id       - Replace user
PATCH  /users/:id       - Partial update
DELETE /users/:id       - Delete user

// BAD: Non-rest patterns
POST   /getUser
GET    /createUser
```

### Response Format

```typescript
// Consistent response envelope
interface ApiResponse<T> {
  success: boolean;
  data: T | null;
  error: {
    code: string;
    message: string;
    details?: Record<string, unknown>;
  } | null;
  meta?: {
    pagination?: { page: number; limit: number; total: number };
  };
}
```

## Performance Guidelines

### Frontend

1. **Avoid Layout Thrashing**
   ```typescript
   // GOOD: Read all, then write all
   const heights = elements.map(el => el.offsetHeight);
   elements.forEach((el, i) => el.style.height = heights[i] + 'px');

   // BAD: Alternating read/write
   elements.forEach(el => {
     el.style.height = el.offsetHeight + 'px';
   });
   ```

2. **Memoization**
   ```typescript
   const expensiveValue = useMemo(() => computeExpensive(data), [data]);
   const handleClick = useCallback(() => { }, [dependency]);
   ```

### Backend

1. **N+1 Query Prevention**
   ```typescript
   // BAD: N+1 queries
   const users = await db.users.findMany();
   for (const user of users) {
     user.profile = await db.profiles.find({ userId: user.id });
   }

   // GOOD: Single query with JOIN
   const users = await db.users.findMany({
     include: { profile: true }
   });
   ```

2. **Batch Operations**
   ```typescript
   // GOOD: Batch inserts
   await db.items.createMany(items);

   // BAD: Individual inserts
   for (const item of items) {
     await db.items.create(item);
   }
   ```

## Testing Requirements

### Unit Tests

```typescript
// AAA Pattern: Arrange - Act - Assert
test('returns user when valid id provided', async () => {
  // Arrange
  const userId = '123';
  await db.users.create({ id: userId, name: 'Test' });

  // Act
  const user = await getUser(userId);

  // Assert
  expect(user).toBeDefined();
  expect(user.name).toBe('Test');
});
```

### Test Coverage Requirements

- **Minimum 80%** overall coverage
- **Critical paths**: 90%+ coverage
- **New code**: 100% coverage required

## Code Review Checklist

Before submitting code for review:

- [ ] All functions have docstrings/comments
- [ ] No hardcoded values (use constants/config)
- [ ] Error handling is comprehensive
- [ ] Input validation at boundaries
- [ ] No console.log/debug statements
- [ ] Tests pass and coverage >= 80%
- [ ] No security vulnerabilities
- [ ] Naming conventions followed
- [ ] No TODO comments left behind
- [ ] Performance considered (no N+1, proper indexing)