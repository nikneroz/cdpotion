defmodule CDPotion.Domain.Cast do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type sink :: %{
          id: String.t(),
          name: String.t(),
          session: String.t() | nil
        }

  @doc """
  Starts observing for sinks that can be used for tab mirroring, and if set,
  sinks compatible with |presentationUrl| as well. When sinks are found, a
  |sinksUpdated| event is fired.
  Also starts observing for issue messages. When an issue is added or removed,
  an |issueUpdated| event is fired.
  ## Parameters:
    - `presentationUrl:string`: (Optional) description not provided :(
  """
  def enable(presentation_url \\ nil) do
    params = as_query([{"presentationUrl", presentation_url}])
    {"Cast.enable", params}
  end

  @doc """
  Stops observing for sinks and issues.
  """
  def disable() do
    {"Cast.disable", %{}}
  end

  @doc """
  Sets a sink to be used when the web page requests the browser to choose a
  sink via Presentation API, Remote Playback API, or Cast SDK.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def set_sink_to_use(sink_name) do
    params = as_query([{"sinkName", sink_name}])
    {"Cast.setSinkToUse", params}
  end

  @doc """
  Starts mirroring the desktop to the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def start_desktop_mirroring(sink_name) do
    params = as_query([{"sinkName", sink_name}])
    {"Cast.startDesktopMirroring", params}
  end

  @doc """
  Starts mirroring the tab to the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def start_tab_mirroring(sink_name) do
    params = as_query([{"sinkName", sink_name}])
    {"Cast.startTabMirroring", params}
  end

  @doc """
  Stops the active Cast session on the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def stop_casting(sink_name) do
    params = as_query([{"sinkName", sink_name}])
    {"Cast.stopCasting", params}
  end
end
