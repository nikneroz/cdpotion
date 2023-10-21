defmodule CDPotion.Domain.Performance do
  use CDPotion.Utils
  @typedoc "Run-time execution metric."
  @type metric :: %{
          name: String.t(),
          value: number()
        }

  @doc """
  Disable collecting and reporting metrics.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Performance.disable", %{}}
  end

  @doc """
  Enable collecting and reporting metrics.
  ## Parameters:
    - `time_domain`:(Optional) Time domain to use for collecting and reporting duration metrics.
  """
  @spec enable(String.t()) :: {String.t(), map()}
  def enable(time_domain \\ nil) do
    params = as_query([{"timeDomain", time_domain}])
    {"Performance.enable", params}
  end

  @doc """
  Sets time domain to use for collecting and reporting duration metrics.
  Note that this must be called before enabling metrics collection. Calling
  this method while metrics collection is enabled returns an error.
  ## Parameters:
    - `time_domain`:Time domain
  """
  @spec set_time_domain(String.t()) :: {String.t(), map()}
  def set_time_domain(time_domain) do
    params = as_query([{"timeDomain", time_domain}])
    {"Performance.setTimeDomain", params}
  end

  @doc """
  Retrieve current values of run-time metrics.
  """
  @spec get_metrics() :: {String.t(), map()}
  def get_metrics() do
    {"Performance.getMetrics", %{}}
  end
end
