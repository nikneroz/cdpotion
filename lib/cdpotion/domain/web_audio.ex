defmodule CDPotion.Domain.WebAudio do
  use CDPotion.Utils

  @doc """
  Enables the WebAudio domain and starts sending context lifetime events.
  """
  def enable() do
    {"WebAudio.enable", %{}}
  end

  @doc """
  Disables the WebAudio domain.
  """
  def disable() do
    {"WebAudio.disable", %{}}
  end

  @doc """
  Fetch the realtime data from the registered contexts.
  ## Parameters:
    - `contextId:GraphObjectId`: description not provided :(
  """
  def get_realtime_data(context_id) do
    params = as_query([{"contextId", context_id}])
    {"WebAudio.getRealtimeData", params}
  end
end
