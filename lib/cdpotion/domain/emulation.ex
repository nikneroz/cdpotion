defmodule CDPotion.Domain.Emulation do
  use CDPotion.Utils

  @doc """
  Tells whether emulation is supported.
  """
  def can_emulate() do
    {"Emulation.canEmulate", %{}}
  end

  @doc """
  Clears the overridden device metrics.
  """
  def clear_device_metrics_override() do
    {"Emulation.clearDeviceMetricsOverride", %{}}
  end

  @doc """
  Clears the overridden Geolocation Position and Error.
  """
  def clear_geolocation_override() do
    {"Emulation.clearGeolocationOverride", %{}}
  end

  @doc """
  Requests that page scale factor is reset to initial values.
  """
  def reset_page_scale_factor() do
    {"Emulation.resetPageScaleFactor", %{}}
  end

  @doc """
  Enables or disables simulating a focused and active page.
  ## Parameters:
    - `enabled:boolean`: Whether to enable to disable focus emulation.
  """
  def set_focus_emulation_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setFocusEmulationEnabled", params}
  end

  @doc """
  Automatically render all web contents using a dark theme.
  ## Parameters:
    - `enabled:boolean`: (Optional) Whether to enable or disable automatic dark mode.
  If not specified, any existing override will be cleared.
  """
  def set_auto_dark_mode_override(enabled \\ nil) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setAutoDarkModeOverride", params}
  end

  @doc """
  Enables CPU throttling to emulate slow CPUs.
  ## Parameters:
    - `rate:number`: Throttling rate as a slowdown factor (1 is no throttle, 2 is 2x slowdown, etc).
  """
  def set_cpu_throttling_rate(rate) do
    params = as_query([{"rate", rate}])
    {"Emulation.setCPUThrottlingRate", params}
  end

  @doc """
  Sets or clears an override of the default background color of the frame. This override is used
  if the content does not specify one.
  ## Parameters:
    - `color:DOM.RGBA`: (Optional) RGBA of the default background color. If not specified, any existing override will be
  cleared.
  """
  def set_default_background_color_override(color \\ nil) do
    params = as_query([{"color", color}])
    {"Emulation.setDefaultBackgroundColorOverride", params}
  end

  @doc """
  Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  query results).
  ## Parameters:
    - `width:integer`: Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
    - `height:integer`: Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
    - `deviceScaleFactor:number`: Overriding device scale factor value. 0 disables the override.
    - `mobile:boolean`: Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  autosizing and more.
    - `scale:number`: (Optional) Scale to apply to resulting view image.
    - `screenWidth:integer`: (Optional) Overriding screen width value in pixels (minimum 0, maximum 10000000).
    - `screenHeight:integer`: (Optional) Overriding screen height value in pixels (minimum 0, maximum 10000000).
    - `positionX:integer`: (Optional) Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
    - `positionY:integer`: (Optional) Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
    - `dontSetVisibleSize:boolean`: (Optional) Do not set visible view size, rely upon explicit setVisibleSize call.
    - `screenOrientation:ScreenOrientation`: (Optional) Screen orientation override.
    - `viewport:Page.Viewport`: (Optional) If set, the visible area of the page will be overridden to this viewport. This viewport
  change is not observed by the page, e.g. viewport-relative elements do not change positions.
    - `displayFeature:DisplayFeature`: (Optional) If set, the display feature of a multi-segment screen. If not set, multi-segment support
  is turned-off.
  """
  def set_device_metrics_override(
        width,
        height,
        device_scale_factor,
        mobile,
        scale \\ nil,
        screen_width \\ nil,
        screen_height \\ nil,
        position_x \\ nil,
        position_y \\ nil,
        dont_set_visible_size \\ nil,
        screen_orientation \\ nil,
        viewport \\ nil,
        display_feature \\ nil
      ) do
    params =
      as_query([
        {"width", width},
        {"height", height},
        {"deviceScaleFactor", device_scale_factor},
        {"mobile", mobile},
        {"scale", scale},
        {"screenWidth", screen_width},
        {"screenHeight", screen_height},
        {"positionX", position_x},
        {"positionY", position_y},
        {"dontSetVisibleSize", dont_set_visible_size},
        {"screenOrientation", screen_orientation},
        {"viewport", viewport},
        {"displayFeature", display_feature}
      ])

    {"Emulation.setDeviceMetricsOverride", params}
  end

  @doc """
  ## Parameters:
    - `hidden:boolean`: Whether scrollbars should be always hidden.
  """
  def set_scrollbars_hidden(hidden) do
    params = as_query([{"hidden", hidden}])
    {"Emulation.setScrollbarsHidden", params}
  end

  @doc """
  ## Parameters:
    - `disabled:boolean`: Whether document.coookie API should be disabled.
  """
  def set_document_cookie_disabled(disabled) do
    params = as_query([{"disabled", disabled}])
    {"Emulation.setDocumentCookieDisabled", params}
  end

  @doc """
  ## Parameters:
    - `enabled:boolean`: Whether touch emulation based on mouse input should be enabled.
    - `configuration:string`: (Optional) Touch/gesture events configuration. Default: current platform.
  """
  def set_emit_touch_events_for_mouse(enabled, configuration \\ nil) do
    params = as_query([{"enabled", enabled}, {"configuration", configuration}])
    {"Emulation.setEmitTouchEventsForMouse", params}
  end

  @doc """
  Emulates the given media type or media feature for CSS media queries.
  ## Parameters:
    - `media:string`: (Optional) Media type to emulate. Empty string disables the override.
    - `features:array`: (Optional) Media features to emulate.
  """
  def set_emulated_media(media \\ nil, features \\ nil) do
    params = as_query([{"media", media}, {"features", features}])
    {"Emulation.setEmulatedMedia", params}
  end

  @doc """
  Emulates the given vision deficiency.
  ## Parameters:
    - `type:string`: Vision deficiency to emulate. Order: best-effort emulations come first, followed by any
  physiologically accurate emulations for medically recognized color vision deficiencies.
  """
  def set_emulated_vision_deficiency(type) do
    params = as_query([{"type", type}])
    {"Emulation.setEmulatedVisionDeficiency", params}
  end

  @doc """
  Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  unavailable.
  ## Parameters:
    - `latitude:number`: (Optional) Mock latitude
    - `longitude:number`: (Optional) Mock longitude
    - `accuracy:number`: (Optional) Mock accuracy
  """
  def set_geolocation_override(latitude \\ nil, longitude \\ nil, accuracy \\ nil) do
    params = as_query([{"latitude", latitude}, {"longitude", longitude}, {"accuracy", accuracy}])
    {"Emulation.setGeolocationOverride", params}
  end

  @doc """
  Overrides the Idle state.
  ## Parameters:
    - `isUserActive:boolean`: Mock isUserActive
    - `isScreenUnlocked:boolean`: Mock isScreenUnlocked
  """
  def set_idle_override(is_user_active, is_screen_unlocked) do
    params =
      as_query([{"isUserActive", is_user_active}, {"isScreenUnlocked", is_screen_unlocked}])

    {"Emulation.setIdleOverride", params}
  end

  @doc """
  Clears Idle state overrides.
  """
  def clear_idle_override() do
    {"Emulation.clearIdleOverride", %{}}
  end

  @doc """
  Overrides value returned by the javascript navigator object.
  ## Parameters:
    - `platform:string`: The platform navigator.platform should return.
  """
  def set_navigator_overrides(platform) do
    params = as_query([{"platform", platform}])
    {"Emulation.setNavigatorOverrides", params}
  end

  @doc """
  Sets a specified page scale factor.
  ## Parameters:
    - `pageScaleFactor:number`: Page scale factor.
  """
  def set_page_scale_factor(page_scale_factor) do
    params = as_query([{"pageScaleFactor", page_scale_factor}])
    {"Emulation.setPageScaleFactor", params}
  end

  @doc """
  Switches script execution in the page.
  ## Parameters:
    - `value:boolean`: Whether script execution should be disabled in the page.
  """
  def set_script_execution_disabled(value) do
    params = as_query([{"value", value}])
    {"Emulation.setScriptExecutionDisabled", params}
  end

  @doc """
  Enables touch on platforms which do not support them.
  ## Parameters:
    - `enabled:boolean`: Whether the touch event emulation should be enabled.
    - `maxTouchPoints:integer`: (Optional) Maximum touch points supported. Defaults to one.
  """
  def set_touch_emulation_enabled(enabled, max_touch_points \\ nil) do
    params = as_query([{"enabled", enabled}, {"maxTouchPoints", max_touch_points}])
    {"Emulation.setTouchEmulationEnabled", params}
  end

  @doc """
  Turns on virtual time for all frames (replacing real-time with a synthetic time source) and sets
  the current virtual time policy.  Note this supersedes any previous time budget.
  ## Parameters:
    - `policy:VirtualTimePolicy`: description not provided :(
    - `budget:number`: (Optional) If set, after this many virtual milliseconds have elapsed virtual time will be paused and a
  virtualTimeBudgetExpired event is sent.
    - `maxVirtualTimeTaskStarvationCount:integer`: (Optional) If set this specifies the maximum number of tasks that can be run before virtual is forced
  forwards to prevent deadlock.
    - `initialVirtualTime:Network.TimeSinceEpoch`: (Optional) If set, base::Time::Now will be overridden to initially return this value.
  """
  def set_virtual_time_policy(
        policy,
        budget \\ nil,
        max_virtual_time_task_starvation_count \\ nil,
        initial_virtual_time \\ nil
      ) do
    params =
      as_query([
        {"policy", policy},
        {"budget", budget},
        {"maxVirtualTimeTaskStarvationCount", max_virtual_time_task_starvation_count},
        {"initialVirtualTime", initial_virtual_time}
      ])

    {"Emulation.setVirtualTimePolicy", params}
  end

  @doc """
  Overrides default host system locale with the specified one.
  ## Parameters:
    - `locale:string`: (Optional) ICU style C locale (e.g. "en_US"). If not specified or empty, disables the override and
  restores default host system locale.
  """
  def set_locale_override(locale \\ nil) do
    params = as_query([{"locale", locale}])
    {"Emulation.setLocaleOverride", params}
  end

  @doc """
  Overrides default host system timezone with the specified one.
  ## Parameters:
    - `timezoneId:string`: The timezone identifier. If empty, disables the override and
  restores default host system timezone.
  """
  def set_timezone_override(timezone_id) do
    params = as_query([{"timezoneId", timezone_id}])
    {"Emulation.setTimezoneOverride", params}
  end

  @doc """
  Resizes the frame/viewport of the page. Note that this does not affect the frame's container
  (e.g. browser window). Can be used to produce screenshots of the specified size. Not supported
  on Android.
  ## Parameters:
    - `width:integer`: Frame width (DIP).
    - `height:integer`: Frame height (DIP).
  """
  def set_visible_size(width, height) do
    params = as_query([{"width", width}, {"height", height}])
    {"Emulation.setVisibleSize", params}
  end

  @doc """
  ## Parameters:
    - `imageTypes:array`: Image types to disable.
  """
  def set_disabled_image_types(image_types) do
    params = as_query([{"imageTypes", image_types}])
    {"Emulation.setDisabledImageTypes", params}
  end

  @doc """
  ## Parameters:
    - `hardwareConcurrency:integer`: Hardware concurrency to report
  """
  def set_hardware_concurrency_override(hardware_concurrency) do
    params = as_query([{"hardwareConcurrency", hardware_concurrency}])
    {"Emulation.setHardwareConcurrencyOverride", params}
  end

  @doc """
  Allows overriding user agent with the given string.
  ## Parameters:
    - `userAgent:string`: User agent to use.
    - `acceptLanguage:string`: (Optional) Browser langugage to emulate.
    - `platform:string`: (Optional) The platform navigator.platform should return.
    - `userAgentMetadata:UserAgentMetadata`: (Optional) To be sent in Sec-CH-UA-* headers and returned in navigator.userAgentData
  """
  def set_user_agent_override(
        user_agent,
        accept_language \\ nil,
        platform \\ nil,
        user_agent_metadata \\ nil
      ) do
    params =
      as_query([
        {"userAgent", user_agent},
        {"acceptLanguage", accept_language},
        {"platform", platform},
        {"userAgentMetadata", user_agent_metadata}
      ])

    {"Emulation.setUserAgentOverride", params}
  end

  @doc """
  Allows overriding the automation flag.
  ## Parameters:
    - `enabled:boolean`: Whether the override should be enabled.
  """
  def set_automation_override(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setAutomationOverride", params}
  end
end
