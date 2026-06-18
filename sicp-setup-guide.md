# SICP Setup Guide — openSUSE Leap 15.6 & Apple Silicon (DrRacket, battle-tested)

A stable, problem-proof environment for working through SICP cover to cover with **Racket + DrRacket + the `sicp` language pack**, plus Git for real backups.

This version has been verified on a real install (Racket 9.x on openSUSE). The installer prompts and the verification program below match what actually happens — including the one genuinely non-obvious thing: **how streams behave in `#lang sicp`**.

---

## Strategy (why this works)

Pick the wrong Scheme and SICP fights you. We avoid every common failure by using **Racket with `#lang sicp`**, which reproduces SICP's exact environment — including the two things that break elsewhere:

- **mutable pairs** with `set-car!` / `set-cdr!` (Chapter 3)
- **`cons-stream`** as a working special form (Chapter 3.5 streams)
- plus `nil`, `true`, `false`, `force`/`delay`, `runtime`, `random`, proper tail calls

Since you're going **DrRacket-only**, you barely need the terminal: DrRacket runs the whole book — *including the picture language, inline* — and even installs the `sicp` package itself. The terminal is needed only for Git.

> **One thing to know up front:** `#lang sicp` is a *sealed* language. It does **not** let you `require` external libraries the usual way, and it provides `cons-stream` but **not** the stream accessors. You define `stream-car`/`stream-cdr` yourself — which is exactly what SICP has you do. This is normal; see Part 6.

---

## Part 1 — Install Racket on openSUSE Leap 15.6

### 1. Download
<https://racket-lang.org/download/> → Linux → x86_64. You'll get a `.sh` installer (a generic Linux/`buster` build is fine on Leap).

### 2. Run it as root
```bash
sudo bash ~/Downloads/racket-*-x86_64-linux-*-cs.sh
```

### 3. Answer the prompts like this (this is the clean, no-patchwork path)

- **"Do you want a Unix-style distribution?"** → type **`yes`**
  (This is what puts `racket`/`raco`/`drracket` on your `PATH`, adds DrRacket to your application menu, and generates a `racket-uninstall` script.)
- **"Where do you want to base your installation?"** → type **`2`** for **`/usr/local/...`**
  (Keeps your manual install separate from zypper-managed `/usr`. The default `/usr` also works, but `/usr/local` is the tidier convention.)
- Accept defaults for anything else.

> **To remove it later** (clean, one command): `sudo racket-uninstall`

### 4. Launch DrRacket
Open a **new** terminal and run `drracket`, or find it in your application menu (log out/in if it doesn't appear immediately).

> **If DrRacket won't launch** with a missing-library error (e.g. `libgtk-3`): `sudo zypper install gtk3`, then retry. (Most desktops already have it.)

---

## Part 2 — Install Racket on Apple Silicon (M1/M2/M3)

### 1. Download
<https://racket-lang.org/download/> → macOS → **Apple Silicon** (native, no Rosetta).

### 2. Install — drag the **whole Racket folder**
Open the `.dmg`, drag the entire **`Racket v9.x` folder** into **Applications** — **not** just `DrRacket.app`. The folder also contains `bin/` with the `racket`/`raco` command-line tools; dragging only the app loses them.

### 3. First launch (Gatekeeper)
macOS may block the first launch ("unidentified developer"). Either **right-click the app → Open → Open**, or **System Settings → Privacy & Security → Open Anyway**. Once only.

### 4. (Optional) command-line access
Not needed for the book. If you want `racket`/`raco` in the terminal, add to `~/.zshrc`:
```bash
export PATH="$PATH:/Applications/Racket v9.x/bin"   # match your version
```
then `source ~/.zshrc`. Otherwise install the package from inside DrRacket (Part 3).

---

## Part 3 — Install the `sicp` package

### Recommended: from inside DrRacket (no terminal, no PATH)
1. Open DrRacket.
2. **File → Install Package…**
3. Type `sicp`, click **Install**, wait for the log to finish, close the dialog.

This installs `#lang sicp` and the `sicp-pict` picture library and handles dependencies.

### Alternative: terminal
```bash
raco pkg install --auto sicp     # --auto skips the dependency prompt
raco pkg show sicp               # verify
```

> **Don't be alarmed if `raco pkg show` lists `sicp` only under "User-specific"** with "[none]" for Installation-wide. Running `raco pkg install` *without* `sudo` (as your normal user) installs into your user scope — that's the correct, fully-working outcome on a single-user machine. The real test is Part 5, not this output.

---

## Part 4 — Tell DrRacket to read the language line (one time)

**Language → Choose Language… → "The Racket Language"** (shown/described as **"Determine language from source"**) → **OK**.

Now the `#lang` line at the top of each file decides the language. (You'll see "Determine language from source" in DrRacket's bottom-left status bar when it's set right.)

---

## Part 5 — Verify the environment *properly*

Create `verify.rkt`, paste this, and press **Run** (`Ctrl+R` Linux / `Cmd+R` mac). This is the corrected, self-contained test — it confirms the package works **and** that Chapter 3's mutation and streams behave, with **no `require`**:

```scheme
#lang sicp

; --- basics ---
(display (+ 2 3)) (newline)                              ; 5
(define (square x) (* x x))
(display (square 5)) (newline)                           ; 25

; --- recursion ---
(define (factorial n) (if (= n 0) 1 (* n (factorial (- n 1)))))
(display (factorial 5)) (newline)                        ; 120

; --- empty-list constant ---
(display (null? nil)) (newline)                          ; #t

; --- mutable pairs (Chapter 3) ---
(define p (cons 1 2))
(set-car! p 99)
(set-cdr! p 100)
(display p) (newline)                                    ; (99 . 100)

; --- streams (Chapter 3.5) ---
; #lang sicp provides cons-stream (a special form that DELAYS the tail into a
; promise), but NOT the accessors. Define them yourself, exactly as SICP does.
; Note the (force ...) in stream-cdr — without it you get a promise, not a value.
(define (stream-car s) (car s))
(define (stream-cdr s) (force (cdr s)))
(define (integers-from n) (cons-stream n (integers-from (+ n 1))))
(display (stream-car (stream-cdr (integers-from 1)))) (newline)   ; 2

(display "ENVIRONMENT OK") (newline)
```

If you get `5 / 25 / 120 / #t / (99 . 100) / 2 / ENVIRONMENT OK`, **every chapter is covered**, streams included.

> Why the `force`? `cons-stream` expands to roughly `(cons a (delay b))` — the tail is a *promise*. So `stream-cdr` must `force` it. `stream-car` stays plain `car` because the head isn't delayed. When you reach §3.5.1, the book has you define these same two procedures — so this isn't a workaround, it's a preview.

---

## Part 6 — Streams & imports in `#lang sicp` (read once, save yourself an hour)

Two facts that trip everyone up, both demonstrated by the verification above:

1. **You define the stream accessors yourself.** `#lang sicp` gives you `cons-stream`, `delay`, and `force`, but not `stream-car`/`stream-cdr`/`stream-null?`. Define them (the book does too). `stream-cdr` **must force the tail**: `(force (cdr s))`.

2. **`require` doesn't work here.** `#lang sicp` is sealed; `(require racket/stream)` errors with `require: unbound identifier`. Don't try to import the streams library — just define the small helpers yourself as above. You won't need `require` for SICP.

---

## Part 7 — The Picture Language (§2.2.4)

This section needs the `sicp-pict` library and a graphics window. In DrRacket it renders **inline** — the one place you use `#lang racket`:

```scheme
#lang racket
(require sicp-pict)

(paint einstein)                                  ; the sample painter that ships with sicp-pict
(paint (beside einstein (flip-vert einstein)))    ; the book's combinators all work
(paint (below einstein einstein))
```

Press **Run** → the picture appears in the bottom (interactions) pane. Operations you need — `beside`, `below`, `flip-horiz`, `flip-vert`, `rotate90` — all come from `sicp-pict`.

> Note: `require` *does* work in `#lang racket` (just not in `#lang sicp`), which is why the picture sections use `#lang racket`.

---

## Part 8 — Workspace structure

```
sicp/
├── .gitignore
├── chapter1/
│   ├── 1.1-elements.rkt
│   └── ex1.01.rkt
├── chapter2/
├── chapter3/
├── chapter4/
└── chapter5/
```

Every file starts with `#lang sicp` (or `#lang racket` for picture-language files).

---

## Part 9 — Git, `.gitignore`, and real backups

### Install Git
- **openSUSE:** `sudo zypper install git`
- **macOS:** `xcode-select --install`
- Verify: `git --version`

### Initialize + ignore junk
```bash
cd sicp
git init
```
`.gitignore`:
```gitignore
compiled/
*.rkt~
.DS_Store
```

### Commit + push (local commits aren't a backup)
```bash
git add .
git commit -m "Complete exercise 1.10"
```
Create a **private** GitHub/GitLab repo, then:
```bash
git remote add origin <your-repo-url>
git push -u origin main      # or 'master'
```
Now `git push` after each session is a true offsite backup.

---

## Part 10 — DrRacket features worth using

- **Run** — `Ctrl+R` / `Cmd+R`. Loads your file's definitions into the REPL.
- **REPL** (bottom pane) — type expressions to experiment; your definitions are loaded after Run.
- **Check Syntax** (toolbar) — draws arrows from each variable to its binding. Great for seeing scope and catching binding mistakes in SICP.
- **Reindent** — select code, press **Tab**; DrRacket fixes the layout. Paren matching is automatic.

> The algebraic **Stepper** is tied to the HtDP teaching languages and won't appear under `#lang sicp`, so don't go looking for it — use Check Syntax and the REPL.

---

## Part 11 — Common mistakes

- **Forgetting `#lang`.** Every file must begin with `#lang sicp` (or `#lang racket` for picture files).
- **Using `#lang racket` for ordinary chapters.** It has *immutable* pairs, so `set-car!`/`set-cdr!` break and `cons-stream` is missing. Use `#lang sicp` everywhere except §2.2.4.
- **Expecting `require` or prebuilt `stream-car` in `#lang sicp`.** Neither exists there — define stream helpers yourself (Part 6).
- **Installing several Schemes at once.** Don't add MIT Scheme, Guile, Chez, or Chicken while learning — stay in this one environment.

---

## Part 12 — Troubleshooting

| Symptom | Cause | Fix |
|---|---|---|
| `#lang sicp` underlined red / "collection not found" | `sicp` package not installed | DrRacket → **File → Install Package… → `sicp`** |
| `nil` / `set-car!` "undefined" | File isn't `#lang sicp` | First line must be exactly `#lang sicp` |
| `set-car!: contract violation, expected mutable pair` | You're in `#lang racket` | Switch the file to `#lang sicp` |
| `stream-car: unbound identifier` | `#lang sicp` ships only `cons-stream`, not the accessors | Define them yourself: `(define (stream-car s) (car s))` / `(define (stream-cdr s) (force (cdr s)))` |
| `mcar: contract violation … given: #<promise>` | Your `stream-cdr` isn't forcing the tail | Use `(force (cdr s))`, not bare `(cdr s)` |
| `require: unbound identifier in: require` | `#lang sicp` is sealed; no library imports | Don't `require`; define the helpers yourself (Part 6) |
| `(paint einstein)` errors / shows nothing | Wrong lang or missing picture lib | `#lang racket` + `(require sicp-pict)`; install `sicp` |
| `raco pkg show` lists `sicp` only under "User-specific" | Installed without `sudo` (user scope) | Correct and expected on a single-user machine — it works |
| DrRacket won't launch on openSUSE (`libgtk-3`) | GUI libs absent | `sudo zypper install gtk3` |
| macOS: "DrRacket can't be opened, unidentified developer" | Gatekeeper | Right-click → **Open**, or Privacy & Security → **Open Anyway** |

> **Uninstall later:** `sudo racket-uninstall` (created by the Unix-style install).

---

## Final readiness check

Run `verify.rkt` (Part 5). If it prints `ENVIRONMENT OK`, then run the `(paint einstein)` snippet (Part 7). If both work, your environment is ready for the entire book — Chapter 3.5 streams and the picture language included.

---

## Recommended workflow

1. Read a section of SICP.
2. Type every example yourself (don't copy-paste).
3. Run it; experiment in the REPL.
4. Solve the exercise.
5. `git commit` (and `git push` at session's end).
6. Move on.

*Stack: Racket 9.x · `#lang sicp` (+ `sicp-pict`) · DrRacket · Git with a remote. Verified on a live install.*
