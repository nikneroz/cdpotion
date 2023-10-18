defmodule CDPotion.Utils do
  defmacro __using__(_) do
    quote do
      defp as_query(params) do
        Map.new(args_filter(params))
      end

      defp args_filter([], acc \\ []), do: acc
      defp args_filter([{_key, nil} | tail], acc), do: args_filter(tail, acc)
      defp args_filter([{key, value} | tail], acc), do: args_filter(tail, [acc | {key, value}])
    end
  end
end
