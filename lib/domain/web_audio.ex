defmodule CDPotion.Domain.WebAudio do

@doc """
Enables the WebAudio domain and starts sending context lifetime events.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables the WebAudio domain.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Fetch the realtime data from the registered contexts.
## Parameters:
- `contextId:GraphObjectId`: description not provided :(
"""
def get_realtime_data(context_id) do
  execute(session, :navigate, %{"url" => url})
end
end