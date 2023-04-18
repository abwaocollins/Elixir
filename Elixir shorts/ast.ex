defmodule TopSecret do
  # Convert a string to an abstract syntax tree (AST)
  # Args:
  # - string: A string representation of Elixir code
  # Returns:
  # - The AST of the input string
  def to_ast(string) do
    elem(Code.string_to_quoted(string), 1)
  end

  # Decode a secret message from an AST
  # Args:
  # - ast: The abstract syntax tree (AST) of Elixir code
  # - acc: An accumulator to store the decoded secret message
  # Returns:
  # - A tuple containing the updated AST and the decoded secret message appended to the accumulator
  def decode_secret_message_part({op, _metadata, arguments} = ast, acc)
      when op in [:def, :defp] do
    {name, arguments} = get_function_name(arguments)

    message =
      name
      |> to_string()
      |> String.slice(0, length(arguments))

    {ast, [message | acc]}
  end

  # Fallback clause for decode_secret_message_part/2
  # Args:
  # - ast: The abstract syntax tree (AST) of Elixir code
  # - acc: An accumulator to store the decoded secret message
  # Returns:
  # - A tuple containing the original AST wrapped in a quote block and the accumulator
  def decode_secret_message_part(ast, acc) do
    quote do
      unquote(ast)
    end

    {ast, acc}
  end

  # Helper function to extract the function name from the arguments list in the AST
  # Args:
  # - arguments: The arguments list in the abstract syntax tree (AST) of Elixir code
  # Returns:
  # - A tuple containing the function name and the remaining arguments
  defp get_function_name([{:when, _metadata, arguments} | _]) do
    get_function_name(arguments)
  end

  # Helper function to extract the function name from the arguments list in the AST
  # Args:
  # - arguments: The arguments list in the abstract syntax tree (AST) of Elixir code
  # Returns:
  # - A tuple containing the function name and the remaining arguments
  defp get_function_name([{name, _metadata, arguments} | _]) when is_list(arguments) do
    {name, arguments}
  end

  # Helper function to extract the function name from the arguments list in the AST
  # Args:
  # - arguments: The arguments list in the abstract syntax tree (AST) of Elixir code
  # Returns:
  # - A tuple containing the function name and an empty list for arguments
  defp get_function_name([{name, _metadata, arguments} | _]) when is_atom(arguments) do
    {name, []}
  end

  # Decode a secret message from a string
  # Args:
  # - string: A string representation of Elixir code containing a secret message
  # Returns:
  # - The decoded secret message
  def decode_secret_message(string) do
    {_ast, secret_message} = Macro.prewalk(to_ast(string), [], &decode_secret_message_part/2)

    secret_message
    |> Enum.reverse()
    |> Enum.join()
  end
end
