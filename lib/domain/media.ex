defmodule CDPotion.Domain.Media do

@doc """
Enables the Media domain
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables the Media domain.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end
end