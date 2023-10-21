defmodule CDPotion.Domain.HeadlessExperimental do
  use CDPotion.Utils
  @typedoc "Encoding options for a screenshot."
  @type screenshot_params :: %{
          format: :jpeg | :png | :webp | nil,
          optimizeForSpeed: boolean() | nil,
          quality: integer() | nil
        }

  @doc """
  Sends a BeginFrame to the target and returns when the frame was completed. Optionally captures a
  screenshot from the resulting frame. Requires that the target was created with enabled
  BeginFrameControl. Designed for use with --run-all-compositor-stages-before-draw, see also
  https://goo.gle/chrome-headless-rendering for more background.
  ## Parameters:
    - (Optional) `frame_time_ticks`: Timestamp of this BeginFrame in Renderer TimeTicks (milliseconds of uptime). If not set,
  the current time will be used.
  - (Optional) `interval`: The interval between BeginFrames that is reported to the compositor, in milliseconds.
  Defaults to a 60 frames/second interval, i.e. about 16.666 milliseconds.
  - (Optional) `no_display_updates`: Whether updates should not be committed and drawn onto the display. False by default. If
  true, only side effects of the BeginFrame will be run, such as layout and animations, but
  any visual updates may not be visible on the display or in screenshots.
  - (Optional) `screenshot`: If set, a screenshot of the frame will be captured and returned in the response. Otherwise,
  no screenshot will be captured. Note that capturing a screenshot can fail, for example,
  during renderer initialization. In such a case, no screenshot data will be returned.
  """
  @spec begin_frame(
          number(),
          number(),
          boolean(),
          CDPotion.Domain.HeadlessExperimental.ScreenshotParams
        ) :: {String.t(), map()}
  def begin_frame(
        frame_time_ticks \\ nil,
        interval \\ nil,
        no_display_updates \\ nil,
        screenshot \\ nil
      ) do
    params =
      as_query([
        {"frameTimeTicks", frame_time_ticks},
        {"interval", interval},
        {"noDisplayUpdates", no_display_updates},
        {"screenshot", screenshot}
      ])

    {"HeadlessExperimental.beginFrame", params}
  end

  @doc """
  Disables headless events for the target.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"HeadlessExperimental.disable", %{}}
  end

  @doc """
  Enables headless events for the target.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"HeadlessExperimental.enable", %{}}
  end
end
