defmodule CDPotion.Domain.Overlay do
  use CDPotion.Utils
  @typedoc "Style information for drawing a box."
  @type box_style :: %{
          fillColor: CDPotion.Domain.DOM.rgba() | nil,
          hatchColor: CDPotion.Domain.DOM.rgba() | nil
        }

  @typedoc "description not provided :("
  @type color_format :: :rgb | :hsl | :hwb | :hex

  @typedoc "description not provided :("
  @type container_query_container_highlight_config :: %{
          containerBorder: CDPotion.Domain.Overlay.line_style() | nil,
          descendantBorder: CDPotion.Domain.Overlay.line_style() | nil
        }

  @typedoc "description not provided :("
  @type container_query_highlight_config :: %{
          containerQueryContainerHighlightConfig:
            CDPotion.Domain.Overlay.container_query_container_highlight_config(),
          nodeId: CDPotion.Domain.DOM.node_id()
        }

  @typedoc "description not provided :("
  @type contrast_algorithm :: :aa | :aaa | :apca

  @typedoc "Configuration data for the highlighting of Flex container elements."
  @type flex_container_highlight_config :: %{
          columnGapSpace: CDPotion.Domain.Overlay.box_style() | nil,
          containerBorder: CDPotion.Domain.Overlay.line_style() | nil,
          crossAlignment: CDPotion.Domain.Overlay.line_style() | nil,
          crossDistributedSpace: CDPotion.Domain.Overlay.box_style() | nil,
          itemSeparator: CDPotion.Domain.Overlay.line_style() | nil,
          lineSeparator: CDPotion.Domain.Overlay.line_style() | nil,
          mainDistributedSpace: CDPotion.Domain.Overlay.box_style() | nil,
          rowGapSpace: CDPotion.Domain.Overlay.box_style() | nil
        }

  @typedoc "Configuration data for the highlighting of Flex item elements."
  @type flex_item_highlight_config :: %{
          baseSizeBorder: CDPotion.Domain.Overlay.line_style() | nil,
          baseSizeBox: CDPotion.Domain.Overlay.box_style() | nil,
          flexibilityArrow: CDPotion.Domain.Overlay.line_style() | nil
        }

  @typedoc "description not provided :("
  @type flex_node_highlight_config :: %{
          flexContainerHighlightConfig: CDPotion.Domain.Overlay.flex_container_highlight_config(),
          nodeId: CDPotion.Domain.DOM.node_id()
        }

  @typedoc "Configuration data for the highlighting of Grid elements."
  @type grid_highlight_config :: %{
          areaBorderColor: CDPotion.Domain.DOM.rgba() | nil,
          cellBorderColor: CDPotion.Domain.DOM.rgba() | nil,
          cellBorderDash: boolean() | nil,
          columnGapColor: CDPotion.Domain.DOM.rgba() | nil,
          columnHatchColor: CDPotion.Domain.DOM.rgba() | nil,
          columnLineColor: CDPotion.Domain.DOM.rgba() | nil,
          columnLineDash: boolean() | nil,
          gridBackgroundColor: CDPotion.Domain.DOM.rgba() | nil,
          gridBorderColor: CDPotion.Domain.DOM.rgba() | nil,
          gridBorderDash: boolean() | nil,
          rowGapColor: CDPotion.Domain.DOM.rgba() | nil,
          rowHatchColor: CDPotion.Domain.DOM.rgba() | nil,
          rowLineColor: CDPotion.Domain.DOM.rgba() | nil,
          rowLineDash: boolean() | nil,
          showAreaNames: boolean() | nil,
          showGridExtensionLines: boolean() | nil,
          showLineNames: boolean() | nil,
          showNegativeLineNumbers: boolean() | nil,
          showPositiveLineNumbers: boolean() | nil,
          showTrackSizes: boolean() | nil
        }

  @typedoc "Configurations for Persistent Grid Highlight"
  @type grid_node_highlight_config :: %{
          gridHighlightConfig: CDPotion.Domain.Overlay.grid_highlight_config(),
          nodeId: CDPotion.Domain.DOM.node_id()
        }

  @typedoc "Configuration data for the highlighting of page elements."
  @type highlight_config :: %{
          borderColor: CDPotion.Domain.DOM.rgba() | nil,
          colorFormat: CDPotion.Domain.Overlay.color_format() | nil,
          containerQueryContainerHighlightConfig:
            CDPotion.Domain.Overlay.container_query_container_highlight_config() | nil,
          contentColor: CDPotion.Domain.DOM.rgba() | nil,
          contrastAlgorithm: CDPotion.Domain.Overlay.contrast_algorithm() | nil,
          cssGridColor: CDPotion.Domain.DOM.rgba() | nil,
          eventTargetColor: CDPotion.Domain.DOM.rgba() | nil,
          flexContainerHighlightConfig:
            CDPotion.Domain.Overlay.flex_container_highlight_config() | nil,
          flexItemHighlightConfig: CDPotion.Domain.Overlay.flex_item_highlight_config() | nil,
          gridHighlightConfig: CDPotion.Domain.Overlay.grid_highlight_config() | nil,
          marginColor: CDPotion.Domain.DOM.rgba() | nil,
          paddingColor: CDPotion.Domain.DOM.rgba() | nil,
          shapeColor: CDPotion.Domain.DOM.rgba() | nil,
          shapeMarginColor: CDPotion.Domain.DOM.rgba() | nil,
          showAccessibilityInfo: boolean() | nil,
          showExtensionLines: boolean() | nil,
          showInfo: boolean() | nil,
          showRulers: boolean() | nil,
          showStyles: boolean() | nil
        }

  @typedoc "Configuration for dual screen hinge"
  @type hinge_config :: %{
          contentColor: CDPotion.Domain.DOM.rgba() | nil,
          outlineColor: CDPotion.Domain.DOM.rgba() | nil,
          rect: CDPotion.Domain.DOM.rect()
        }

  @typedoc "description not provided :("
  @type inspect_mode ::
          :searchForNode | :searchForUAShadowDOM | :captureAreaScreenshot | :showDistances | :none

  @typedoc "description not provided :("
  @type isolated_element_highlight_config :: %{
          isolationModeHighlightConfig: CDPotion.Domain.Overlay.isolation_mode_highlight_config(),
          nodeId: CDPotion.Domain.DOM.node_id()
        }

  @typedoc "description not provided :("
  @type isolation_mode_highlight_config :: %{
          maskColor: CDPotion.Domain.DOM.rgba() | nil,
          resizerColor: CDPotion.Domain.DOM.rgba() | nil,
          resizerHandleColor: CDPotion.Domain.DOM.rgba() | nil
        }

  @typedoc "Style information for drawing a line."
  @type line_style :: %{
          color: CDPotion.Domain.DOM.rgba() | nil,
          pattern: :dashed | :dotted | nil
        }

  @typedoc "description not provided :("
  @type scroll_snap_container_highlight_config :: %{
          scrollMarginColor: CDPotion.Domain.DOM.rgba() | nil,
          scrollPaddingColor: CDPotion.Domain.DOM.rgba() | nil,
          snapAreaBorder: CDPotion.Domain.Overlay.line_style() | nil,
          snapportBorder: CDPotion.Domain.Overlay.line_style() | nil
        }

  @typedoc "description not provided :("
  @type scroll_snap_highlight_config :: %{
          nodeId: CDPotion.Domain.DOM.node_id(),
          scrollSnapContainerHighlightConfig:
            CDPotion.Domain.Overlay.scroll_snap_container_highlight_config()
        }

  @typedoc "Configuration data for drawing the source order of an elements children."
  @type source_order_config :: %{
          childOutlineColor: CDPotion.Domain.DOM.rgba(),
          parentOutlineColor: CDPotion.Domain.DOM.rgba()
        }

  @doc """
  Disables domain notifications.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Overlay.disable", %{}}
  end

  @doc """
  Enables domain notifications.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Overlay.enable", %{}}
  end

  @doc """
  For testing.
  ## Parameters:
    - `node_id`:Id of the node to get highlight object for.
  - `include_distance`:(Optional) Whether to include distance info.
  - `include_style`:(Optional) Whether to include style info.
  - `color_format`:(Optional) The color format to get config with (default: hex).
  - `show_accessibility_info`:(Optional) Whether to show accessibility info (default: true).
  """
  @spec get_highlight_object_for_test(
          CDPotion.Domain.DOM.NodeId,
          boolean(),
          boolean(),
          CDPotion.Domain.Overlay.ColorFormat,
          boolean()
        ) :: {String.t(), map()}
  def get_highlight_object_for_test(
        node_id,
        include_distance \\ nil,
        include_style \\ nil,
        color_format \\ nil,
        show_accessibility_info \\ nil
      ) do
    params =
      as_query([
        {"nodeId", node_id},
        {"includeDistance", include_distance},
        {"includeStyle", include_style},
        {"colorFormat", color_format},
        {"showAccessibilityInfo", show_accessibility_info}
      ])

    {"Overlay.getHighlightObjectForTest", params}
  end

  @doc """
  For Persistent Grid testing.
  ## Parameters:
    - `node_ids`:Ids of the node to get highlight object for.
  """
  @spec get_grid_highlight_objects_for_test(list(CDPotion.Domain.DOM.NodeId)) ::
          {String.t(), map()}
  def get_grid_highlight_objects_for_test(node_ids) do
    params = as_query([{"nodeIds", node_ids}])
    {"Overlay.getGridHighlightObjectsForTest", params}
  end

  @doc """
  For Source Order Viewer testing.
  ## Parameters:
    - `node_id`:Id of the node to highlight.
  """
  @spec get_source_order_highlight_object_for_test(CDPotion.Domain.DOM.NodeId) ::
          {String.t(), map()}
  def get_source_order_highlight_object_for_test(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"Overlay.getSourceOrderHighlightObjectForTest", params}
  end

  @doc """
  Hides any highlight.
  """
  @spec hide_highlight() :: {String.t(), map()}
  def hide_highlight() do
    {"Overlay.hideHighlight", %{}}
  end

  @doc """
  Highlights owner element of the frame with given id.
  Deprecated: Doesn't work reliablity and cannot be fixed due to process
  separatation (the owner node might be in a different process). Determine
  the owner node in the client and use highlightNode.
  ## Parameters:
    - `frame_id`:Identifier of the frame to highlight.
  - `content_color`:(Optional) The content box highlight fill color (default: transparent).
  - `content_outline_color`:(Optional) The content box highlight outline color (default: transparent).
  """
  @spec highlight_frame(
          CDPotion.Domain.Page.FrameId,
          CDPotion.Domain.DOM.RGBA,
          CDPotion.Domain.DOM.RGBA
        ) :: {String.t(), map()}
  def highlight_frame(frame_id, content_color \\ nil, content_outline_color \\ nil) do
    params =
      as_query([
        {"frameId", frame_id},
        {"contentColor", content_color},
        {"contentOutlineColor", content_outline_color}
      ])

    {"Overlay.highlightFrame", params}
  end

  @doc """
  Highlights DOM node with given id or with the given JavaScript object wrapper. Either nodeId or
  objectId must be specified.
  ## Parameters:
    - `highlight_config`:A descriptor for the highlight appearance.
  - `node_id`:(Optional) Identifier of the node to highlight.
  - `backend_node_id`:(Optional) Identifier of the backend node to highlight.
  - `object_id`:(Optional) JavaScript object id of the node to be highlighted.
  - `selector`:(Optional) Selectors to highlight relevant nodes.
  """
  @spec highlight_node(
          CDPotion.Domain.Overlay.HighlightConfig,
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId,
          String.t()
        ) :: {String.t(), map()}
  def highlight_node(
        highlight_config,
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        selector \\ nil
      ) do
    params =
      as_query([
        {"highlightConfig", highlight_config},
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id},
        {"selector", selector}
      ])

    {"Overlay.highlightNode", params}
  end

  @doc """
  Highlights given quad. Coordinates are absolute with respect to the main frame viewport.
  ## Parameters:
    - `quad`:Quad to highlight
  - `color`:(Optional) The highlight fill color (default: transparent).
  - `outline_color`:(Optional) The highlight outline color (default: transparent).
  """
  @spec highlight_quad(
          CDPotion.Domain.DOM.Quad,
          CDPotion.Domain.DOM.RGBA,
          CDPotion.Domain.DOM.RGBA
        ) :: {String.t(), map()}
  def highlight_quad(quad, color \\ nil, outline_color \\ nil) do
    params = as_query([{"quad", quad}, {"color", color}, {"outlineColor", outline_color}])
    {"Overlay.highlightQuad", params}
  end

  @doc """
  Highlights given rectangle. Coordinates are absolute with respect to the main frame viewport.
  ## Parameters:
    - `x`:X coordinate
  - `y`:Y coordinate
  - `width`:Rectangle width
  - `height`:Rectangle height
  - `color`:(Optional) The highlight fill color (default: transparent).
  - `outline_color`:(Optional) The highlight outline color (default: transparent).
  """
  @spec highlight_rect(
          integer(),
          integer(),
          integer(),
          integer(),
          CDPotion.Domain.DOM.RGBA,
          CDPotion.Domain.DOM.RGBA
        ) :: {String.t(), map()}
  def highlight_rect(x, y, width, height, color \\ nil, outline_color \\ nil) do
    params =
      as_query([
        {"x", x},
        {"y", y},
        {"width", width},
        {"height", height},
        {"color", color},
        {"outlineColor", outline_color}
      ])

    {"Overlay.highlightRect", params}
  end

  @doc """
  Highlights the source order of the children of the DOM node with given id or with the given
  JavaScript object wrapper. Either nodeId or objectId must be specified.
  ## Parameters:
    - `source_order_config`:A descriptor for the appearance of the overlay drawing.
  - `node_id`:(Optional) Identifier of the node to highlight.
  - `backend_node_id`:(Optional) Identifier of the backend node to highlight.
  - `object_id`:(Optional) JavaScript object id of the node to be highlighted.
  """
  @spec highlight_source_order(
          CDPotion.Domain.Overlay.SourceOrderConfig,
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def highlight_source_order(
        source_order_config,
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil
      ) do
    params =
      as_query([
        {"sourceOrderConfig", source_order_config},
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id}
      ])

    {"Overlay.highlightSourceOrder", params}
  end

  @doc """
  Enters the 'inspect' mode. In this mode, elements that user is hovering over are highlighted.
  Backend then generates 'inspectNodeRequested' event upon element selection.
  ## Parameters:
    - `mode`:Set an inspection mode.
  - `highlight_config`:(Optional) A descriptor for the highlight appearance of hovered-over nodes. May be omitted if `enabled
  == false`.
  """
  @spec set_inspect_mode(
          CDPotion.Domain.Overlay.InspectMode,
          CDPotion.Domain.Overlay.HighlightConfig
        ) :: {String.t(), map()}
  def set_inspect_mode(mode, highlight_config \\ nil) do
    params = as_query([{"mode", mode}, {"highlightConfig", highlight_config}])
    {"Overlay.setInspectMode", params}
  end

  @doc """
  Highlights owner element of all frames detected to be ads.
  ## Parameters:
    - `show`:True for showing ad highlights
  """
  @spec set_show_ad_highlights(boolean()) :: {String.t(), map()}
  def set_show_ad_highlights(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowAdHighlights", params}
  end

  @doc """

  ## Parameters:
    - `message`:(Optional) The message to display, also triggers resume and step over controls.
  """
  @spec set_paused_in_debugger_message(String.t()) :: {String.t(), map()}
  def set_paused_in_debugger_message(message \\ nil) do
    params = as_query([{"message", message}])
    {"Overlay.setPausedInDebuggerMessage", params}
  end

  @doc """
  Requests that backend shows debug borders on layers
  ## Parameters:
    - `show`:True for showing debug borders
  """
  @spec set_show_debug_borders(boolean()) :: {String.t(), map()}
  def set_show_debug_borders(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowDebugBorders", params}
  end

  @doc """
  Requests that backend shows the FPS counter
  ## Parameters:
    - `show`:True for showing the FPS counter
  """
  @spec set_show_fps_counter(boolean()) :: {String.t(), map()}
  def set_show_fps_counter(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowFPSCounter", params}
  end

  @doc """
  Highlight multiple elements with the CSS Grid overlay.
  ## Parameters:
    - `grid_node_highlight_configs`:An array of node identifiers and descriptors for the highlight appearance.
  """
  @spec set_show_grid_overlays(list(CDPotion.Domain.Overlay.GridNodeHighlightConfig)) ::
          {String.t(), map()}
  def set_show_grid_overlays(grid_node_highlight_configs) do
    params = as_query([{"gridNodeHighlightConfigs", grid_node_highlight_configs}])
    {"Overlay.setShowGridOverlays", params}
  end

  @doc """

  ## Parameters:
    - `flex_node_highlight_configs`:An array of node identifiers and descriptors for the highlight appearance.
  """
  @spec set_show_flex_overlays(list(CDPotion.Domain.Overlay.FlexNodeHighlightConfig)) ::
          {String.t(), map()}
  def set_show_flex_overlays(flex_node_highlight_configs) do
    params = as_query([{"flexNodeHighlightConfigs", flex_node_highlight_configs}])
    {"Overlay.setShowFlexOverlays", params}
  end

  @doc """

  ## Parameters:
    - `scroll_snap_highlight_configs`:An array of node identifiers and descriptors for the highlight appearance.
  """
  @spec set_show_scroll_snap_overlays(list(CDPotion.Domain.Overlay.ScrollSnapHighlightConfig)) ::
          {String.t(), map()}
  def set_show_scroll_snap_overlays(scroll_snap_highlight_configs) do
    params = as_query([{"scrollSnapHighlightConfigs", scroll_snap_highlight_configs}])
    {"Overlay.setShowScrollSnapOverlays", params}
  end

  @doc """

  ## Parameters:
    - `container_query_highlight_configs`:An array of node identifiers and descriptors for the highlight appearance.
  """
  @spec set_show_container_query_overlays(
          list(CDPotion.Domain.Overlay.ContainerQueryHighlightConfig)
        ) :: {String.t(), map()}
  def set_show_container_query_overlays(container_query_highlight_configs) do
    params = as_query([{"containerQueryHighlightConfigs", container_query_highlight_configs}])
    {"Overlay.setShowContainerQueryOverlays", params}
  end

  @doc """
  Requests that backend shows paint rectangles
  ## Parameters:
    - `result`:True for showing paint rectangles
  """
  @spec set_show_paint_rects(boolean()) :: {String.t(), map()}
  def set_show_paint_rects(result) do
    params = as_query([{"result", result}])
    {"Overlay.setShowPaintRects", params}
  end

  @doc """
  Requests that backend shows layout shift regions
  ## Parameters:
    - `result`:True for showing layout shift regions
  """
  @spec set_show_layout_shift_regions(boolean()) :: {String.t(), map()}
  def set_show_layout_shift_regions(result) do
    params = as_query([{"result", result}])
    {"Overlay.setShowLayoutShiftRegions", params}
  end

  @doc """
  Requests that backend shows scroll bottleneck rects
  ## Parameters:
    - `show`:True for showing scroll bottleneck rects
  """
  @spec set_show_scroll_bottleneck_rects(boolean()) :: {String.t(), map()}
  def set_show_scroll_bottleneck_rects(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowScrollBottleneckRects", params}
  end

  @doc """
  Deprecated, no longer has any effect.
  ## Parameters:
    - `show`:True for showing hit-test borders
  """
  @spec set_show_hit_test_borders(boolean()) :: {String.t(), map()}
  def set_show_hit_test_borders(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowHitTestBorders", params}
  end

  @doc """
  Request that backend shows an overlay with web vital metrics.
  ## Parameters:
    - `show`:description not provided :(
  """
  @spec set_show_web_vitals(boolean()) :: {String.t(), map()}
  def set_show_web_vitals(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowWebVitals", params}
  end

  @doc """
  Paints viewport size upon main frame resize.
  ## Parameters:
    - `show`:Whether to paint size or not.
  """
  @spec set_show_viewport_size_on_resize(boolean()) :: {String.t(), map()}
  def set_show_viewport_size_on_resize(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowViewportSizeOnResize", params}
  end

  @doc """
  Add a dual screen device hinge
  ## Parameters:
    - `hinge_config`:(Optional) hinge data, null means hideHinge
  """
  @spec set_show_hinge(CDPotion.Domain.Overlay.HingeConfig) :: {String.t(), map()}
  def set_show_hinge(hinge_config \\ nil) do
    params = as_query([{"hingeConfig", hinge_config}])
    {"Overlay.setShowHinge", params}
  end

  @doc """
  Show elements in isolation mode with overlays.
  ## Parameters:
    - `isolated_element_highlight_configs`:An array of node identifiers and descriptors for the highlight appearance.
  """
  @spec set_show_isolated_elements(list(CDPotion.Domain.Overlay.IsolatedElementHighlightConfig)) ::
          {String.t(), map()}
  def set_show_isolated_elements(isolated_element_highlight_configs) do
    params = as_query([{"isolatedElementHighlightConfigs", isolated_element_highlight_configs}])
    {"Overlay.setShowIsolatedElements", params}
  end
end
