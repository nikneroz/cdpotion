defmodule CDPotion.Domain.HeadlessExperimental do

@doc """
Sends a BeginFrame to the target and returns when the frame was completed. Optionally captures a
screenshot from the resulting frame. Requires that the target was created with enabled
BeginFrameControl. Designed for use with --run-all-compositor-stages-before-draw, see also
https://goo.gle/chrome-headless-rendering for more background.
## Parameters:
- `frameTimeTicks:number`: (Optional) Timestamp of this BeginFrame in Renderer TimeTicks (milliseconds of uptime). If not set,
the current time will be used.
  - `interval:number`: (Optional) The interval between BeginFrames that is reported to the compositor, in milliseconds.
Defaults to a 60 frames/second interval, i.e. about 16.666 milliseconds.
  - `noDisplayUpdates:boolean`: (Optional) Whether updates should not be committed and drawn onto the display. False by default. If
true, only side effects of the BeginFrame will be run, such as layout and animations, but
any visual updates may not be visible on the display or in screenshots.
  - `screenshot:ScreenshotParams`: (Optional) If set, a screenshot of the frame will be captured and returned in the response. Otherwise,
no screenshot will be captured. Note that capturing a screenshot can fail, for example,
during renderer initialization. In such a case, no screenshot data will be returned.
"""
def begin_frame(
      frame_time_ticks \\ nil,
      interval \\ nil,
      no_display_updates \\ nil,
      screenshot \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables headless events for the target.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables headless events for the target.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end
end