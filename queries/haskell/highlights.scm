;; inherits: haskell
;; extends

( "\\" @conceal (#set! conceal "λ"))

(((operator) @neq (#contains? @neq "/=")) @conceal (#set! conceal "≠"))
