defmodule CDPotion.Domain.Console do
  use CDPotion.Utils

  @doc """
  Does nothing.
  """
  def clear_messages() do
    {"Console.clearMessages", %{}}
  end

  @doc """
  Disables console domain, prevents further console messages from being reported to the client.
  """
  def disable() do
    {"Console.disable", %{}}
  end

  @doc """
  Enables console domain, sends the messages collected so far to the client by means of the
  `messageAdded` notification.
  """
  def enable() do
    {"Console.enable", %{}}
  end
end
