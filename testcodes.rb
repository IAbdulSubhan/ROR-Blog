require 'sanitize'

user_input = "<script>alert('XSS');</script><p>Hello World!</p>"
sanitized_input = Sanitize.fragment(user_input)


# Output: "<p>Hello World!</p>"
