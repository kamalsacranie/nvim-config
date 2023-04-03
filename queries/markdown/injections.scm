;; inherits: markdown
;; extends
; (paragraph (inline) @latex (#match? @latex "^\\\\begin\\{.*\\}(\n?(.*))*\\\\end\\{.*\\}"))
; (paragraph (inline) @latex (#match? @latex "\\\\begin\\{.*\\}\n([\s\S]\{-})\\\\end\\{.*\\}"))
(paragraph (inline) @latex (#match? @latex "\\\\begin\\{.*\\}(\\n|.|\\r|\\r\\n)*\\\\end\\{.*\\}"))
