defmodule CDPotion.Domain.DeviceAccess do
  use CDPotion.Utils

  @doc """
  Enable events in this domain.
  """
  def enable() do
    {"DeviceAccess.enable", %{}}
  end

  @doc """
  Disable events in this domain.
  """
  def disable() do
    {"DeviceAccess.disable", %{}}
  end

  @doc """
  Select a device in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - `id:RequestId`: description not provided :(
    - `deviceId:DeviceId`: description not provided :(
  """
  def select_prompt(id, device_id) do
    params = as_query([{"id", id}, {"deviceId", device_id}])
    {"DeviceAccess.selectPrompt", params}
  end

  @doc """
  Cancel a prompt in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - `id:RequestId`: description not provided :(
  """
  def cancel_prompt(id) do
    params = as_query([{"id", id}])
    {"DeviceAccess.cancelPrompt", params}
  end
end
