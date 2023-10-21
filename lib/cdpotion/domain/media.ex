defmodule CDPotion.Domain.Media do
  use CDPotion.Utils
  @doc "Corresponds to kMediaError"
  @type PlayerError :: %{
          cause: list(Media.PlayerError),
          code: integer(),
          data: map(),
          errorType: String.t(),
          stack: list(Media.PlayerErrorSourceLocation)
        }

  @doc "Represents logged source line numbers reported in an error.
NOTE: file and line are from chromium c++ implementation code, not js."
  @type PlayerErrorSourceLocation :: %{
          file: String.t(),
          line: integer()
        }

  @doc "Corresponds to kMediaEventTriggered"
  @type PlayerEvent :: %{
          timestamp: Media.Timestamp,
          value: String.t()
        }

  @doc "Players will get an ID that is unique within the agent context."
  @type PlayerId :: String.t()

  @doc "Have one type per entry in MediaLogRecord::Type
Corresponds to kMessage"
  @type PlayerMessage :: %{
          level: :error | :warning | :info | :debug,
          message: String.t()
        }

  @doc "Corresponds to kMediaPropertyChange"
  @type PlayerProperty :: %{
          name: String.t(),
          value: String.t()
        }

  @doc "description not provided :("
  @type Timestamp :: number()

  @doc """
  Enables the Media domain
  """
  def enable() do
    {"Media.enable", %{}}
  end

  @doc """
  Disables the Media domain.
  """
  def disable() do
    {"Media.disable", %{}}
  end
end
