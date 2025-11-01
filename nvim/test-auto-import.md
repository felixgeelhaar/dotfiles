# Testing Auto-Import on Save

This guide helps you verify that auto-import on save is working correctly in Neovim.

## Prerequisites

1. Ensure Neovim is running with LSP active
2. Language servers are installed (gopls, ts_ls, rust-analyzer, pyright)
3. Open a project directory in Neovim

## Test Cases

### 1. TypeScript/JavaScript Test

Create a test file: `test-imports.ts`

```typescript
// Before save: Missing imports
function greet() {
  const name = "World";
  console.log(`Hello, ${name}`);

  // Use React without import
  const element = React.createElement("div", null, "Hello");

  // Use lodash without import
  const result = _.chunk([1, 2, 3, 4], 2);

  return result;
}
```

**Expected after save (`:w`):**
```typescript
import React from 'react';
import _ from 'lodash';

function greet() {
  const name = "World";
  console.log(`Hello, ${name}`);

  const element = React.createElement("div", null, "Hello");
  const result = _.chunk([1, 2, 3, 4], 2);

  return result;
}
```

**What to verify:**
- ✅ Imports automatically added at the top
- ✅ Imports are sorted (React before lodash alphabetically)
- ✅ Code is formatted (if prettier is configured)

### 2. Go Test

Create a test file: `test.go`

```go
package main

// Before save: Missing imports and unused import
import (
    "github.com/unused/package"
)

func main() {
    // Use fmt without import
    fmt.Println("Hello, World!")

    // Use time without import
    now := time.Now()

    // Use strings without import
    upper := strings.ToUpper("hello")

    fmt.Printf("Time: %v, Upper: %s\n", now, upper)
}
```

**Expected after save (`:w`):**
```go
package main

import (
    "fmt"
    "strings"
    "time"
)

func main() {
    fmt.Println("Hello, World!")

    now := time.Now()
    upper := strings.ToUpper("hello")

    fmt.Printf("Time: %v, Upper: %s\n", now, upper)
}
```

**What to verify:**
- ✅ Missing imports (`fmt`, `time`, `strings`) automatically added
- ✅ Unused import (`github.com/unused/package`) removed
- ✅ Imports grouped and sorted (standard library imports)
- ✅ Code is formatted with gofmt

### 3. Rust Test

Create a test file: `test.rs`

```rust
// Before save: Missing use statements
fn main() {
    // Use HashMap without import
    let mut map = HashMap::new();
    map.insert("key", "value");

    // Use println! (already in prelude, no import needed)
    println!("Map: {:?}", map);

    // Use File without import
    let file = File::open("test.txt");
}
```

**Expected after save (`:w`):**
```rust
use std::collections::HashMap;
use std::fs::File;

fn main() {
    let mut map = HashMap::new();
    map.insert("key", "value");

    println!("Map: {:?}", map);

    let file = File::open("test.txt");
}
```

**What to verify:**
- ✅ Missing `use` statements added
- ✅ Imports are sorted
- ✅ Code is formatted with rustfmt

### 4. Python Test

Create a test file: `test.py`

```python
# Before save: Missing imports
def main():
    # Use datetime without import
    now = datetime.now()

    # Use json without import
    data = json.dumps({"name": "test"})

    # Use random without import
    num = random.randint(1, 10)

    print(f"Time: {now}, Data: {data}, Random: {num}")

if __name__ == "__main__":
    main()
```

**Expected after save (`:w`):**
```python
import datetime
import json
import random

def main():
    now = datetime.now()
    data = json.dumps({"name": "test"})
    num = random.randint(1, 10)

    print(f"Time: {now}, Data: {data}, Random: {num}")

if __name__ == "__main__":
    main()
```

**What to verify:**
- ✅ Missing imports added at the top
- ✅ Imports are sorted alphabetically
- ✅ Code is formatted with black (if configured)

## Troubleshooting

### Auto-import not working?

1. **Check LSP is running:**
   ```vim
   :LspInfo
   ```
   Should show attached language server for current buffer.

2. **Check if server supports code actions:**
   ```vim
   :lua vim.print(vim.lsp.get_clients()[1].server_capabilities.codeActionProvider)
   ```
   Should return `true` or a table.

3. **Check autocmd is set:**
   ```vim
   :autocmd LspAutoImport_*
   ```
   Should show BufWritePre autocmd.

4. **Test manually:**
   ```vim
   :lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
   ```
   If this works, auto-import should work on save.

5. **Check for errors:**
   ```vim
   :messages
   ```
   Look for any LSP errors.

### Common Issues

**Issue**: "No code actions available"
- **Solution**: Language server may not support organize imports. Check server capabilities.

**Issue**: Timeout when saving large files
- **Solution**: Increase timeout in `lsp_config.lua` (currently 1000ms)

**Issue**: Imports added but not formatted correctly
- **Solution**: Ensure conform.nvim is configured with the right formatter for your language

**Issue**: Duplicate imports after save
- **Solution**: This may indicate the LSP and formatter are conflicting. Check both configurations.

## Performance Notes

- Auto-import has a **1-second timeout** to prevent blocking
- If imports take longer than 1 second, the save will proceed without import organization
- For large projects, the first save after opening a file may be slower (LSP indexing)

## Manual Testing

You can also test the organize imports action manually without saving:

```vim
" In normal mode, with cursor in file:
:lua vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
```

This will immediately organize imports without triggering a save or format.

## Success Indicators

✅ **Auto-import is working if:**
1. Missing imports are added automatically when you save
2. Unused imports are removed when you save
3. Imports are sorted according to language conventions
4. No error messages appear in `:messages`
5. The process completes within 1 second

## Next Steps

Once auto-import is working:
- Try it in your real projects
- Customize timeout if needed (in `lsp_config.lua`)
- Add keybinding for manual organize imports if desired
- Enjoy not having to manually manage imports! 🎉
