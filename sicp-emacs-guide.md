# SICP with Emacs + MIT Scheme: Minimal Practical Guide

This guide assumes:

- Emacs
- MIT Scheme
- `scheme-mode`
- Paredit (optional but recommended)
- No Geiser

The goal is to complete all chapters and exercises in SICP with the minimum tooling required.

---

# Starting a Session

Start Emacs.

Open a Scheme file:

```text
C-x C-f
```

Example:

```text
chapter1.scm
```

Start MIT Scheme:

```text
M-x run-scheme
```

A `*scheme*` REPL buffer will appear.

---

# Basic Workflow

Write code in your `.scm` file:

```scheme
(define (square x)
  (* x x))
```

Evaluate the definition:

```text
C-M-x
```

Now test it:

```scheme
(square 5)
```

Evaluate the expression:

```text
C-x C-e
```

Result appears in the REPL:

```scheme
;Value: 25
```

This is the core SICP workflow.

---

# The Only Commands You Really Need

## Evaluate expression

Place cursor after:

```scheme
(+ 2 3 4)
```

Press:

```text
C-x C-e
```

Result:

```scheme
;Value: 9
```

---

## Evaluate definition

Given:

```scheme
(define (square x)
  (* x x))
```

Place cursor anywhere inside the definition.

Press:

```text
C-M-x
```

The definition is sent to the REPL.

Use this constantly.

---

## Evaluate a region

Select text.

Press:

```text
C-c C-r
```

Useful when sending multiple definitions.

---

## Switch to REPL

```text
C-c C-z
```

If this doesn't work:

```text
C-x b *scheme*
```

---

# Loading Entire Files

As exercises become larger:

```scheme
(load "chapter2.scm")
```

from the REPL.

Typical workflow:

1. Edit file
2. Save file
3. Reload file

```scheme
(load "chapter2.scm")
```

4. Run tests

---

# Saving Files

Save:

```text
C-x C-s
```

Save often.

---

# Navigating the REPL

Previous command:

```text
M-p
```

Next command:

```text
M-n
```

---

# Interrupting Infinite Loops

Sooner or later you'll write:

```scheme
(define (foo)
  (foo))
```

and lock up the REPL.

Interrupt:

```text
C-c
```

inside the REPL buffer.

---

# Restarting Scheme

If things become confusing:

1. Kill the REPL buffer:

```text
C-x k
```

2. Start again:

```text
M-x run-scheme
```

Fresh REPLs solve many problems.

---

# File Organization

A simple structure:

```text
sicp/
├── chapter1.scm
├── chapter2.scm
├── chapter3.scm
├── chapter4.scm
├── chapter5.scm
└── scratch.scm
```

Use `scratch.scm` for experiments.

---

# Commenting Code

Single line:

```scheme
; this is a comment
```

Multiple lines:

```scheme
#|
This is
a block comment
|#
```

---

# Example Exercise Workflow

Write:

```scheme
(define (average x y)
  (/ (+ x y) 2))
```

Evaluate:

```text
C-M-x
```

Test:

```scheme
(average 10 20)
```

Evaluate:

```text
C-x C-e
```

Result:

```scheme
;Value: 15
```

---

# Debugging

When you see:

```text
2 error>
```

read the error message carefully.

Often you'll have:

- wrong number of arguments
- unbound variable
- extra/missing parenthesis
- incorrect recursion

You can usually return to the top level with:

```scheme
(restart 1)
```

or restart the REPL.

---

# Paredit Essentials

Paredit is worth learning.

Insert parentheses:

```text
(
```

Paredit automatically inserts:

```scheme
(|)
```

Delete carefully:

```text
DEL
```

Paredit keeps parentheses balanced.

If Paredit refuses a deletion, it's usually protecting the structure.

Trust it.

---

# The SICP Routine

For almost every exercise:

1. Read exercise.
2. Write definition.
3. `C-M-x`
4. Write test expression.
5. `C-x C-e`
6. Repeat until correct.

That's it.

---

# Commands You'll Use 95% of the Time

| Action | Command |
|----------|----------|
| Start REPL | `M-x run-scheme` |
| Evaluate expression | `C-x C-e` |
| Evaluate definition | `C-M-x` |
| Evaluate region | `C-c C-r` |
| Switch to REPL | `C-c C-z` |
| Save file | `C-x C-s` |
| Previous REPL input | `M-p` |
| Next REPL input | `M-n` |
| Interrupt computation | `C-c` |

---

# Final Advice

Do not spend time optimizing the editor.

SICP is about:

- recursion
- higher-order procedures
- abstraction
- mutable state
- streams
- interpreters
- compilers

A working REPL plus:

```text
C-M-x
C-x C-e
```

is enough to complete the entire book.
