defmodule CDPotion.Domain.Emulation do
  use CDPotion.Utils
  @typedoc "Enum of image types that can be disabled."
  @type disabled_image_type :: :avif | :webp

  @typedoc "description not provided :("
  @type display_feature :: %{
          maskLength: integer(),
          offset: integer(),
          orientation: :vertical | :horizontal
        }

  @typedoc "description not provided :("
  @type media_feature :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "Screen orientation."
  @type screen_orientation :: %{
          angle: integer(),
          type: :portraitPrimary | :portraitSecondary | :landscapePrimary | :landscapeSecondary
        }

  @typedoc "Used to specify User Agent Cient Hints to emulate. See https://wicg.github.io/ua-client-hints"
  @type user_agent_brand_version :: %{
          brand: String.t(),
          version: String.t()
        }

  @typedoc "Used to specify User Agent Cient Hints to emulate. See https://wicg.github.io/ua-client-hints
Missing optional values will be filled in by the target with what it would normally use."
  @type user_agent_metadata :: %{
          architecture: String.t(),
          bitness: String.t() | nil,
          brands: list(CDPotion.Domain.Emulation.user_agent_brand_version()) | nil,
          fullVersion: String.t() | nil,
          fullVersionList: list(CDPotion.Domain.Emulation.user_agent_brand_version()) | nil,
          mobile: boolean(),
          model: String.t(),
          platform: String.t(),
          platformVersion: String.t(),
          wow64: boolean() | nil
        }

  @typedoc "advance: If the scheduler runs out of immediate work, the virtual time base may fast forward to
allow the next delayed task (if any) to run; pause: The virtual time base may not advance;
pauseIfNetworkFetchesPending: The virtual time base may not advance if there are any pending
resource fetches."
  @type virtual_time_policy :: :advance | :pause | :pauseIfNetworkFetchesPending

  @doc """
  Tells whether emulation is supported.
  """
  @spec can_emulate() :: {String.t(), map()}
  def can_emulate() do
    {"Emulation.canEmulate", %{}}
  end

  @doc """
  Clears the overridden device metrics.
  """
  @spec clear_device_metrics_override() :: {String.t(), map()}
  def clear_device_metrics_override() do
    {"Emulation.clearDeviceMetricsOverride", %{}}
  end

  @doc """
  Clears the overridden Geolocation Position and Error.
  """
  @spec clear_geolocation_override() :: {String.t(), map()}
  def clear_geolocation_override() do
    {"Emulation.clearGeolocationOverride", %{}}
  end

  @doc """
  Requests that page scale factor is reset to initial values.
  """
  @spec reset_page_scale_factor() :: {String.t(), map()}
  def reset_page_scale_factor() do
    {"Emulation.resetPageScaleFactor", %{}}
  end

  @doc """
  Enables or disables simulating a focused and active page.
  ## Parameters:
    - (Required) `enabled`: Whether to enable to disable focus emulation.
  """
  @spec set_focus_emulation_enabled(boolean()) :: {String.t(), map()}
  def set_focus_emulation_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setFocusEmulationEnabled", params}
  end

  @doc """
  Automatically render all web contents using a dark theme.
  ## Parameters:
    - (Optional) `enabled`: Whether to enable or disable automatic dark mode.
  If not specified, any existing override will be cleared.
  """
  @spec set_auto_dark_mode_override(boolean()) :: {String.t(), map()}
  def set_auto_dark_mode_override(enabled \\ nil) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setAutoDarkModeOverride", params}
  end

  @doc """
  Enables CPU throttling to emulate slow CPUs.
  ## Parameters:
    - (Required) `rate`: Throttling rate as a slowdown factor (1 is no throttle, 2 is 2x slowdown, etc).
  """
  @spec set_cpu_throttling_rate(number()) :: {String.t(), map()}
  def set_cpu_throttling_rate(rate) do
    params = as_query([{"rate", rate}])
    {"Emulation.setCPUThrottlingRate", params}
  end

  @doc """
  Sets or clears an override of the default background color of the frame. This override is used
  if the content does not specify one.
  ## Parameters:
    - (Optional) `color`: RGBA of the default background color. If not specified, any existing override will be
  cleared.
  """
  @spec set_default_background_color_override(CDPotion.Domain.DOM.RGBA) :: {String.t(), map()}
  def set_default_background_color_override(color \\ nil) do
    params = as_query([{"color", color}])
    {"Emulation.setDefaultBackgroundColorOverride", params}
  end

  @doc """
  Overrides the values of device screen dimensions (window.screen.width, window.screen.height,
  window.innerWidth, window.innerHeight, and "device-width"/"device-height"-related CSS media
  query results).
  ## Parameters:
    - (Required) `width`: Overriding width value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  - (Required) `height`: Overriding height value in pixels (minimum 0, maximum 10000000). 0 disables the override.
  - (Required) `device_scale_factor`: Overriding device scale factor value. 0 disables the override.
  - (Required) `mobile`: Whether to emulate mobile device. This includes viewport meta tag, overlay scrollbars, text
  autosizing and more.
  - (Optional) `scale`: Scale to apply to resulting view image.
  - (Optional) `screen_width`: Overriding screen width value in pixels (minimum 0, maximum 10000000).
  - (Optional) `screen_height`: Overriding screen height value in pixels (minimum 0, maximum 10000000).
  - (Optional) `position_x`: Overriding view X position on screen in pixels (minimum 0, maximum 10000000).
  - (Optional) `position_y`: Overriding view Y position on screen in pixels (minimum 0, maximum 10000000).
  - (Optional) `dont_set_visible_size`: Do not set visible view size, rely upon explicit setVisibleSize call.
  - (Optional) `screen_orientation`: Screen orientation override.
  - (Optional) `viewport`: If set, the visible area of the page will be overridden to this viewport. This viewport
  change is not observed by the page, e.g. viewport-relative elements do not change positions.
  - (Optional) `display_feature`: If set, the display feature of a multi-segment screen. If not set, multi-segment support
  is turned-off.
  """
  @spec set_device_metrics_override(
          integer(),
          integer(),
          number(),
          boolean(),
          number(),
          integer(),
          integer(),
          integer(),
          integer(),
          boolean(),
          CDPotion.Domain.Emulation.ScreenOrientation,
          CDPotion.Domain.Page.Viewport,
          CDPotion.Domain.Emulation.DisplayFeature
        ) :: {String.t(), map()}
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
    - (Required) `hidden`: Whether scrollbars should be always hidden.
  """
  @spec set_scrollbars_hidden(boolean()) :: {String.t(), map()}
  def set_scrollbars_hidden(hidden) do
    params = as_query([{"hidden", hidden}])
    {"Emulation.setScrollbarsHidden", params}
  end

  @doc """

  ## Parameters:
    - (Required) `disabled`: Whether document.coookie API should be disabled.
  """
  @spec set_document_cookie_disabled(boolean()) :: {String.t(), map()}
  def set_document_cookie_disabled(disabled) do
    params = as_query([{"disabled", disabled}])
    {"Emulation.setDocumentCookieDisabled", params}
  end

  @doc """

  ## Parameters:
    - (Required) `enabled`: Whether touch emulation based on mouse input should be enabled.
  - (Optional) `configuration`: Touch/gesture events configuration. Default: current platform.
  """
  @spec set_emit_touch_events_for_mouse(boolean(), String.t()) :: {String.t(), map()}
  def set_emit_touch_events_for_mouse(enabled, configuration \\ nil) do
    params = as_query([{"enabled", enabled}, {"configuration", configuration}])
    {"Emulation.setEmitTouchEventsForMouse", params}
  end

  @doc """
  Emulates the given media type or media feature for CSS media queries.
  ## Parameters:
    - (Optional) `media`: Media type to emulate. Empty string disables the override.
  - (Optional) `features`: Media features to emulate.
  """
  @spec set_emulated_media(String.t(), list(CDPotion.Domain.Emulation.MediaFeature)) ::
          {String.t(), map()}
  def set_emulated_media(media \\ nil, features \\ nil) do
    params = as_query([{"media", media}, {"features", features}])
    {"Emulation.setEmulatedMedia", params}
  end

  @doc """
  Emulates the given vision deficiency.
  ## Parameters:
    - (Required) `type`: Vision deficiency to emulate. Order: best-effort emulations come first, followed by any
  physiologically accurate emulations for medically recognized color vision deficiencies.
  """
  @spec set_emulated_vision_deficiency(String.t()) :: {String.t(), map()}
  def set_emulated_vision_deficiency(type) do
    params = as_query([{"type", type}])
    {"Emulation.setEmulatedVisionDeficiency", params}
  end

  @doc """
  Overrides the Geolocation Position or Error. Omitting any of the parameters emulates position
  unavailable.
  ## Parameters:
    - (Optional) `latitude`: Mock latitude
  - (Optional) `longitude`: Mock longitude
  - (Optional) `accuracy`: Mock accuracy
  """
  @spec set_geolocation_override(number(), number(), number()) :: {String.t(), map()}
  def set_geolocation_override(latitude \\ nil, longitude \\ nil, accuracy \\ nil) do
    params = as_query([{"latitude", latitude}, {"longitude", longitude}, {"accuracy", accuracy}])
    {"Emulation.setGeolocationOverride", params}
  end

  @doc """
  Overrides the Idle state.
  ## Parameters:
    - (Required) `is_user_active`: Mock isUserActive
  - (Required) `is_screen_unlocked`: Mock isScreenUnlocked
  """
  @spec set_idle_override(boolean(), boolean()) :: {String.t(), map()}
  def set_idle_override(is_user_active, is_screen_unlocked) do
    params =
      as_query([{"isUserActive", is_user_active}, {"isScreenUnlocked", is_screen_unlocked}])

    {"Emulation.setIdleOverride", params}
  end

  @doc """
  Clears Idle state overrides.
  """
  @spec clear_idle_override() :: {String.t(), map()}
  def clear_idle_override() do
    {"Emulation.clearIdleOverride", %{}}
  end

  @doc """
  Overrides value returned by the javascript navigator object.
  ## Parameters:
    - (Required) `platform`: The platform navigator.platform should return.
  """
  @spec set_navigator_overrides(String.t()) :: {String.t(), map()}
  def set_navigator_overrides(platform) do
    params = as_query([{"platform", platform}])
    {"Emulation.setNavigatorOverrides", params}
  end

  @doc """
  Sets a specified page scale factor.
  ## Parameters:
    - (Required) `page_scale_factor`: Page scale factor.
  """
  @spec set_page_scale_factor(number()) :: {String.t(), map()}
  def set_page_scale_factor(page_scale_factor) do
    params = as_query([{"pageScaleFactor", page_scale_factor}])
    {"Emulation.setPageScaleFactor", params}
  end

  @doc """
  Switches script execution in the page.
  ## Parameters:
    - (Required) `value`: Whether script execution should be disabled in the page.
  """
  @spec set_script_execution_disabled(boolean()) :: {String.t(), map()}
  def set_script_execution_disabled(value) do
    params = as_query([{"value", value}])
    {"Emulation.setScriptExecutionDisabled", params}
  end

  @doc """
  Enables touch on platforms which do not support them.
  ## Parameters:
    - (Required) `enabled`: Whether the touch event emulation should be enabled.
  - (Optional) `max_touch_points`: Maximum touch points supported. Defaults to one.
  """
  @spec set_touch_emulation_enabled(boolean(), integer()) :: {String.t(), map()}
  def set_touch_emulation_enabled(enabled, max_touch_points \\ nil) do
    params = as_query([{"enabled", enabled}, {"maxTouchPoints", max_touch_points}])
    {"Emulation.setTouchEmulationEnabled", params}
  end

  @doc """
  Turns on virtual time for all frames (replacing real-time with a synthetic time source) and sets
  the current virtual time policy.  Note this supersedes any previous time budget.
  ## Parameters:
    - (Required) `policy`: description not provided :(
  - (Optional) `budget`: If set, after this many virtual milliseconds have elapsed virtual time will be paused and a
  virtualTimeBudgetExpired event is sent.
  - (Optional) `max_virtual_time_task_starvation_count`: If set this specifies the maximum number of tasks that can be run before virtual is forced
  forwards to prevent deadlock.
  - (Optional) `initial_virtual_time`: If set, base::Time::Now will be overridden to initially return this value.
  """
  @spec set_virtual_time_policy(
          CDPotion.Domain.Emulation.VirtualTimePolicy,
          number(),
          integer(),
          CDPotion.Domain.Network.TimeSinceEpoch
        ) :: {String.t(), map()}
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
    - (Optional) `locale`: ICU style C locale (e.g. "en_US"). If not specified or empty, disables the override and
  restores default host system locale.
  """
  @spec set_locale_override(String.t()) :: {String.t(), map()}
  def set_locale_override(locale \\ nil) do
    params = as_query([{"locale", locale}])
    {"Emulation.setLocaleOverride", params}
  end

  @doc """
  Overrides default host system timezone with the specified one.
  ## Parameters:
    - (Required) `timezone_id`: The timezone identifier. If empty, disables the override and
  restores default host system timezone.
  """
  @spec set_timezone_override(String.t()) :: {String.t(), map()}
  def set_timezone_override(timezone_id) do
    params = as_query([{"timezoneId", timezone_id}])
    {"Emulation.setTimezoneOverride", params}
  end

  @doc """
  Resizes the frame/viewport of the page. Note that this does not affect the frame's container
  (e.g. browser window). Can be used to produce screenshots of the specified size. Not supported
  on Android.
  ## Parameters:
    - (Required) `width`: Frame width (DIP).
  - (Required) `height`: Frame height (DIP).
  """
  @spec set_visible_size(integer(), integer()) :: {String.t(), map()}
  def set_visible_size(width, height) do
    params = as_query([{"width", width}, {"height", height}])
    {"Emulation.setVisibleSize", params}
  end

  @doc """

  ## Parameters:
    - (Required) `image_types`: Image types to disable.
  """
  @spec set_disabled_image_types(list(CDPotion.Domain.Emulation.DisabledImageType)) ::
          {String.t(), map()}
  def set_disabled_image_types(image_types) do
    params = as_query([{"imageTypes", image_types}])
    {"Emulation.setDisabledImageTypes", params}
  end

  @doc """

  ## Parameters:
    - (Required) `hardware_concurrency`: Hardware concurrency to report
  """
  @spec set_hardware_concurrency_override(integer()) :: {String.t(), map()}
  def set_hardware_concurrency_override(hardware_concurrency) do
    params = as_query([{"hardwareConcurrency", hardware_concurrency}])
    {"Emulation.setHardwareConcurrencyOverride", params}
  end

  @doc """
  Allows overriding user agent with the given string.
  ## Parameters:
    - (Required) `user_agent`: User agent to use.
  - (Optional) `accept_language`: Browser langugage to emulate.
  - (Optional) `platform`: The platform navigator.platform should return.
  - (Optional) `user_agent_metadata`: To be sent in Sec-CH-UA-* headers and returned in navigator.userAgentData
  """
  @spec set_user_agent_override(
          String.t(),
          String.t(),
          String.t(),
          CDPotion.Domain.Emulation.UserAgentMetadata
        ) :: {String.t(), map()}
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
    - (Required) `enabled`: Whether the override should be enabled.
  """
  @spec set_automation_override(boolean()) :: {String.t(), map()}
  def set_automation_override(enabled) do
    params = as_query([{"enabled", enabled}])
    {"Emulation.setAutomationOverride", params}
  end
end
