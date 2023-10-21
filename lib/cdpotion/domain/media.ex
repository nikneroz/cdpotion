defmodule CDPotion.Domain.Media do
  use CDPotion.Utils
  @typedoc "Corresponds to kMediaError"
  @type player_error :: %{
          cause: list(CDPotion.Domain.Media.player_error()),
          code: integer(),
          data: map(),
          errorType: String.t(),
          stack: list(CDPotion.Domain.Media.player_error_source_location())
        }

  @typedoc "Represents logged source line numbers reported in an error.
NOTE: file and line are from chromium c++ implementation code, not js."
  @type player_error_source_location :: %{
          file: String.t(),
          line: integer()
        }

  @typedoc "Corresponds to kMediaEventTriggered"
  @type player_event :: %{
          timestamp: CDPotion.Domain.Media.timestamp(),
          value: String.t()
        }

  @typedoc "Players will get an ID that is unique within the agent context."
  @type player_id :: String.t()

  @typedoc "Have one type per entry in MediaLogRecord::Type
Corresponds to kMessage"
  @type player_message :: %{
          level: :error | :warning | :info | :debug,
          message: String.t()
        }

  @typedoc "Corresponds to kMediaPropertyChange"
  @type player_property :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "description not provided :("
  @type timestamp :: number()

  @doc """
  Enables the Media domain
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Media.enable", %{}}
  end

  @doc """
  Disables the Media domain.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Media.disable", %{}}
  end
end
