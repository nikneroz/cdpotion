defmodule CDPotion.Domain.Media do
  use CDPotion.Utils

  @doc """
  Enables the Media domain
  """
  def enable() do
    {"Media.enable", %{}}
  end

  @doc """
  Disables the Media domain.
  """
  def disable() do
    {"Media.disable", %{}}
  end
end
