defmodule CDPotion.Domain.Preload do
  @doc """
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end
end
