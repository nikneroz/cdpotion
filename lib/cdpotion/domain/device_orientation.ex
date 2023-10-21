defmodule CDPotion.Domain.DeviceOrientation do
  use CDPotion.Utils

  @doc """
  Clears the overridden Device Orientation.
  """
  @spec clear_device_orientation_override() :: {String.t(), map()}
  def clear_device_orientation_override() do
    {"DeviceOrientation.clearDeviceOrientationOverride", %{}}
  end

  @doc """
  Overrides the Device Orientation.
  ## Parameters:
    - (Required) `alpha`: Mock alpha
  - (Required) `beta`: Mock beta
  - (Required) `gamma`: Mock gamma
  """
  @spec set_device_orientation_override(number(), number(), number()) :: {String.t(), map()}
  def set_device_orientation_override(alpha, beta, gamma) do
    params = as_query([{"alpha", alpha}, {"beta", beta}, {"gamma", gamma}])
    {"DeviceOrientation.setDeviceOrientationOverride", params}
  end
end
