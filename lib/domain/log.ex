defmodule CDPotion.Domain.Log do
  @doc """
  Clears the log.
  """
  def clear() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables log domain, prevents further log entries from being reported to the client.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables log domain, sends the entries collected so far to the client by means of the
  `entryAdded` notification.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  start violation reporting.
  ## Parameters:
    - `config:array`: Configuration for violations.
  """
  def start_violations_report(config) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Stop violation reporting.
  """
  def stop_violations_report() do
    execute(session, :navigate, %{"url" => url})
  end
end
