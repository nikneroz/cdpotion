defmodule CDPotion.Domain.Tethering do
  @doc """
  Request browser port binding.
  ## Parameters:
  - `port:integer`: Port number to bind.
  """
  def bind(port) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Request browser port unbinding.
  ## Parameters:
  - `port:integer`: Port number to unbind.
  """
  def unbind(port) do
    execute(session, :navigate, %{"url" => url})
  end
end
