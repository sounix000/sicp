# Instructions for SICP follow-along

## Add the following to every new file

```scheme
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
```

This snippet makes some code available to these files.

