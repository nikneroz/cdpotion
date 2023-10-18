defmodule CDPotion.Domain.Browser do

@doc """
Set permission settings for given origin.
## Parameters:
- `permission:PermissionDescriptor`: Descriptor of permission to override.
  - `setting:PermissionSetting`: Setting of the permission.
  - `origin:string`: (Optional) Origin the permission applies to, all origins if not specified.
  - `browserContextId:BrowserContextID`: (Optional) Context to override. When omitted, default browser context is used.
"""
def set_permission(permission, setting, origin \\ nil, browser_context_id \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Grant specific permissions to the given origin and reject all others.
## Parameters:
- `permissions:array`: description not provided :(
  - `origin:string`: (Optional) Origin the permission applies to, all origins if not specified.
  - `browserContextId:BrowserContextID`: (Optional) BrowserContext to override permissions. When omitted, default browser context is used.
"""
def grant_permissions(permissions, origin \\ nil, browser_context_id \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Reset all permission management for all origins.
## Parameters:
- `browserContextId:BrowserContextID`: (Optional) BrowserContext to reset permissions. When omitted, default browser context is used.
"""
def reset_permissions(browser_context_id \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Set the behavior when downloading a file.
## Parameters:
- `behavior:string`: Whether to allow all or deny all download requests, or use default Chrome behavior if
available (otherwise deny). |allowAndName| allows download and names files according to
their dowmload guids.
  - `browserContextId:BrowserContextID`: (Optional) BrowserContext to set download behavior. When omitted, default browser context is used.
  - `downloadPath:string`: (Optional) The default path to save downloaded files to. This is required if behavior is set to 'allow'
or 'allowAndName'.
  - `eventsEnabled:boolean`: (Optional) Whether to emit download events (defaults to false).
"""
def set_download_behavior(
      behavior,
      browser_context_id \\ nil,
      download_path \\ nil,
      events_enabled \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Cancel a download if in progress
## Parameters:
- `guid:string`: Global unique identifier of the download.
  - `browserContextId:BrowserContextID`: (Optional) BrowserContext to perform the action in. When omitted, default browser context is used.
"""
def cancel_download(guid, browser_context_id \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Close browser gracefully.
"""
def close() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Crashes browser on the main thread.
"""
def crash() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Crashes GPU process.
"""
def crash_gpu_process() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns version information.
"""
def get_version() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns the command line switches for the browser process if, and only if
--enable-automation is on the commandline.
"""
def get_browser_command_line() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Get Chrome histograms.
## Parameters:
- `query:string`: (Optional) Requested substring in name. Only histograms which have query as a
substring in their name are extracted. An empty or absent query returns
all histograms.
  - `delta:boolean`: (Optional) If true, retrieve delta since last delta call.
"""
def get_histograms(query \\ nil, delta \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Get a Chrome histogram by name.
## Parameters:
- `name:string`: Requested histogram name.
  - `delta:boolean`: (Optional) If true, retrieve delta since last delta call.
"""
def get_histogram(name, delta \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Get position and size of the browser window.
## Parameters:
- `windowId:WindowID`: Browser window id.
"""
def get_window_bounds(window_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Get the browser window that contains the devtools target.
## Parameters:
- `targetId:Target.TargetID`: (Optional) Devtools agent host id. If called as a part of the session, associated targetId is used.
"""
def get_window_for_target(target_id \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Set position and/or size of the browser window.
## Parameters:
- `windowId:WindowID`: Browser window id.
  - `bounds:Bounds`: New window bounds. The 'minimized', 'maximized' and 'fullscreen' states cannot be combined
with 'left', 'top', 'width' or 'height'. Leaves unspecified fields unchanged.
"""
def set_window_bounds(window_id, bounds) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Set dock tile details, platform-specific.
## Parameters:
- `badgeLabel:string`: (Optional) description not provided :(
  - `image:string`: (Optional) Png encoded image. (Encoded as a base64 string when passed over JSON)
"""
def set_dock_tile(badge_label \\ nil, image \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Invoke custom browser commands used by telemetry.
## Parameters:
- `commandId:BrowserCommandId`: description not provided :(
"""
def execute_browser_command(command_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Allows a site to use privacy sandbox features that require enrollment
without the site actually being enrolled. Only supported on page targets.
## Parameters:
- `url:string`: description not provided :(
"""
def add_privacy_sandbox_enrollment_override(url) do
  execute(session, :navigate, %{"url" => url})
end
end