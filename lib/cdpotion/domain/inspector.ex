defmodule CDPotion.Domain.Inspector do
  use CDPotion.Utils

  @doc """
  Disables inspector domain notifications.
  """
  def disable() do
    {"Inspector.disable", %{}}
  end

  @doc """
  Enables inspector domain notifications.
  """
  def enable() do
    {"Inspector.enable", %{}}
  end
end
