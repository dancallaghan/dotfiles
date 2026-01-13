;; extends

((call_expression
    function: (identifier) @_template_function_name
    arguments: (template_string (string_fragment) @injection.content))
  (#eq? @_template_function_name "collapseWhitespace")
  (#set! injection.include-children)
  (#set! injection.language "sql"))
