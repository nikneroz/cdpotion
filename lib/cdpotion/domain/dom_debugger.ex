defmodule CDPotion.Domain.DOMDebugger do
  use CDPotion.Utils
  @typedoc "CSP Violation type."
  @type csp_violation_type :: :"trustedtype-sink-violation" | :"trustedtype-policy-violation"

  @typedoc "DOM breakpoint type."
  @type dom_breakpoint_type :: :"subtree-modified" | :"attribute-modified" | :"node-removed"

  @typedoc "Object event listener."
  @type event_listener :: %{
          backendNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          columnNumber: integer(),
          handler: CDPotion.Domain.Runtime.remote_object() | nil,
          lineNumber: integer(),
          once: boolean(),
          originalHandler: CDPotion.Domain.Runtime.remote_object() | nil,
          passive: boolean(),
          scriptId: CDPotion.Domain.Runtime.script_id(),
          type: String.t(),
          useCapture: boolean()
        }

  @doc """
  Returns event listeners of the given object.
  ## Parameters:
    - (Required) `object_id`: Identifier of the object to return listeners for.
  - (Optional) `depth`: The maximum depth at which Node children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
  - (Optional) `pierce`: Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false). Reports listeners for all contexts if pierce is enabled.
  """
  @spec get_event_listeners(CDPotion.Domain.Runtime.remote_object_id(), integer(), boolean()) ::
          {String.t(), map()}
  def get_event_listeners(object_id, depth \\ nil, pierce \\ nil) do
    params = as_query([{"objectId", object_id}, {"depth", depth}, {"pierce", pierce}])
    {"DOMDebugger.getEventListeners", params}
  end

  @doc """
  Removes DOM breakpoint that was set using `setDOMBreakpoint`.
  ## Parameters:
    - (Required) `node_id`: Identifier of the node to remove breakpoint from.
  - (Required) `type`: Type of the breakpoint to remove.
  """
  @spec remove_dom_breakpoint(
          CDPotion.Domain.DOM.node_id(),
          CDPotion.Domain.DOMDebugger.dom_breakpoint_type()
        ) :: {String.t(), map()}
  def remove_dom_breakpoint(node_id, type) do
    params = as_query([{"nodeId", node_id}, {"type", type}])
    {"DOMDebugger.removeDOMBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular DOM event.
  ## Parameters:
    - (Required) `event_name`: Event name.
  - (Optional) `target_name`: EventTarget interface name.
  """
  @spec remove_event_listener_breakpoint(String.t(), String.t()) :: {String.t(), map()}
  def remove_event_listener_breakpoint(event_name, target_name \\ nil) do
    params = as_query([{"eventName", event_name}, {"targetName", target_name}])
    {"DOMDebugger.removeEventListenerBreakpoint", params}
  end

  @doc """
  Removes breakpoint on particular native event.
  ## Parameters:
    - (Required) `event_name`: Instrumentation name to stop on.
  """
  @spec remove_instrumentation_breakpoint(String.t()) :: {String.t(), map()}
  def remove_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"DOMDebugger.removeInstrumentationBreakpoint", params}
  end

  @doc """
  Removes breakpoint from XMLHttpRequest.
  ## Parameters:
    - (Required) `url`: Resource URL substring.
  """
  @spec remove_xhr_breakpoint(String.t()) :: {String.t(), map()}
  def remove_xhr_breakpoint(url) do
    params = as_query([{"url", url}])
    {"DOMDebugger.removeXHRBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular CSP violations.
  ## Parameters:
    - (Required) `violation_types`: CSP Violations to stop upon.
  """
  @spec set_break_on_csp_violation(list(CDPotion.Domain.DOMDebugger.csp_violation_type())) ::
          {String.t(), map()}
  def set_break_on_csp_violation(violation_types) do
    params = as_query([{"violationTypes", violation_types}])
    {"DOMDebugger.setBreakOnCSPViolation", params}
  end

  @doc """
  Sets breakpoint on particular operation with DOM.
  ## Parameters:
    - (Required) `node_id`: Identifier of the node to set breakpoint on.
  - (Required) `type`: Type of the operation to stop upon.
  """
  @spec set_dom_breakpoint(
          CDPotion.Domain.DOM.node_id(),
          CDPotion.Domain.DOMDebugger.dom_breakpoint_type()
        ) :: {String.t(), map()}
  def set_dom_breakpoint(node_id, type) do
    params = as_query([{"nodeId", node_id}, {"type", type}])
    {"DOMDebugger.setDOMBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular DOM event.
  ## Parameters:
    - (Required) `event_name`: DOM Event name to stop on (any DOM event will do).
  - (Optional) `target_name`: EventTarget interface name to stop on. If equal to `"*"` or not provided, will stop on any
  EventTarget.
  """
  @spec set_event_listener_breakpoint(String.t(), String.t()) :: {String.t(), map()}
  def set_event_listener_breakpoint(event_name, target_name \\ nil) do
    params = as_query([{"eventName", event_name}, {"targetName", target_name}])
    {"DOMDebugger.setEventListenerBreakpoint", params}
  end

  @doc """
  Sets breakpoint on particular native event.
  ## Parameters:
    - (Required) `event_name`: Instrumentation name to stop on.
  """
  @spec set_instrumentation_breakpoint(String.t()) :: {String.t(), map()}
  def set_instrumentation_breakpoint(event_name) do
    params = as_query([{"eventName", event_name}])
    {"DOMDebugger.setInstrumentationBreakpoint", params}
  end

  @doc """
  Sets breakpoint on XMLHttpRequest.
  ## Parameters:
    - (Required) `url`: Resource URL substring. All XHRs having this substring in the URL will get stopped upon.
  """
  @spec set_xhr_breakpoint(String.t()) :: {String.t(), map()}
  def set_xhr_breakpoint(url) do
    params = as_query([{"url", url}])
    {"DOMDebugger.setXHRBreakpoint", params}
  end
end
