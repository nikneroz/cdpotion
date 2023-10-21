defmodule CDPotion.Domain.Log do
  use CDPotion.Utils
  @typedoc "Log entry."
  @type log_entry :: %{
          args: list(CDPotion.Domain.Runtime.remote_object()) | nil,
          category: :cors | nil,
          level: :verbose | :info | :warning | :error,
          lineNumber: integer() | nil,
          networkRequestId: CDPotion.Domain.Network.request_id() | nil,
          source:
            :xml
            | :javascript
            | :network
            | :storage
            | :appcache
            | :rendering
            | :security
            | :deprecation
            | :worker
            | :violation
            | :intervention
            | :recommendation
            | :other,
          stackTrace: CDPotion.Domain.Runtime.stack_trace() | nil,
          text: String.t(),
          timestamp: CDPotion.Domain.Runtime.timestamp(),
          url: String.t() | nil,
          workerId: String.t() | nil
        }

  @typedoc "Violation configuration setting."
  @type violation_setting :: %{
          name:
            :longTask
            | :longLayout
            | :blockedEvent
            | :blockedParser
            | :discouragedAPIUse
            | :handler
            | :recurringHandler,
          threshold: number()
        }

  @doc """
  Clears the log.
  """
  @spec clear() :: {String.t(), map()}
  def clear() do
    {"Log.clear", %{}}
  end

  @doc """
  Disables log domain, prevents further log entries from being reported to the client.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Log.disable", %{}}
  end

  @doc """
  Enables log domain, sends the entries collected so far to the client by means of the
  `entryAdded` notification.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Log.enable", %{}}
  end

  @doc """
  start violation reporting.
  ## Parameters:
    - (Required) `config`: Configuration for violations.
  """
  @spec start_violations_report(list(CDPotion.Domain.Log.violation_setting())) ::
          {String.t(), map()}
  def start_violations_report(config) do
    params = as_query([{"config", config}])
    {"Log.startViolationsReport", params}
  end

  @doc """
  Stop violation reporting.
  """
  @spec stop_violations_report() :: {String.t(), map()}
  def stop_violations_report() do
    {"Log.stopViolationsReport", %{}}
  end
end
