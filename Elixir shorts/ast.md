# TopSecret Elixir Module

This Elixir module provides functions to decode a secret message embedded in Elixir code using its abstract syntax tree (AST).

## Functions

### `to_ast(string)`

Convert a string to an abstract syntax tree (AST)

#### Arguments

- `string`: A string representation of Elixir code

#### Returns

- The AST of the input string

### `decode_secret_message_part(ast, acc)`

Decode a secret message from an AST

#### Arguments

- `ast`: The abstract syntax tree (AST) of Elixir code
- `acc`: An accumulator to store the decoded secret message

#### Returns

- A tuple containing the updated AST and the decoded secret message appended to the accumulator

### `decode_secret_message_part/2` fallback clause

Fallback clause for `decode_secret_message_part/2`

#### Arguments

- `ast`: The abstract syntax tree (AST) of Elixir code
- `acc`: An accumulator to store the decoded secret message

#### Returns

- A tuple containing the original AST wrapped in a quote block and the accumulator

### `get_function_name(arguments)`

Helper function to extract the function name from the arguments list in the AST

#### Arguments

- `arguments`: The arguments list in the abstract syntax tree (AST) of Elixir code

#### Returns

- A tuple containing the function name and the remaining arguments

### `get_function_name/1` with list arguments

Helper function to extract the function name from the arguments list in the AST

#### Arguments

- `arguments`: The arguments list in the abstract syntax tree (AST) of Elixir code

#### Returns

- A tuple containing the function name and the remaining arguments

### `get_function_name/1` with atom arguments

Helper function to extract the function name from the arguments list in the AST

#### Arguments

- `arguments`: The arguments list in the abstract syntax tree (AST) of Elixir code

#### Returns

- A tuple containing the function name and an empty list for arguments

### `decode_secret_message(string)`

Decode a secret message from a string

#### Arguments

- `string`: A string representation of Elixir code containing a secret message

#### Returns

- The decoded secret message

#### Example you can use
```
"defmodule MyCalendar do\n  def busy?(date, time) do\n    Date.day_of_week(date) != 7 and\n      time.hour in 10..16\n  end\n\n  def yesterday?(date) do\n    Date.diff(Date.utc_today, date)\n  end\nend\n"

```

```
code = """
defmodule MyCalendar do
  def busy?(date, time) do
    Date.day_of_week(date) != 7 and
      time.hour in 10..16
  end

  def yesterday?(date) do
    Date.diff(Date.utc_today, date)
  end
end
"""

TopSecret.decode_secret_message(code)
# => "buy"

```