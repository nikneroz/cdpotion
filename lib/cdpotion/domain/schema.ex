defmodule CDPotion.Domain.Schema do
  use CDPotion.Utils
  @doc "Description of the protocol domain."
  @type Domain :: %{
          name: String.t(),
          version: String.t()
        }

  @doc """
  Returns supported domains.
  """
  def get_domains() do
    {"Schema.getDomains", %{}}
  end
end
