defmodule CDPotion.Domain.Inspector do
  use CDPotion.Utils

  @doc """
  Disables inspector domain notifications.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Inspector.disable", %{}}
  end

  @doc """
  Enables inspector domain notifications.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Inspector.enable", %{}}
  end
end
