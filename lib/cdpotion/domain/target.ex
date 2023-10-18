defmodule CDPotion.Domain.Target do
  use CDPotion.Utils

  @doc """
  Activates (focuses) the target.
  ## Parameters:
    - `targetId:TargetID`: description not provided :(
  """
  def activate_target(target_id) do
    params = as_query([{"targetId", target_id}])
    {"Target.activateTarget", params}
  end

  @doc """
  Attaches to the target with given id.
  ## Parameters:
    - `targetId:TargetID`: description not provided :(
    - `flatten:boolean`: (Optional) Enables "flat" access to the session via specifying sessionId attribute in the commands.
  We plan to make this the default, deprecate non-flattened mode,
  and eventually retire it. See crbug.com/991325.
  """
  def attach_to_target(target_id, flatten \\ nil) do
    params = as_query([{"targetId", target_id}, {"flatten", flatten}])
    {"Target.attachToTarget", params}
  end

  @doc """
  Attaches to the browser target, only uses flat sessionId mode.
  """
  def attach_to_browser_target() do
    {"Target.attachToBrowserTarget", %{}}
  end

  @doc """
  Closes the target. If the target is a page that gets closed too.
  ## Parameters:
    - `targetId:TargetID`: description not provided :(
  """
  def close_target(target_id) do
    params = as_query([{"targetId", target_id}])
    {"Target.closeTarget", params}
  end

  @doc """
  Inject object to the target's main frame that provides a communication
  channel with browser target.
  Injected object will be available as `window[bindingName]`.
  The object has the follwing API:
  - `binding.send(json)` - a method to send messages over the remote debugging protocol
  - `binding.onmessage = json => handleMessage(json)` - a callback that will be called for the protocol notifications and command responses.
  ## Parameters:
    - `targetId:TargetID`: description not provided :(
    - `bindingName:string`: (Optional) Binding name, 'cdp' if not specified.
  """
  def expose_dev_tools_protocol(target_id, binding_name \\ nil) do
    params = as_query([{"targetId", target_id}, {"bindingName", binding_name}])
    {"Target.exposeDevToolsProtocol", params}
  end

  @doc """
  Creates a new empty BrowserContext. Similar to an incognito profile but you can have more than
  one.
  ## Parameters:
    - `disposeOnDetach:boolean`: (Optional) If specified, disposes this context when debugging session disconnects.
    - `proxyServer:string`: (Optional) Proxy server, similar to the one passed to --proxy-server
    - `proxyBypassList:string`: (Optional) Proxy bypass list, similar to the one passed to --proxy-bypass-list
    - `originsWithUniversalNetworkAccess:array`: (Optional) An optional list of origins to grant unlimited cross-origin access to.
  Parts of the URL other than those constituting origin are ignored.
  """
  def create_browser_context(
        dispose_on_detach \\ nil,
        proxy_server \\ nil,
        proxy_bypass_list \\ nil,
        origins_with_universal_network_access \\ nil
      ) do
    params =
      as_query([
        {"disposeOnDetach", dispose_on_detach},
        {"proxyServer", proxy_server},
        {"proxyBypassList", proxy_bypass_list},
        {"originsWithUniversalNetworkAccess", origins_with_universal_network_access}
      ])

    {"Target.createBrowserContext", params}
  end

  @doc """
  Returns all browser contexts created with `Target.createBrowserContext` method.
  """
  def get_browser_contexts() do
    {"Target.getBrowserContexts", %{}}
  end

  @doc """
  Creates a new page.
  ## Parameters:
    - `url:string`: The initial URL the page will be navigated to. An empty string indicates about:blank.
    - `width:integer`: (Optional) Frame width in DIP (headless chrome only).
    - `height:integer`: (Optional) Frame height in DIP (headless chrome only).
    - `browserContextId:Browser.BrowserContextID`: (Optional) The browser context to create the page in.
    - `enableBeginFrameControl:boolean`: (Optional) Whether BeginFrames for this target will be controlled via DevTools (headless chrome only,
  not supported on MacOS yet, false by default).
    - `newWindow:boolean`: (Optional) Whether to create a new Window or Tab (chrome-only, false by default).
    - `background:boolean`: (Optional) Whether to create the target in background or foreground (chrome-only,
  false by default).
    - `forTab:boolean`: (Optional) Whether to create the target of type "tab".
  """
  def create_target(
        url,
        width \\ nil,
        height \\ nil,
        browser_context_id \\ nil,
        enable_begin_frame_control \\ nil,
        new_window \\ nil,
        background \\ nil,
        for_tab \\ nil
      ) do
    params =
      as_query([
        {"url", url},
        {"width", width},
        {"height", height},
        {"browserContextId", browser_context_id},
        {"enableBeginFrameControl", enable_begin_frame_control},
        {"newWindow", new_window},
        {"background", background},
        {"forTab", for_tab}
      ])

    {"Target.createTarget", params}
  end

  @doc """
  Detaches session with given id.
  ## Parameters:
    - `sessionId:SessionID`: (Optional) Session to detach.
    - `targetId:TargetID`: (Optional) Deprecated.
  """
  def detach_from_target(session_id \\ nil, target_id \\ nil) do
    params = as_query([{"sessionId", session_id}, {"targetId", target_id}])
    {"Target.detachFromTarget", params}
  end

  @doc """
  Deletes a BrowserContext. All the belonging pages will be closed without calling their
  beforeunload hooks.
  ## Parameters:
    - `browserContextId:Browser.BrowserContextID`: description not provided :(
  """
  def dispose_browser_context(browser_context_id) do
    params = as_query([{"browserContextId", browser_context_id}])
    {"Target.disposeBrowserContext", params}
  end

  @doc """
  Returns information about a target.
  ## Parameters:
    - `targetId:TargetID`: (Optional) description not provided :(
  """
  def get_target_info(target_id \\ nil) do
    params = as_query([{"targetId", target_id}])
    {"Target.getTargetInfo", params}
  end

  @doc """
  Retrieves a list of available targets.
  ## Parameters:
    - `filter:TargetFilter`: (Optional) Only targets matching filter will be reported. If filter is not specified
  and target discovery is currently enabled, a filter used for target discovery
  is used for consistency.
  """
  def get_targets(filter \\ nil) do
    params = as_query([{"filter", filter}])
    {"Target.getTargets", params}
  end

  @doc """
  Sends protocol message over session with given id.
  Consider using flat mode instead; see commands attachToTarget, setAutoAttach,
  and crbug.com/991325.
  ## Parameters:
    - `message:string`: description not provided :(
    - `sessionId:SessionID`: (Optional) Identifier of the session.
    - `targetId:TargetID`: (Optional) Deprecated.
  """
  def send_message_to_target(message, session_id \\ nil, target_id \\ nil) do
    params = as_query([{"message", message}, {"sessionId", session_id}, {"targetId", target_id}])
    {"Target.sendMessageToTarget", params}
  end

  @doc """
  Controls whether to automatically attach to new targets which are considered to be related to
  this one. When turned on, attaches to all existing related targets as well. When turned off,
  automatically detaches from all currently attached targets.
  This also clears all targets added by `autoAttachRelated` from the list of targets to watch
  for creation of related targets.
  ## Parameters:
    - `autoAttach:boolean`: Whether to auto-attach to related targets.
    - `waitForDebuggerOnStart:boolean`: Whether to pause new targets when attaching to them. Use `Runtime.runIfWaitingForDebugger`
  to run paused targets.
    - `flatten:boolean`: (Optional) Enables "flat" access to the session via specifying sessionId attribute in the commands.
  We plan to make this the default, deprecate non-flattened mode,
  and eventually retire it. See crbug.com/991325.
    - `filter:TargetFilter`: (Optional) Only targets matching filter will be attached.
  """
  def set_auto_attach(auto_attach, wait_for_debugger_on_start, flatten \\ nil, filter \\ nil) do
    params =
      as_query([
        {"autoAttach", auto_attach},
        {"waitForDebuggerOnStart", wait_for_debugger_on_start},
        {"flatten", flatten},
        {"filter", filter}
      ])

    {"Target.setAutoAttach", params}
  end

  @doc """
  Adds the specified target to the list of targets that will be monitored for any related target
  creation (such as child frames, child workers and new versions of service worker) and reported
  through `attachedToTarget`. The specified target is also auto-attached.
  This cancels the effect of any previous `setAutoAttach` and is also cancelled by subsequent
  `setAutoAttach`. Only available at the Browser target.
  ## Parameters:
    - `targetId:TargetID`: description not provided :(
    - `waitForDebuggerOnStart:boolean`: Whether to pause new targets when attaching to them. Use `Runtime.runIfWaitingForDebugger`
  to run paused targets.
    - `filter:TargetFilter`: (Optional) Only targets matching filter will be attached.
  """
  def auto_attach_related(target_id, wait_for_debugger_on_start, filter \\ nil) do
    params =
      as_query([
        {"targetId", target_id},
        {"waitForDebuggerOnStart", wait_for_debugger_on_start},
        {"filter", filter}
      ])

    {"Target.autoAttachRelated", params}
  end

  @doc """
  Controls whether to discover available targets and notify via
  `targetCreated/targetInfoChanged/targetDestroyed` events.
  ## Parameters:
    - `discover:boolean`: Whether to discover available targets.
    - `filter:TargetFilter`: (Optional) Only targets matching filter will be attached. If `discover` is false,
  `filter` must be omitted or empty.
  """
  def set_discover_targets(discover, filter \\ nil) do
    params = as_query([{"discover", discover}, {"filter", filter}])
    {"Target.setDiscoverTargets", params}
  end

  @doc """
  Enables target discovery for the specified locations, when `setDiscoverTargets` was set to
  `true`.
  ## Parameters:
    - `locations:array`: List of remote locations.
  """
  def set_remote_locations(locations) do
    params = as_query([{"locations", locations}])
    {"Target.setRemoteLocations", params}
  end
end
