defmodule CDPotion.Domain.BackgroundService do
  use CDPotion.Utils

  @doc """
  Enables event updates for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def start_observing(service) do
    params = as_query([{"service", service}])
    {"BackgroundService.startObserving", params}
  end

  @doc """
  Disables event updates for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def stop_observing(service) do
    params = as_query([{"service", service}])
    {"BackgroundService.stopObserving", params}
  end

  @doc """
  Set the recording state for the service.
  ## Parameters:
    - `shouldRecord:boolean`: description not provided :(
    - `service:ServiceName`: description not provided :(
  """
  def set_recording(should_record, service) do
    params = as_query([{"shouldRecord", should_record}, {"service", service}])
    {"BackgroundService.setRecording", params}
  end

  @doc """
  Clears all stored data for the service.
  ## Parameters:
    - `service:ServiceName`: description not provided :(
  """
  def clear_events(service) do
    params = as_query([{"service", service}])
    {"BackgroundService.clearEvents", params}
  end
end
