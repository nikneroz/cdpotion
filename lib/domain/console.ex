defmodule CDPotion.Domain.Console do
  @doc """
  Does nothing.
  """
  def clear_messages() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables console domain, prevents further console messages from being reported to the client.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables console domain, sends the messages collected so far to the client by means of the
  `messageAdded` notification.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end
end
