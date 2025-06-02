;; ==============================================================================
;; SICP Chapter X - Exercise/Example X.Y
;; Title: [Brief description of the problem/concept]
;; ==============================================================================
;; Date Created: [YYYY-MM-DD]
;; Last Modified: [YYYY-MM-DD]
;; Status: [TODO/IN_PROGRESS/TESTING/COMPLETE]
;; Difficulty: [Easy/Medium/Hard]
;;
;; Problem Statement:
;; [Copy the exercise/example description here]
;;
;; Approach:
;; [Your strategy or approach to solve this]
;;
;; Notes:
;; [Any important observations, alternative approaches, or lessons learned]
;; ==============================================================================

;; Setup and welcome message
(display "Welcome to SICP!")
(newline)
(display "------------------------------------------------------")
(newline)
(display "Chapter X - Exercise X.Y")
(newline)
(display "------------------------------------------------------")
(newline)

;; Load helper functions (with fallback paths)
(cond 
  ((file-exists? "../../sicp-helpers.scm") 
   (load "../../sicp-helpers.scm"))
  ((file-exists? "../sicp-helpers.scm") 
   (load "../sicp-helpers.scm"))
  ((file-exists? "src/sicp-helpers.scm") 
   (load "src/sicp-helpers.scm"))
  (else 
   (display "Warning: sicp-helpers.scm not found!")
   (newline)))

;; ==============================================================================
;; SOLUTION
;; ==============================================================================

;; Main solution code goes here
(define (your-solution-here)
  "Replace this with your actual solution")

;; ==============================================================================
;; TESTS
;; ==============================================================================

;; Test cases
(display "Running tests...")
(newline)

;; Example test:
;; (display "Test 1: ")
;; (display (your-solution-here test-input))
;; (newline)

;; More tests here...

(display "Tests completed!")
(newline)

;; ==============================================================================
;; SCRATCH WORK / EXPERIMENTS
;; ==============================================================================

;; Use this section for trying things out, alternative approaches, etc.
;; This code can be messy - it's your workspace!

;; ==============================================================================