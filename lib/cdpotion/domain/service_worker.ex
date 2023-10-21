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
    - (Required) `origin`: description not provided :(
  - (Required) `registration_id`: description not provided :(
  - (Required) `data`: description not provided :(
  """
  @spec deliver_push_message(
          String.t(),
          CDPotion.Domain.ServiceWorker.registration_id(),
          String.t()
        ) :: {String.t(), map()}
  def deliver_push_message(origin, registration_id, data) do
    params = as_query([{"origin", origin}, {"registrationId", registration_id}, {"data", data}])
    {"ServiceWorker.deliverPushMessage", params}
  end

  @doc """

  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"ServiceWorker.disable", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `origin`: description not provided :(
  - (Required) `registration_id`: description not provided :(
  - (Required) `tag`: description not provided :(
  - (Required) `last_chance`: description not provided :(
  """
  @spec dispatch_sync_event(
          String.t(),
          CDPotion.Domain.ServiceWorker.registration_id(),
          String.t(),
          boolean()
        ) :: {String.t(), map()}
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
    - (Required) `origin`: description not provided :(
  - (Required) `registration_id`: description not provided :(
  - (Required) `tag`: description not provided :(
  """
  @spec dispatch_periodic_sync_event(
          String.t(),
          CDPotion.Domain.ServiceWorker.registration_id(),
          String.t()
        ) :: {String.t(), map()}
  def dispatch_periodic_sync_event(origin, registration_id, tag) do
    params = as_query([{"origin", origin}, {"registrationId", registration_id}, {"tag", tag}])
    {"ServiceWorker.dispatchPeriodicSyncEvent", params}
  end

  @doc """

  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"ServiceWorker.enable", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `version_id`: description not provided :(
  """
  @spec inspect_worker(String.t()) :: {String.t(), map()}
  def inspect_worker(version_id) do
    params = as_query([{"versionId", version_id}])
    {"ServiceWorker.inspectWorker", params}
  end

  @doc """

  ## Parameters:
    - (Required) `force_update_on_page_load`: description not provided :(
  """
  @spec set_force_update_on_page_load(boolean()) :: {String.t(), map()}
  def set_force_update_on_page_load(force_update_on_page_load) do
    params = as_query([{"forceUpdateOnPageLoad", force_update_on_page_load}])
    {"ServiceWorker.setForceUpdateOnPageLoad", params}
  end

  @doc """

  ## Parameters:
    - (Required) `scope_url`: description not provided :(
  """
  @spec skip_waiting(String.t()) :: {String.t(), map()}
  def skip_waiting(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.skipWaiting", params}
  end

  @doc """

  ## Parameters:
    - (Required) `scope_url`: description not provided :(
  """
  @spec start_worker(String.t()) :: {String.t(), map()}
  def start_worker(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.startWorker", params}
  end

  @doc """

  """
  @spec stop_all_workers() :: {String.t(), map()}
  def stop_all_workers() do
    {"ServiceWorker.stopAllWorkers", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `version_id`: description not provided :(
  """
  @spec stop_worker(String.t()) :: {String.t(), map()}
  def stop_worker(version_id) do
    params = as_query([{"versionId", version_id}])
    {"ServiceWorker.stopWorker", params}
  end

  @doc """

  ## Parameters:
    - (Required) `scope_url`: description not provided :(
  """
  @spec unregister(String.t()) :: {String.t(), map()}
  def unregister(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.unregister", params}
  end

  @doc """

  ## Parameters:
    - (Required) `scope_url`: description not provided :(
  """
  @spec update_registration(String.t()) :: {String.t(), map()}
  def update_registration(scope_url) do
    params = as_query([{"scopeURL", scope_url}])
    {"ServiceWorker.updateRegistration", params}
  end
end
