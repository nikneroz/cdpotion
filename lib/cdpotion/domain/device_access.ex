defmodule CDPotion.Domain.DeviceAccess do
  use CDPotion.Utils
  @typedoc "A device id."
  @type device_id :: String.t()

  @typedoc "Device information displayed in a user prompt to select a device."
  @type prompt_device :: %{
          id: CDPotion.Domain.DeviceAccess.device_id(),
          name: String.t()
        }

  @typedoc "Device request id."
  @type request_id :: String.t()

  @doc """
  Enable events in this domain.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"DeviceAccess.enable", %{}}
  end

  @doc """
  Disable events in this domain.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"DeviceAccess.disable", %{}}
  end

  @doc """
  Select a device in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - (Required) `id`: description not provided :(
  - (Required) `device_id`: description not provided :(
  """
  @spec select_prompt(
          CDPotion.Domain.DeviceAccess.RequestId,
          CDPotion.Domain.DeviceAccess.DeviceId
        ) :: {String.t(), map()}
  def select_prompt(id, device_id) do
    params = as_query([{"id", id}, {"deviceId", device_id}])
    {"DeviceAccess.selectPrompt", params}
  end

  @doc """
  Cancel a prompt in response to a DeviceAccess.deviceRequestPrompted event.
  ## Parameters:
    - (Required) `id`: description not provided :(
  """
  @spec cancel_prompt(CDPotion.Domain.DeviceAccess.RequestId) :: {String.t(), map()}
  def cancel_prompt(id) do
    params = as_query([{"id", id}])
    {"DeviceAccess.cancelPrompt", params}
  end
end
