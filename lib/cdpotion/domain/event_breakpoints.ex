defmodule CDPotion.Domain.EventBreakpoints do
  use CDPotion.Utils

  @doc """
  Sets breakpoint on particular native event.
  ## Parameters:
    - `event_name`:Instrumentation name to stop on.
  """
  @spec set_instrumentation_breakpoint(String.t()) :: {String.t(), map()}
  def set_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"EventBreakpoints.setInstrumentationBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular native event.
  ## Parameters:
    - `event_name`:Instrumentation name to stop on.
  """
  @spec remove_instrumentation_breakpoint(String.t()) :: {String.t(), map()}
  def remove_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"EventBreakpoints.removeInstrumentationBreakpoint", params}
  end
end
