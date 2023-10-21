defmodule CDPotion.Domain.ServiceWorker do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type registration_id :: String.t()

  @typedoc "ServiceWorker error message."
  @type service_worker_error_message :: %{
          columnNumber: integer(),
          errorMessage: String.t(),
          lineNumber: integer(),
          registrationId: CDPotion.Domain.ServiceWorker.registration_id(),
          sourceURL: String.t(),
          versionId: String.t()
        }

  @typedoc "ServiceWorker registration."
  @type service_worker_registration :: %{
          isDeleted: boolean(),
          registrationId: CDPotion.Domain.ServiceWorker.registration_id(),
          scopeURL: String.t()
        }

  @typedoc "ServiceWorker version."
  @type service_worker_version :: %{
          controlledClients: list(CDPotion.Domain.Target.target_id()) | nil,
          registrationId: CDPotion.Domain.ServiceWorker.registration_id(),
          runningStatus: CDPotion.Domain.ServiceWorker.service_worker_version_running_status(),
          scriptLastModified: number() | nil,
          scriptResponseTime: number() | nil,
          scriptURL: String.t(),
          status: CDPotion.Domain.ServiceWorker.service_worker_version_status(),
          targetId: CDPotion.Domain.Target.target_id() | nil,
          versionId: String.t()
        }

  @typedoc "description not provided :("
  @type service_worker_version_running_status :: :stopped | :starting | :running | :stopping

  @typedoc "description not provided :("
  @type service_worker_version_status ::
          :new | :installing | :installed | :activating | :activated | :redundant

  @doc """
  ## Parameters:
    - `origin:string`: description not provided :(
    - `registrationId:RegistrationID`: description not provided :(
    - `data:string`: description not provided :(
  """
  def deliver_push_message(origin, registration_id, data) do
    params = as_query([{"origin", origin}, {"registrationId", registration_id}, {"data", data}])
    {"ServiceWorker.deliverPushMessage", params}
  end

  @doc """
  """
  def disable() do
    {"ServiceWorker.disable", %{}}
  end

  @doc """
  ## Parameters:
    - `origin:string`: description not provided :(
    - `registrationId:RegistrationID`: description not provided :(
    - `tag:string`: description not provided :(
    - `lastChance:boolean`: description not provided :(
  """
  def dispatch_sync_event(origin, registration_id, tag, last_chance) do
    params =
      as_query([
        {"origin", origin},
        {"registrationId", registration_id},
        {"tag", tag},
        {"lastChance", last_chance}
      ])

    {"ServiceWorker.dispatchSyncEvent", params}
  end

  @doc """
  ## Parameters:
    - `origin:string`: description not provided :(
    - `registrationId:RegistrationID`: description not provided :(
    - `tag:string`: description not provided :(
  """
  def dispatch_periodic_sync_event(origin, registration_id, tag) do
    params = as_query([{"origin", origin}, {"registrationId", registration_id}, {"tag", tag}])
    {"ServiceWorker.dispatchPeriodicSyncEvent", params}
  end

  @doc """
  """
  def enable() do
    {"ServiceWorker.enable", %{}}
  end

  @doc """
  ## Parameters:
    - `versionId:string`: description not provided :(
  """
  def inspect_worker(version_id) do
    params = as_query([{"versionId", version_id}])
    {"ServiceWorker.inspectWorker", params}
  end

  @doc """
  ## Parameters:
    - `forceUpdateOnPageLoad:boolean`: description not provided :(
  """
  def set_force_update_on_page_load(force_update_on_page_load) do
    params = as_query([{"forceUpdateOnPageLoad", force_update_on_page_load}])
    {"ServiceWorker.setForceUpdateOnPageLoad", params}
  end

  @doc """
  ## Parameters:
    - `scopeURL:string`: description not provided :(
  """
  def skip_waiting(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.skipWaiting", params}
  end

  @doc """
  ## Parameters:
    - `scopeURL:string`: description not provided :(
  """
  def start_worker(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.startWorker", params}
  end

  @doc """
  """
  def stop_all_workers() do
    {"ServiceWorker.stopAllWorkers", %{}}
  end

  @doc """
  ## Parameters:
    - `versionId:string`: description not provided :(
  """
  def stop_worker(version_id) do
    params = as_query([{"versionId", version_id}])
    {"ServiceWorker.stopWorker", params}
  end

  @doc """
  ## Parameters:
    - `scopeURL:string`: description not provided :(
  """
  def unregister(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.unregister", params}
  end

  @doc """
  ## Parameters:
    - `scopeURL:string`: description not provided :(
  """
  def update_registration(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.updateRegistration", params}
  end
end
