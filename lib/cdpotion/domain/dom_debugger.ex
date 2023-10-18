defmodule CDPotion.Domain.DOMDebugger do
  use CDPotion.Utils

  @doc """
  Returns event listeners of the given object.
  ## Parameters:
    - `objectId:Runtime.RemoteObjectId`: Identifier of the object to return listeners for.
    - `depth:integer`: (Optional) The maximum depth at which Node children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false). Reports listeners for all contexts if pierce is enabled.
  """
  def get_event_listeners(object_id, depth \\ nil, pierce \\ nil) do
    params = as_query([{"objectId", object_id}, {"depth", depth}, {"pierce", pierce}])
    {"DOMDebugger.getEventListeners", params}
  end

  @doc """
  Removes DOM breakpoint that was set using `setDOMBreakpoint`.
  ## Parameters:
    - `nodeId:DOM.NodeId`: Identifier of the node to remove breakpoint from.
    - `type:DOMBreakpointType`: Type of the breakpoint to remove.
  """
  def remove_dom_breakpoint(node_id, type) do
    params = as_query([{"nodeId", node_id}, {"type", type}])
    {"DOMDebugger.removeDOMBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular DOM event.
  ## Parameters:
    - `eventName:string`: Event name.
    - `targetName:string`: (Optional) EventTarget interface name.
  """
  def remove_event_listener_breakpoint(event_name, target_name \\ nil) do
    params = as_query([{"eventName", event_name}, {"targetName", target_name}])
    {"DOMDebugger.removeEventListenerBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular native event.
  ## Parameters:
    - `eventName:string`: Instrumentation name to stop on.
  """
  def remove_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"DOMDebugger.removeInstrumentationBreakpoint", params}
  end

  @doc """
  Removes breakpoint from XMLHttpRequest.
  ## Parameters:
    - `url:string`: Resource URL substring.
  """
  def remove_xhr_breakpoint(url) do
    params = as_query([{"url", url}])
    {"DOMDebugger.removeXHRBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular CSP violations.
  ## Parameters:
    - `violationTypes:array`: CSP Violations to stop upon.
  """
  def set_break_on_csp_violation(violation_types) do
    params = as_query([{"violationTypes", violation_types}])
    {"DOMDebugger.setBreakOnCSPViolation", params}
  end

  @doc """
  Sets breakpoint on particular operation with DOM.
  ## Parameters:
    - `nodeId:DOM.NodeId`: Identifier of the node to set breakpoint on.
    - `type:DOMBreakpointType`: Type of the operation to stop upon.
  """
  def set_dom_breakpoint(node_id, type) do
    params = as_query([{"nodeId", node_id}, {"type", type}])
    {"DOMDebugger.setDOMBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular DOM event.
  ## Parameters:
    - `eventName:string`: DOM Event name to stop on (any DOM event will do).
    - `targetName:string`: (Optional) EventTarget interface name to stop on. If equal to `"*"` or not provided, will stop on any
  EventTarget.
  """
  def set_event_listener_breakpoint(event_name, target_name \\ nil) do
    params = as_query([{"eventName", event_name}, {"targetName", target_name}])
    {"DOMDebugger.setEventListenerBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular native event.
  ## Parameters:
    - `eventName:string`: Instrumentation name to stop on.
  """
  def set_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"DOMDebugger.setInstrumentationBreakpoint", params}
  end

  @doc """
  Sets breakpoint on XMLHttpRequest.
  ## Parameters:
    - `url:string`: Resource URL substring. All XHRs having this substring in the URL will get stopped upon.
  """
  def set_xhr_breakpoint(url) do
    params = as_query([{"url", url}])
    {"DOMDebugger.setXHRBreakpoint", params}
  end
end
