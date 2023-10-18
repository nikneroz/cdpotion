defmodule CDPotion.Domain.SystemInfo do

@doc """
Returns information about the system.
"""
def get_info() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns information about the feature state.
## Parameters:
- `featureState:string`: description not provided :(
"""
def get_feature_state(feature_state) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns information about all running processes.
"""
def get_process_info() do
  execute(session, :navigate, %{"url" => url})
end
end