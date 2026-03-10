---
name: codegen-doc
description: Generate comprehensive documentation from code. Use when asked to "generate docs", "document this code", "create API docs", or when automatically producing documentation from source code including JSDoc, TypeDoc, Rustdoc, and general markdown documentation.
---

# Codegen Doc

Automatically generate comprehensive documentation from source code.

## When to Use
- Generating API documentation from code
- Creating README files from project structure
- Producing JSDoc/TypeDoc/Rustdoc comments
- Building documentation sites from code

## Documentation Generation Workflow

### 1. Analyze Source Code
- Scan project structure and identify key files
- Parse function signatures, types, interfaces
- Extract existing comments and docstrings
- Identify public APIs vs internal implementation

### 2. Generate Documentation Types

#### API Reference
- Function/method signatures with parameters
- Return types and possible errors
- Usage examples for each public API
- Type definitions and interfaces

#### README Generation
- Project description and purpose
- Installation instructions
- Quick start guide
- Configuration options
- Contributing guidelines

#### Inline Documentation
- JSDoc/TSDoc comments for TypeScript/JavaScript
- Rustdoc comments for Rust
- Docstrings for Python
- XML documentation for C#

### 3. Documentation Standards

#### TypeScript/JavaScript (JSDoc)
```typescript
/**
 * Brief description of the function.
 *
 * @param paramName - Description of parameter
 * @returns Description of return value
 * @throws {ErrorType} When error occurs
 * @example
 * ```ts
 * const result = functionName(arg);
 * ```
 */
```

#### Rust (Rustdoc)
```rust
/// Brief description of the function.
///
/// # Arguments
/// * `param` - Description of parameter
///
/// # Returns
/// Description of return value
///
/// # Examples
/// ```
/// let result = function_name(arg);
/// ```
```

### 4. Quality Checks
- Ensure all public APIs are documented
- Verify examples compile/run
- Check for broken links
- Validate markdown formatting
- Ensure consistent style
