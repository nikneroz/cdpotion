defmodule CDPotion.Domain.PerformanceTimeline do
  use CDPotion.Utils
  @doc "See https://github.com/WICG/LargestContentfulPaint and largest_contentful_paint.idl"
  @type LargestContentfulPaint :: %{
          elementId: String.t() | nil,
          loadTime: Network.TimeSinceEpoch,
          nodeId: DOM.BackendNodeId | nil,
          renderTime: Network.TimeSinceEpoch,
          size: number(),
          url: String.t() | nil
        }

  @doc "See https://wicg.github.io/layout-instability/#sec-layout-shift and layout_shift.idl"
  @type LayoutShift :: %{
          hadRecentInput: boolean(),
          lastInputTime: Network.TimeSinceEpoch,
          sources: list(PerformanceTimeline.LayoutShiftAttribution),
          value: number()
        }

  @doc "description not provided :("
  @type LayoutShiftAttribution :: %{
          currentRect: DOM.Rect,
          nodeId: DOM.BackendNodeId | nil,
          previousRect: DOM.Rect
        }

  @doc "description not provided :("
  @type TimelineEvent :: %{
          duration: number() | nil,
          frameId: Page.FrameId,
          layoutShiftDetails: PerformanceTimeline.LayoutShift | nil,
          lcpDetails: PerformanceTimeline.LargestContentfulPaint | nil,
          name: String.t(),
          time: Network.TimeSinceEpoch,
          type: String.t()
        }

  @doc """
  Previously buffered events would be reported before method returns.
  See also: timelineEventAdded
  ## Parameters:
    - `eventTypes:array`: The types of event to report, as specified in
  https://w3c.github.io/performance-timeline/#dom-performanceentry-entrytype
  The specified filter overrides any previous filters, passing empty
  filter disables recording.
  Note that not all types exposed to the web platform are currently supported.
  """
  def enable(event_types) do
    params = as_query([{"eventTypes", event_types}])
    {"PerformanceTimeline.enable", params}
  end
end
