defmodule CDPotion.Domain.Cast do
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Stops observing for sinks and issues.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets a sink to be used when the web page requests the browser to choose a
  sink via Presentation API, Remote Playback API, or Cast SDK.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def set_sink_to_use(sink_name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Starts mirroring the desktop to the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def start_desktop_mirroring(sink_name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Starts mirroring the tab to the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def start_tab_mirroring(sink_name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Stops the active Cast session on the sink.
  ## Parameters:
    - `sinkName:string`: description not provided :(
  """
  def stop_casting(sink_name) do
    execute(session, :navigate, %{"url" => url})
  end
end
