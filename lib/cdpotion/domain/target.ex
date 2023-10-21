defmodule CDPotion.Domain.Target do
  use CDPotion.Utils
  @typedoc "A filter used by target query/discovery/auto-attach operations."
  @type filter_entry :: %{
          exclude: boolean() | nil,
          type: String.t() | nil
        }

  @typedoc "description not provided :("
  @type remote_location :: %{
          host: String.t(),
          port: integer()
        }

  @typedoc "Unique identifier of attached debugging session."
  @type session_id :: String.t()

  @typedoc "The entries in TargetFilter are matched sequentially against targets and
the first entry that matches determines if the target is included or not,
depending on the value of `exclude` field in the entry.
If filter is not specified, the one assumed is
[{type: 'browser', exclude: true}, {type: 'tab', exclude: true}, {}]
(i.e. include everything but `browser` and `tab`)."
  @type target_filter :: list(CDPotion.Domain.Target.filter_entry())

  @typedoc "description not provided :("
  @type target_id :: String.t()

  @typedoc "description not provided :("
  @type target_info :: %{
          attached: boolean(),
          browserContextId: CDPotion.Domain.Browser.browser_context_id() | nil,
          canAccessOpener: boolean(),
          openerFrameId: CDPotion.Domain.Page.frame_id() | nil,
          openerId: CDPotion.Domain.Target.target_id() | nil,
          subtype: String.t() | nil,
          targetId: CDPotion.Domain.Target.target_id(),
          title: String.t(),
          type: String.t(),
          url: String.t()
        }

  @doc """
  Activates (focuses) the target.
  ## Parameters:
    - (Required) `target_id`: description not provided :(
  """
  @spec activate_target(CDPotion.Domain.Target.TargetID) :: {String.t(), map()}
  def activate_target(target_id) do
    params = as_query([{"targetId", target_id}])
    {"Target.activateTarget", params}
  end

  @doc """
  Attaches to the target with given id.
  ## Parameters:
    - (Required) `target_id`: description not provided :(
  - (Optional) `flatten`: Enables "flat" access to the session via specifying sessionId attribute in the commands.
  We plan to make this the default, deprecate non-flattened mode,
  and eventually retire it. See crbug.com/991325.
  """
  @spec attach_to_target(CDPotion.Domain.Target.TargetID, boolean()) :: {String.t(), map()}
  def attach_to_target(target_id, flatten \\ nil) do
    params = as_query([{"targetId", target_id}, {"flatten", flatten}])
    {"Target.attachToTarget", params}
  end

  @doc """
  Attaches to the browser target, only uses flat sessionId mode.
  """
  @spec attach_to_browser_target() :: {String.t(), map()}
  def attach_to_browser_target() do
    {"Target.attachToBrowserTarget", %{}}
  end

  @doc """
  Closes the target. If the target is a page that gets closed too.
  ## Parameters:
    - (Required) `target_id`: description not provided :(
  """
  @spec close_target(CDPotion.Domain.Target.TargetID) :: {String.t(), map()}
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
    - (Required) `target_id`: description not provided :(
  - (Optional) `binding_name`: Binding name, 'cdp' if not specified.
  """
  @spec expose_dev_tools_protocol(CDPotion.Domain.Target.TargetID, String.t()) ::
          {String.t(), map()}
  def expose_dev_tools_protocol(target_id, binding_name \\ nil) do
    params = as_query([{"targetId", target_id}, {"bindingName", binding_name}])
    {"Target.exposeDevToolsProtocol", params}
  end

  @doc """
  Creates a new empty BrowserContext. Similar to an incognito profile but you can have more than
  one.
  ## Parameters:
    - (Optional) `dispose_on_detach`: If specified, disposes this context when debugging session disconnects.
  - (Optional) `proxy_server`: Proxy server, similar to the one passed to --proxy-server
  - (Optional) `proxy_bypass_list`: Proxy bypass list, similar to the one passed to --proxy-bypass-list
  - (Optional) `origins_with_universal_network_access`: An optional list of origins to grant unlimited cross-origin access to.
  Parts of the URL other than those constituting origin are ignored.
  """
  @spec create_browser_context(boolean(), String.t(), String.t(), list(String.t())) ::
          {String.t(), map()}
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
  @spec get_browser_contexts() :: {String.t(), map()}
  def get_browser_contexts() do
    {"Target.getBrowserContexts", %{}}
  end

  @doc """
  Creates a new page.
  ## Parameters:
    - (Required) `url`: The initial URL the page will be navigated to. An empty string indicates about:blank.
  - (Optional) `width`: Frame width in DIP (headless chrome only).
  - (Optional) `height`: Frame height in DIP (headless chrome only).
  - (Optional) `browser_context_id`: The browser context to create the page in.
  - (Optional) `enable_begin_frame_control`: Whether BeginFrames for this target will be controlled via DevTools (headless chrome only,
  not supported on MacOS yet, false by default).
  - (Optional) `new_window`: Whether to create a new Window or Tab (chrome-only, false by default).
  - (Optional) `background`: Whether to create the target in background or foreground (chrome-only,
  false by default).
  - (Optional) `for_tab`: Whether to create the target of type "tab".
  """
  @spec create_target(
          String.t(),
          integer(),
          integer(),
          CDPotion.Domain.Browser.BrowserContextID,
          boolean(),
          boolean(),
          boolean(),
          boolean()
        ) :: {String.t(), map()}
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
    - (Optional) `session_id`: Session to detach.
  - (Optional) `target_id`: Deprecated.
  """
  @spec detach_from_target(CDPotion.Domain.Target.SessionID, CDPotion.Domain.Target.TargetID) ::
          {String.t(), map()}
  def detach_from_target(session_id \\ nil, target_id \\ nil) do
    params = as_query([{"sessionId", session_id}, {"targetId", target_id}])
    {"Target.detachFromTarget", params}
  end

  @doc """
  Deletes a BrowserContext. All the belonging pages will be closed without calling their
  beforeunload hooks.
  ## Parameters:
    - (Required) `browser_context_id`: description not provided :(
  """
  @spec dispose_browser_context(CDPotion.Domain.Browser.BrowserContextID) :: {String.t(), map()}
  def dispose_browser_context(browser_context_id) do
    params = as_query([{"browserContextId", browser_context_id}])
    {"Target.disposeBrowserContext", params}
  end

  @doc """
  Returns information about a target.
  ## Parameters:
    - (Optional) `target_id`: description not provided :(
  """
  @spec get_target_info(CDPotion.Domain.Target.TargetID) :: {String.t(), map()}
  def get_target_info(target_id \\ nil) do
    params = as_query([{"targetId", target_id}])
    {"Target.getTargetInfo", params}
  end

  @doc """
  Retrieves a list of available targets.
  ## Parameters:
    - (Optional) `filter`: Only targets matching filter will be reported. If filter is not specified
  and target discovery is currently enabled, a filter used for target discovery
  is used for consistency.
  """
  @spec get_targets(CDPotion.Domain.Target.TargetFilter) :: {String.t(), map()}
  def get_targets(filter \\ nil) do
    params = as_query([{"filter", filter}])
    {"Target.getTargets", params}
  end

  @doc """
  Sends protocol message over session with given id.
  Consider using flat mode instead; see commands attachToTarget, setAutoAttach,
  and crbug.com/991325.
  ## Parameters:
    - (Required) `message`: description not provided :(
  - (Optional) `session_id`: Identifier of the session.
  - (Optional) `target_id`: Deprecated.
  """
  @spec send_message_to_target(
          String.t(),
          CDPotion.Domain.Target.SessionID,
          CDPotion.Domain.Target.TargetID
        ) :: {String.t(), map()}
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
    - (Required) `auto_attach`: Whether to auto-attach to related targets.
  - (Required) `wait_for_debugger_on_start`: Whether to pause new targets when attaching to them. Use `Runtime.runIfWaitingForDebugger`
  to run paused targets.
  - (Optional) `flatten`: Enables "flat" access to the session via specifying sessionId attribute in the commands.
  We plan to make this the default, deprecate non-flattened mode,
  and eventually retire it. See crbug.com/991325.
  - (Optional) `filter`: Only targets matching filter will be attached.
  """
  @spec set_auto_attach(boolean(), boolean(), boolean(), CDPotion.Domain.Target.TargetFilter) ::
          {String.t(), map()}
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
    - (Required) `target_id`: description not provided :(
  - (Required) `wait_for_debugger_on_start`: Whether to pause new targets when attaching to them. Use `Runtime.runIfWaitingForDebugger`
  to run paused targets.
  - (Optional) `filter`: Only targets matching filter will be attached.
  """
  @spec auto_attach_related(
          CDPotion.Domain.Target.TargetID,
          boolean(),
          CDPotion.Domain.Target.TargetFilter
        ) :: {String.t(), map()}
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
    - (Required) `discover`: Whether to discover available targets.
  - (Optional) `filter`: Only targets matching filter will be attached. If `discover` is false,
  `filter` must be omitted or empty.
  """
  @spec set_discover_targets(boolean(), CDPotion.Domain.Target.TargetFilter) ::
          {String.t(), map()}
  def set_discover_targets(discover, filter \\ nil) do
    params = as_query([{"discover", discover}, {"filter", filter}])
    {"Target.setDiscoverTargets", params}
  end

  @doc """
  Enables target discovery for the specified locations, when `setDiscoverTargets` was set to
  `true`.
  ## Parameters:
    - (Required) `locations`: List of remote locations.
  """
  @spec set_remote_locations(list(CDPotion.Domain.Target.RemoteLocation)) :: {String.t(), map()}
  def set_remote_locations(locations) do
    params = as_query([{"locations", locations}])
    {"Target.setRemoteLocations", params}
  end
end
