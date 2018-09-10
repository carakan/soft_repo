defmodule SoftRepo.Extension do
  defmacro extends(module) do
    module = Macro.expand(module, __CALLER__)
    functions = module.__info__(:functions)
    signatures = Enum.map functions, fn { name, arity } ->
      args = if arity == 0 do
               []
             else
               Enum.map 1 .. arity, fn(i) ->
                 { String.to_atom(<< ?x, ?A + i - 1 >>), [], nil }
               end
             end
      { name, [], args }
    end
    quote do
      defdelegate unquote(signatures), to: unquote(module)
      defoverridable unquote(functions)
    end
  end
end
