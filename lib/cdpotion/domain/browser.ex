defmodule CDPotion.Domain.Browser do
  use CDPotion.Utils
  @typedoc "Browser window bounds information"
  @type bounds :: %{
          height: integer() | nil,
          left: integer() | nil,
          top: integer() | nil,
          width: integer() | nil,
          windowState: CDPotion.Domain.Browser.window_state() | nil
        }

  @typedoc "Browser command ids used by executeBrowserCommand."
  @type browser_command_id :: :openTabSearch | :closeTabSearch

  @typedoc "description not provided :("
  @type browser_context_id :: String.t()

  @typedoc "Chrome histogram bucket."
  @type bucket :: %{
          count: integer(),
          high: integer(),
          low: integer()
        }

  @typedoc "Chrome histogram."
  @type histogram :: %{
          buckets: list(CDPotion.Domain.Browser.bucket()),
          count: integer(),
          name: String.t(),
          sum: integer()
        }

  @typedoc "Definition of PermissionDescriptor defined in the Permissions API:
https://w3c.github.io/permissions/#dictdef-permissiondescriptor."
  @type permission_descriptor :: %{
          allowWithoutSanitization: boolean() | nil,
          name: String.t(),
          panTiltZoom: boolean() | nil,
          sysex: boolean() | nil,
          userVisibleOnly: boolean() | nil
        }

  @typedoc "description not provided :("
  @type permission_setting :: :granted | :denied | :prompt

  @typedoc "description not provided :("
  @type permission_type ::
          :accessibilityEvents
          | :audioCapture
          | :backgroundSync
          | :backgroundFetch
          | :clipboardReadWrite
          | :clipboardSanitizedWrite
          | :displayCapture
          | :durableStorage
          | :flash
          | :geolocation
          | :idleDetection
          | :localFonts
          | :midi
          | :midiSysex
          | :nfc
          | :notifications
          | :paymentHandler
          | :periodicBackgroundSync
          | :protectedMediaIdentifier
          | :sensors
          | :storageAccess
          | :topLevelStorageAccess
          | :videoCapture
          | :videoCapturePanTiltZoom
          | :wakeLockScreen
          | :wakeLockSystem
          | :windowManagement

  @typedoc "description not provided :("
  @type window_id :: integer()

  @typedoc "The state of the browser window."
  @type window_state :: :normal | :minimized | :maximized | :fullscreen

  @doc """
  Set permission settings for given origin.
  ## Parameters:
    - (Required) `permission`: Descriptor of permission to override.
  - (Required) `setting`: Setting of the permission.
  - (Optional) `origin`: Origin the permission applies to, all origins if not specified.
  - (Optional) `browser_context_id`: Context to override. When omitted, default browser context is used.
  """
  @spec set_permission(
          CDPotion.Domain.Browser.PermissionDescriptor,
          CDPotion.Domain.Browser.PermissionSetting,
          String.t(),
          CDPotion.Domain.Browser.BrowserContextID
        ) :: {String.t(), map()}
  def set_permission(permission, setting, origin \\ nil, browser_context_id \\ nil) do
    params =
      as_query([
        {"permission", permission},
        {"setting", setting},
        {"origin", origin},
        {"browserContextId", browser_context_id}
      ])

    {"Browser.setPermission", params}
  end

  @doc """
  Grant specific permissions to the given origin and reject all others.
  ## Parameters:
    - (Required) `permissions`: description not provided :(
  - (Optional) `origin`: Origin the permission applies to, all origins if not specified.
  - (Optional) `browser_context_id`: BrowserContext to override permissions. When omitted, default browser context is used.
  """
  @spec grant_permissions(
          list(CDPotion.Domain.Browser.PermissionType),
          String.t(),
          CDPotion.Domain.Browser.BrowserContextID
        ) :: {String.t(), map()}
  def grant_permissions(permissions, origin \\ nil, browser_context_id \\ nil) do
    params =
      as_query([
        {"permissions", permissions},
        {"origin", origin},
        {"browserContextId", browser_context_id}
      ])

    {"Browser.grantPermissions", params}
  end

  @doc """
  Reset all permission management for all origins.
  ## Parameters:
    - (Optional) `browser_context_id`: BrowserContext to reset permissions. When omitted, default browser context is used.
  """
  @spec reset_permissions(CDPotion.Domain.Browser.BrowserContextID) :: {String.t(), map()}
  def reset_permissions(browser_context_id \\ nil) do
    params = as_query([{"browserContextId", browser_context_id}])
    {"Browser.resetPermissions", params}
  end

  @doc """
  Set the behavior when downloading a file.
  ## Parameters:
    - (Required) `behavior`: Whether to allow all or deny all download requests, or use default Chrome behavior if
  available (otherwise deny). |allowAndName| allows download and names files according to
  their dowmload guids.
  - (Optional) `browser_context_id`: BrowserContext to set download behavior. When omitted, default browser context is used.
  - (Optional) `download_path`: The default path to save downloaded files to. This is required if behavior is set to 'allow'
  or 'allowAndName'.
  - (Optional) `events_enabled`: Whether to emit download events (defaults to false).
  """
  @spec set_download_behavior(
          String.t(),
          CDPotion.Domain.Browser.BrowserContextID,
          String.t(),
          boolean()
        ) :: {String.t(), map()}
  def set_download_behavior(
        behavior,
        browser_context_id \\ nil,
        download_path \\ nil,
        events_enabled \\ nil
      ) do
    params =
      as_query([
        {"behavior", behavior},
        {"browserContextId", browser_context_id},
        {"downloadPath", download_path},
        {"eventsEnabled", events_enabled}
      ])

    {"Browser.setDownloadBehavior", params}
  end

  @doc """
  Cancel a download if in progress
  ## Parameters:
    - (Required) `guid`: Global unique identifier of the download.
  - (Optional) `browser_context_id`: BrowserContext to perform the action in. When omitted, default browser context is used.
  """
  @spec cancel_download(String.t(), CDPotion.Domain.Browser.BrowserContextID) ::
          {String.t(), map()}
  def cancel_download(guid, browser_context_id \\ nil) do
    params = as_query([{"guid", guid}, {"browserContextId", browser_context_id}])
    {"Browser.cancelDownload", params}
  end

  @doc """
  Close browser gracefully.
  """
  @spec close() :: {String.t(), map()}
  def close() do
    {"Browser.close", %{}}
  end

  @doc """
  Crashes browser on the main thread.
  """
  @spec crash() :: {String.t(), map()}
  def crash() do
    {"Browser.crash", %{}}
  end

  @doc """
  Crashes GPU process.
  """
  @spec crash_gpu_process() :: {String.t(), map()}
  def crash_gpu_process() do
    {"Browser.crashGpuProcess", %{}}
  end

  @doc """
  Returns version information.
  """
  @spec get_version() :: {String.t(), map()}
  def get_version() do
    {"Browser.getVersion", %{}}
  end

  @doc """
  Returns the command line switches for the browser process if, and only if
  --enable-automation is on the commandline.
  """
  @spec get_browser_command_line() :: {String.t(), map()}
  def get_browser_command_line() do
    {"Browser.getBrowserCommandLine", %{}}
  end

  @doc """
  Get Chrome histograms.
  ## Parameters:
    - (Optional) `query`: Requested substring in name. Only histograms which have query as a
  substring in their name are extracted. An empty or absent query returns
  all histograms.
  - (Optional) `delta`: If true, retrieve delta since last delta call.
  """
  @spec get_histograms(String.t(), boolean()) :: {String.t(), map()}
  def get_histograms(query \\ nil, delta \\ nil) do
    params = as_query([{"query", query}, {"delta", delta}])
    {"Browser.getHistograms", params}
  end

  @doc """
  Get a Chrome histogram by name.
  ## Parameters:
    - (Required) `name`: Requested histogram name.
  - (Optional) `delta`: If true, retrieve delta since last delta call.
  """
  @spec get_histogram(String.t(), boolean()) :: {String.t(), map()}
  def get_histogram(name, delta \\ nil) do
    params = as_query([{"name", name}, {"delta", delta}])
    {"Browser.getHistogram", params}
  end

  @doc """
  Get position and size of the browser window.
  ## Parameters:
    - (Required) `window_id`: Browser window id.
  """
  @spec get_window_bounds(CDPotion.Domain.Browser.WindowID) :: {String.t(), map()}
  def get_window_bounds(window_id) do
    params = as_query([{"windowId", window_id}])
    {"Browser.getWindowBounds", params}
  end

  @doc """
  Get the browser window that contains the devtools target.
  ## Parameters:
    - (Optional) `target_id`: Devtools agent host id. If called as a part of the session, associated targetId is used.
  """
  @spec get_window_for_target(CDPotion.Domain.Target.TargetID) :: {String.t(), map()}
  def get_window_for_target(target_id \\ nil) do
    params = as_query([{"targetId", target_id}])
    {"Browser.getWindowForTarget", params}
  end

  @doc """
  Set position and/or size of the browser window.
  ## Parameters:
    - (Required) `window_id`: Browser window id.
  - (Required) `bounds`: New window bounds. The 'minimized', 'maximized' and 'fullscreen' states cannot be combined
  with 'left', 'top', 'width' or 'height'. Leaves unspecified fields unchanged.
  """
  @spec set_window_bounds(CDPotion.Domain.Browser.WindowID, CDPotion.Domain.Browser.Bounds) ::
          {String.t(), map()}
  def set_window_bounds(window_id, bounds) do
    params = as_query([{"windowId", window_id}, {"bounds", bounds}])
    {"Browser.setWindowBounds", params}
  end

  @doc """
  Set dock tile details, platform-specific.
  ## Parameters:
    - (Optional) `badge_label`: description not provided :(
  - (Optional) `image`: Png encoded image. (Encoded as a base64 string when passed over JSON)
  """
  @spec set_dock_tile(String.t(), String.t()) :: {String.t(), map()}
  def set_dock_tile(badge_label \\ nil, image \\ nil) do
    params = as_query([{"badgeLabel", badge_label}, {"image", image}])
    {"Browser.setDockTile", params}
  end

  @doc """
  Invoke custom browser commands used by telemetry.
  ## Parameters:
    - (Required) `command_id`: description not provided :(
  """
  @spec execute_browser_command(CDPotion.Domain.Browser.BrowserCommandId) :: {String.t(), map()}
  def execute_browser_command(command_id) do
    params = as_query([{"commandId", command_id}])
    {"Browser.executeBrowserCommand", params}
  end

  @doc """
  Allows a site to use privacy sandbox features that require enrollment
  without the site actually being enrolled. Only supported on page targets.
  ## Parameters:
    - (Required) `url`: description not provided :(
  """
  @spec add_privacy_sandbox_enrollment_override(String.t()) :: {String.t(), map()}
  def add_privacy_sandbox_enrollment_override(url) do
    params = as_query([{"url", url}])
    {"Browser.addPrivacySandboxEnrollmentOverride", params}
  end
end
