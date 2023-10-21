defmodule CDPotion.Domain.Schema do
  use CDPotion.Utils
  @typedoc "Description of the protocol domain."
  @type domain :: %{
          name: String.t(),
          version: String.t()
        }

  @doc """
  Returns supported domains.
  """
  @spec get_domains() :: {String.t(), map()}
  def get_domains() do
    {"Schema.getDomains", %{}}
  end
end
