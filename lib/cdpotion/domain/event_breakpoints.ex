defmodule CDPotion.Domain.EventBreakpoints do
  use CDPotion.Utils

  @doc """
  Sets breakpoint on particular native event.
  ## Parameters:
    - `eventName:string`: Instrumentation name to stop on.
  """
  def set_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"EventBreakpoints.setInstrumentationBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular native event.
  ## Parameters:
    - `eventName:string`: Instrumentation name to stop on.
  """
  def remove_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"EventBreakpoints.removeInstrumentationBreakpoint", params}
  end
end
