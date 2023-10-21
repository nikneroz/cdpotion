defmodule CDPotion.Domain.PerformanceTimeline do
  use CDPotion.Utils
  @typedoc "See https://github.com/WICG/LargestContentfulPaint and largest_contentful_paint.idl"
  @type largest_contentful_paint :: %{
          elementId: String.t() | nil,
          loadTime: CDPotion.Domain.Network.time_since_epoch(),
          nodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          renderTime: CDPotion.Domain.Network.time_since_epoch(),
          size: number(),
          url: String.t() | nil
        }

  @typedoc "See https://wicg.github.io/layout-instability/#sec-layout-shift and layout_shift.idl"
  @type layout_shift :: %{
          hadRecentInput: boolean(),
          lastInputTime: CDPotion.Domain.Network.time_since_epoch(),
          sources: list(CDPotion.Domain.PerformanceTimeline.layout_shift_attribution()),
          value: number()
        }

  @typedoc "description not provided :("
  @type layout_shift_attribution :: %{
          currentRect: CDPotion.Domain.DOM.rect(),
          nodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          previousRect: CDPotion.Domain.DOM.rect()
        }

  @typedoc "description not provided :("
  @type timeline_event :: %{
          duration: number() | nil,
          frameId: CDPotion.Domain.Page.frame_id(),
          layoutShiftDetails: CDPotion.Domain.PerformanceTimeline.layout_shift() | nil,
          lcpDetails: CDPotion.Domain.PerformanceTimeline.largest_contentful_paint() | nil,
          name: String.t(),
          time: CDPotion.Domain.Network.time_since_epoch(),
          type: String.t()
        }

  @doc """
  Previously buffered events would be reported before method returns.
  See also: timelineEventAdded
  ## Parameters:
    - (Required) `event_types`: The types of event to report, as specified in
  https://w3c.github.io/performance-timeline/#dom-performanceentry-entrytype
  The specified filter overrides any previous filters, passing empty
  filter disables recording.
  Note that not all types exposed to the web platform are currently supported.
  """
  @spec enable(list(String.t())) :: {String.t(), map()}
  def enable(event_types) do
    params = as_query([{"eventTypes", event_types}])
    {"PerformanceTimeline.enable", params}
  end
end
