defmodule CDPotion.Domain.Schema do

@doc """
Returns supported domains.
"""
def get_domains() do
  execute(session, :navigate, %{"url" => url})
end
end