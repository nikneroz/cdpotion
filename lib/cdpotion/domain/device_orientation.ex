defmodule CDPotion.Domain.DeviceOrientation do
  use CDPotion.Utils

  @doc """
  Clears the overridden Device Orientation.
  """
  def clear_device_orientation_override() do
    {"DeviceOrientation.clearDeviceOrientationOverride", %{}}
  end

  @doc """
  Overrides the Device Orientation.
  ## Parameters:
    - `alpha:number`: Mock alpha
    - `beta:number`: Mock beta
    - `gamma:number`: Mock gamma
  """
  def set_device_orientation_override(alpha, beta, gamma) do
    params = as_query([{"alpha", alpha}, {"beta", beta}, {"gamma", gamma}])
    {"DeviceOrientation.setDeviceOrientationOverride", params}
  end
end
