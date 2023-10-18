defmodule CDPotion.Domain.Performance do
  use CDPotion.Utils

  @doc """
  Disable collecting and reporting metrics.
  """
  def disable() do
    {"Performance.disable", %{}}
  end

  @doc """
  Enable collecting and reporting metrics.
  ## Parameters:
    - `timeDomain:string`: (Optional) Time domain to use for collecting and reporting duration metrics.
  """
  def enable(time_domain \\ nil) do
    params = as_query([{"timeDomain", time_domain}])
    {"Performance.enable", params}
  end

  @doc """
  Sets time domain to use for collecting and reporting duration metrics.
  Note that this must be called before enabling metrics collection. Calling
  this method while metrics collection is enabled returns an error.
  ## Parameters:
    - `timeDomain:string`: Time domain
  """
  def set_time_domain(time_domain) do
    params = as_query([{"timeDomain", time_domain}])
    {"Performance.setTimeDomain", params}
  end

  @doc """
  Retrieve current values of run-time metrics.
  """
  def get_metrics() do
    {"Performance.getMetrics", %{}}
  end
end
