defmodule CDPotion.Domain.Tethering do
  use CDPotion.Utils

  @doc """
  Request browser port binding.
  ## Parameters:
    - `port:integer`: Port number to bind.
  """
  def bind(port) do
    params = as_query([{"port", port}])
    {"Tethering.bind", params}
  end

  @doc """
  Request browser port unbinding.
  ## Parameters:
    - `port:integer`: Port number to unbind.
  """
  def unbind(port) do
    params = as_query([{"port", port}])
    {"Tethering.unbind", params}
  end
end
