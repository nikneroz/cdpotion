defmodule CDPotion.Domain.DeviceAccess do
  @doc """
  Enable events in this domain.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disable events in this domain.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Select a device in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - `id:RequestId`: description not provided :(
    - `deviceId:DeviceId`: description not provided :(
  """
  def select_prompt(id, device_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Cancel a prompt in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - `id:RequestId`: description not provided :(
  """
  def cancel_prompt(id) do
    execute(session, :navigate, %{"url" => url})
  end
end
