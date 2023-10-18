defmodule CDPotion.Domain.Inspector do

@doc """
Disables inspector domain notifications.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables inspector domain notifications.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end
end