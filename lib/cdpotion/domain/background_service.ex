defmodule CDPotion.Domain.BackgroundService do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type background_service_event :: %{
          eventMetadata: list(CDPotion.Domain.BackgroundService.event_metadata()),
          eventName: String.t(),
          instanceId: String.t(),
          origin: String.t(),
          service: CDPotion.Domain.BackgroundService.service_name(),
          serviceWorkerRegistrationId: CDPotion.Domain.ServiceWorker.registration_id(),
          storageKey: String.t(),
          timestamp: CDPotion.Domain.Network.time_since_epoch()
        }

  @typedoc "A key-value pair for additional event information to pass along."
  @type event_metadata :: %{
          key: String.t(),
          value: String.t()
        }

  @typedoc "The Background Service that will be associated with the commands/events.
Every Background Service operates independently, but they share the same
API."
  @type service_name ::
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
