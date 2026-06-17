# SICP Setup Guide (openSUSE Leap 15.6 and Apple Silicon Mac)

## Goal

This guide sets up a stable environment for working through SICP from beginning to end using:

* Racket
* DrRacket
* The `sicp` language package
* Git for backups

The focus is reliability and simplicity.

---

# Part 1: Install Racket on openSUSE Leap 15.6

## Step 1: Download Racket

Visit:

https://racket-lang.org/download/

Choose the Linux installer for your architecture.

## Step 2: Run the installer

Open a terminal in the download directory.

Make the installer executable:

```bash
chmod +x racket-*.sh
```

Run it:

```bash
./racket-*.sh
```

## Step 3: Accept the defaults

For a beginner, use the default installation choices.

Do not worry about Unix-style customization.

## Step 4: Verify installation

```bash
racket --version
```

You should see a Racket version number.

---

# Part 2: Install Racket on Apple Silicon (M1/M2/M3)

## Step 1: Download

Visit:

https://racket-lang.org/download/

Choose:

* macOS
* Apple Silicon

## Step 2: Install

Open the DMG.

Drag:

```text
DrRacket.app
```

into:

```text
Applications
```

## Step 3: Verify

Open Terminal:

```bash
racket --version
```

---

# Part 3: Install the SICP Package

Open a terminal.

Run:

```bash
raco pkg install sicp
```

Wait for completion.

Verify:

```bash
raco pkg show sicp
```

The package should appear in the output.

---

# Part 4: First Launch of DrRacket

Launch DrRacket.

Choose:

```text
Language → Choose Language
```

Select:

```text
Determine language from source
```

Click OK.

---

# Part 5: First Test Program

Create a new file.

Paste:

```scheme
#lang sicp

(+ 2 3)
```

Save as:

```text
chapter1-test.rkt
```

Press Run.

Expected result:

```text
5
```

---

# Part 6: Verify Functions Work

```scheme
#lang sicp

(define (square x)
  (* x x))

(square 5)
```

Expected:

```text
25
```

---

# Part 7: Verify Recursion

```scheme
#lang sicp

(define (factorial n)
  (if (= n 0)
      1
      (* n (factorial (- n 1)))))

(factorial 5)
```

Expected:

```text
120
```

---

# Part 8: Create a Clean SICP Workspace

Create:

```text
sicp/
├── chapter1/
├── chapter2/
├── chapter3/
├── chapter4/
├── chapter5/
```

Suggested naming:

```text
chapter1/ex1.01.rkt
chapter1/ex1.02.rkt
chapter1/ex1.03.rkt
...
```

---

# Part 9: Install Git

## openSUSE

```bash
sudo zypper install git
```

## macOS

Install Xcode Command Line Tools:

```bash
xcode-select --install
```

Verify:

```bash
git --version
```

---

# Part 10: Initialize a Repository

```bash
mkdir sicp
cd sicp

git init
```

Create a commit after every few exercises:

```bash
git add .
git commit -m "Complete exercise 1.10"
```

---

# Part 11: DrRacket Features Worth Using

## Run

Linux:

```text
Ctrl+R
```

Mac:

```text
Cmd+R
```

## Check Syntax

Use frequently.

It helps identify binding and scope mistakes.

## REPL

Bottom pane.

Example:

```scheme
(+ 10 20)
```

Expected:

```text
30
```

---

# Part 12: Common Mistakes

## Forgetting #lang

Every exercise file should start with:

```scheme
#lang sicp
```

## Mixing Racket and SICP examples

Do not replace:

```scheme
#lang sicp
```

with:

```scheme
#lang racket
```

unless you know why.

## Installing multiple Scheme implementations

Avoid introducing:

* MIT Scheme
* Guile
* Chez Scheme
* Chicken Scheme

while learning SICP.

Use one environment consistently.

---

# Part 13: Final Readiness Test

```scheme
#lang sicp

(define (fib n)
  (cond ((= n 0) 0)
        ((= n 1) 1)
        (else (+ (fib (- n 1))
                 (fib (- n 2))))))

(fib 10)
```

Expected:

```text
55
```

If this works, your environment is ready for the entire book.

---

# Recommended Workflow

1. Read a section of SICP.
2. Type every example manually.
3. Run it.
4. Experiment in the REPL.
5. Solve the exercise.
6. Commit to Git.
7. Move on.

This approach minimizes tooling distractions and keeps the focus on learning the ideas in the book.

