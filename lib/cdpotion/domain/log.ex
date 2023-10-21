defmodule CDPotion.Domain.Log do
  use CDPotion.Utils
  @doc "Log entry."
  @type LogEntry :: %{
          args: list(Runtime.RemoteObject) | nil,
          category: :cors | nil,
          level: :verbose | :info | :warning | :error,
          lineNumber: integer() | nil,
          networkRequestId: Network.RequestId | nil,
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
          stackTrace: Runtime.StackTrace | nil,
          text: String.t(),
          timestamp: Runtime.Timestamp,
          url: String.t() | nil,
          workerId: String.t() | nil
        }

  @doc "Violation configuration setting."
  @type ViolationSetting :: %{
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
  def clear() do
    {"Log.clear", %{}}
  end

  @doc """
  Disables log domain, prevents further log entries from being reported to the client.
  """
  def disable() do
    {"Log.disable", %{}}
  end

  @doc """
  Enables log domain, sends the entries collected so far to the client by means of the
  `entryAdded` notification.
  """
  def enable() do
    {"Log.enable", %{}}
  end

  @doc """
  start violation reporting.
  ## Parameters:
    - `config:array`: Configuration for violations.
  """
  def start_violations_report(config) do
    params = as_query([{"config", config}])
    {"Log.startViolationsReport", params}
  end

  @doc """
  Stop violation reporting.
  """
  def stop_violations_report() do
    {"Log.stopViolationsReport", %{}}
  end
end
