defmodule CDPotion.Domain.Log do
  use CDPotion.Utils

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
