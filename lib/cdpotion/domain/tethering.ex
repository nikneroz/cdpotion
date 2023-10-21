defmodule CDPotion.Domain.Tethering do
  use CDPotion.Utils

  @doc """
  Request browser port binding.
  ## Parameters:
    - `port`:Port number to bind.
  """
  @spec bind(integer()) :: {String.t(), map()}
  def bind(port) do
    params = as_query([{"port", port}])
    {"Tethering.bind", params}
  end

  @doc """
  Request browser port unbinding.
  ## Parameters:
    - `port`:Port number to unbind.
  """
  @spec unbind(integer()) :: {String.t(), map()}
  def unbind(port) do
    params = as_query([{"port", port}])
    {"Tethering.unbind", params}
  end
end
