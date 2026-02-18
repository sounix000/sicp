# SICP Setup: MIT Scheme + VS Code

## 1. Install MIT Scheme

**macOS**
```bash
brew install mit-scheme
```

**Ubuntu / Debian**
```bash
sudo apt update
sudo apt install mit-scheme
```

**Red Hat / Fedora / CentOS**
```bash
sudo dnf install mit-scheme
```

**openSUSE**
```bash
sudo zypper install mit-scheme
```

Verify:
```bash
mit-scheme --version
```

---

## 2. Set Up VS Code

### Install the extension

Install **vscode-scheme** for syntax highlighting:

- Open VS Code
- `Cmd/Ctrl+Shift+X` → search `vscode-scheme`
- Install `sjhuangx.vscode-scheme`

### Add the keybinding

`Cmd/Ctrl+Shift+P` → **Open Keyboard Shortcuts (JSON)** — add:

```json
[
  {
    "key": "ctrl+enter",
    "command": "workbench.action.terminal.runSelectedText"
  }
]
```

`Ctrl+Enter` works on both Mac and Linux.

### Add workspace settings for SICP

In the `.vscode/settings.json` of the project root directory, add the following:

```json
{
  "editor.bracketPairColorization.enabled": true,
  "editor.guides.bracketPairs": true
}
```

This snippet helps navigate the parenthesis hell of Lisp/Scheme code.

---

## 3. Running Code

### Interactive REPL — send selected expression

1. Open the VS Code terminal: `` Ctrl+` ``
2. Start the REPL:
   ```bash
   mit-scheme
   ```
3. Wait for the `1 ]=>` prompt
4. In your `.scm` file, select any expression
5. Hit `Ctrl+Enter` — it evaluates in the running REPL

Example — select and send:
```scheme
(define (square x) (* x x))
(square 5)                    ; => 25
```

### Load a whole file into the REPL

With `mit-scheme` running in the terminal:
```scheme
(load "scratch.scm")
```

This loads and evaluates the entire file, leaving you in the REPL to interact with everything defined in it.

### Run/interpret an entire file non-interactively

```bash
mit-scheme --quiet < scratch.scm
```

Interprets the file top to bottom and exits. Use this to check output without an interactive session.
