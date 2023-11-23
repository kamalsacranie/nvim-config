;; inherits: markdown_inline
;; extends
; (paragraph (inline) @latex (#match? @latex "\\\\begin\\{.*\\}(\\n|.|\\r|\\r\\n)*\\\\end\\{.*\\}"))
; (
;     paragraph (inline) @temp
;     (#match? @temp "\\\\begin\\{.*\\}(\\n|.|\\r|\\r\\n)*\\\\end\\{.*\\}")
; ) @latex
