defmodule CDPotion.Domain.PerformanceTimeline do
  use CDPotion.Utils

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
