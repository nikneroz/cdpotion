defmodule CDPotion.Domain.Performance do

@doc """
Disable collecting and reporting metrics.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enable collecting and reporting metrics.
## Parameters:
  - `timeDomain:string`: (Optional) Time domain to use for collecting and reporting duration metrics.
"""
def enable(time_domain \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Sets time domain to use for collecting and reporting duration metrics.
Note that this must be called before enabling metrics collection. Calling
this method while metrics collection is enabled returns an error.
## Parameters:
  - `timeDomain:string`: Time domain
"""
def set_time_domain(time_domain) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Retrieve current values of run-time metrics.
"""
def get_metrics() do
  execute(session, :navigate, %{"url" => url})
end
end