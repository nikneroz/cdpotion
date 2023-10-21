defmodule CDPotion.Domain.BackgroundService do
  use CDPotion.Utils
  @doc "description not provided :("
  @type BackgroundServiceEvent :: %{
          eventMetadata: list(BackgroundService.EventMetadata),
          eventName: String.t(),
          instanceId: String.t(),
          origin: String.t(),
          service: BackgroundService.ServiceName,
          serviceWorkerRegistrationId: ServiceWorker.RegistrationID,
          storageKey: String.t(),
          timestamp: Network.TimeSinceEpoch
        }

  @doc "A key-value pair for additional event information to pass along."
  @type EventMetadata :: %{
          key: String.t(),
          value: String.t()
        }

  @doc "The Background Service that will be associated with the commands/events.
Every Background Service operates independently, but they share the same
API."
  @type ServiceName ::
          :backgroundFetch
          | :backgroundSync
          | :pushMessaging
          | :notifications
          | :paymentHandler
          | :periodicBackgroundSync

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
