defmodule CDPotion.Domain.DeviceOrientation do

@doc """
Clears the overridden Device Orientation.
"""
def clear_device_orientation_override() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Overrides the Device Orientation.
## Parameters:
  - `alpha:number`: Mock alpha
  - `beta:number`: Mock beta
  - `gamma:number`: Mock gamma
"""
def set_device_orientation_override(alpha, beta, gamma) do
  execute(session, :navigate, %{"url" => url})
end
end