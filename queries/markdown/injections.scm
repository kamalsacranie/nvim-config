;; inherits: markdown
;; extends
(paragraph (inline) @latex (#match? @latex "\\\\begin\\{.*\\}(\\n|.|\\r|\\r\\n)*\\\\end\\{.*\\}"))
