defmodule CDPotion.Domain.Console do
  use CDPotion.Utils
  @typedoc "Console message."
  @type console_message :: %{
          column: integer() | nil,
          level: :log | :warning | :error | :debug | :info,
          line: integer() | nil,
          source:
            :xml
            | :javascript
            | :network
            | :"console-api"
            | :storage
            | :appcache
            | :rendering
            | :security
            | :other
            | :deprecation
            | :worker,
          text: String.t(),
          url: String.t() | nil
        }

  @doc """
  Does nothing.
  """
  @spec clear_messages() :: {String.t(), map()}
  def clear_messages() do
    {"Console.clearMessages", %{}}
  end

  @doc """
  Disables console domain, prevents further console messages from being reported to the client.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Console.disable", %{}}
  end

  @doc """
  Enables console domain, sends the messages collected so far to the client by means of the
  `messageAdded` notification.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Console.enable", %{}}
  end
end
