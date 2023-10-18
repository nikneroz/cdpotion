defmodule CDPotion.Domain.Schema do
  use CDPotion.Utils

  @doc """
  Returns supported domains.
  """
  def get_domains() do
    {"Schema.getDomains", %{}}
  end
end
