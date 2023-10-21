defmodule CDPotion.Domain.Overlay do
  use CDPotion.Utils
  @doc "Style information for drawing a box."
  @type BoxStyle :: %{
          fillColor: DOM.RGBA | nil,
          hatchColor: DOM.RGBA | nil
        }

  @doc "description not provided :("
  @type ColorFormat :: :rgb | :hsl | :hwb | :hex

  @doc "description not provided :("
  @type ContainerQueryContainerHighlightConfig :: %{
          containerBorder: Overlay.LineStyle | nil,
          descendantBorder: Overlay.LineStyle | nil
        }

  @doc "description not provided :("
  @type ContainerQueryHighlightConfig :: %{
          containerQueryContainerHighlightConfig: Overlay.ContainerQueryContainerHighlightConfig,
          nodeId: DOM.NodeId
        }

  @doc "description not provided :("
  @type ContrastAlgorithm :: :aa | :aaa | :apca

  @doc "Configuration data for the highlighting of Flex container elements."
  @type FlexContainerHighlightConfig :: %{
          columnGapSpace: Overlay.BoxStyle | nil,
          containerBorder: Overlay.LineStyle | nil,
          crossAlignment: Overlay.LineStyle | nil,
          crossDistributedSpace: Overlay.BoxStyle | nil,
          itemSeparator: Overlay.LineStyle | nil,
          lineSeparator: Overlay.LineStyle | nil,
          mainDistributedSpace: Overlay.BoxStyle | nil,
          rowGapSpace: Overlay.BoxStyle | nil
        }

  @doc "Configuration data for the highlighting of Flex item elements."
  @type FlexItemHighlightConfig :: %{
          baseSizeBorder: Overlay.LineStyle | nil,
          baseSizeBox: Overlay.BoxStyle | nil,
          flexibilityArrow: Overlay.LineStyle | nil
        }

  @doc "description not provided :("
  @type FlexNodeHighlightConfig :: %{
          flexContainerHighlightConfig: Overlay.FlexContainerHighlightConfig,
          nodeId: DOM.NodeId
        }

  @doc "Configuration data for the highlighting of Grid elements."
  @type GridHighlightConfig :: %{
          areaBorderColor: DOM.RGBA | nil,
          cellBorderColor: DOM.RGBA | nil,
          cellBorderDash: boolean() | nil,
          columnGapColor: DOM.RGBA | nil,
          columnHatchColor: DOM.RGBA | nil,
          columnLineColor: DOM.RGBA | nil,
          columnLineDash: boolean() | nil,
          gridBackgroundColor: DOM.RGBA | nil,
          gridBorderColor: DOM.RGBA | nil,
          gridBorderDash: boolean() | nil,
          rowGapColor: DOM.RGBA | nil,
          rowHatchColor: DOM.RGBA | nil,
          rowLineColor: DOM.RGBA | nil,
          rowLineDash: boolean() | nil,
          showAreaNames: boolean() | nil,
          showGridExtensionLines: boolean() | nil,
          showLineNames: boolean() | nil,
          showNegativeLineNumbers: boolean() | nil,
          showPositiveLineNumbers: boolean() | nil,
          showTrackSizes: boolean() | nil
        }

  @doc "Configurations for Persistent Grid Highlight"
  @type GridNodeHighlightConfig :: %{
          gridHighlightConfig: Overlay.GridHighlightConfig,
          nodeId: DOM.NodeId
        }

  @doc "Configuration data for the highlighting of page elements."
  @type HighlightConfig :: %{
          borderColor: DOM.RGBA | nil,
          colorFormat: Overlay.ColorFormat | nil,
          containerQueryContainerHighlightConfig:
            Overlay.ContainerQueryContainerHighlightConfig | nil,
          contentColor: DOM.RGBA | nil,
          contrastAlgorithm: Overlay.ContrastAlgorithm | nil,
          cssGridColor: DOM.RGBA | nil,
          eventTargetColor: DOM.RGBA | nil,
          flexContainerHighlightConfig: Overlay.FlexContainerHighlightConfig | nil,
          flexItemHighlightConfig: Overlay.FlexItemHighlightConfig | nil,
          gridHighlightConfig: Overlay.GridHighlightConfig | nil,
          marginColor: DOM.RGBA | nil,
          paddingColor: DOM.RGBA | nil,
          shapeColor: DOM.RGBA | nil,
          shapeMarginColor: DOM.RGBA | nil,
          showAccessibilityInfo: boolean() | nil,
          showExtensionLines: boolean() | nil,
          showInfo: boolean() | nil,
          showRulers: boolean() | nil,
          showStyles: boolean() | nil
        }

  @doc "Configuration for dual screen hinge"
  @type HingeConfig :: %{
          contentColor: DOM.RGBA | nil,
          outlineColor: DOM.RGBA | nil,
          rect: DOM.Rect
        }

  @doc "description not provided :("
  @type InspectMode ::
          :searchForNode | :searchForUAShadowDOM | :captureAreaScreenshot | :showDistances | :none

  @doc "description not provided :("
  @type IsolatedElementHighlightConfig :: %{
          isolationModeHighlightConfig: Overlay.IsolationModeHighlightConfig,
          nodeId: DOM.NodeId
        }

  @doc "description not provided :("
  @type IsolationModeHighlightConfig :: %{
          maskColor: DOM.RGBA | nil,
          resizerColor: DOM.RGBA | nil,
          resizerHandleColor: DOM.RGBA | nil
        }

  @doc "Style information for drawing a line."
  @type LineStyle :: %{
          color: DOM.RGBA | nil,
          pattern: :dashed | :dotted | nil
        }

  @doc "description not provided :("
  @type ScrollSnapContainerHighlightConfig :: %{
          scrollMarginColor: DOM.RGBA | nil,
          scrollPaddingColor: DOM.RGBA | nil,
          snapAreaBorder: Overlay.LineStyle | nil,
          snapportBorder: Overlay.LineStyle | nil
        }

  @doc "description not provided :("
  @type ScrollSnapHighlightConfig :: %{
          nodeId: DOM.NodeId,
          scrollSnapContainerHighlightConfig: Overlay.ScrollSnapContainerHighlightConfig
        }

  @doc "Configuration data for drawing the source order of an elements children."
  @type SourceOrderConfig :: %{
          childOutlineColor: DOM.RGBA,
          parentOutlineColor: DOM.RGBA
        }

  @doc """
  Disables domain notifications.
  """
  def disable() do
    {"Overlay.disable", %{}}
  end

  @doc """
  Enables domain notifications.
  """
  def enable() do
    {"Overlay.enable", %{}}
  end

  @doc """
  For testing.
  ## Parameters:
    - `nodeId:DOM.NodeId`: Id of the node to get highlight object for.
    - `includeDistance:boolean`: (Optional) Whether to include distance info.
    - `includeStyle:boolean`: (Optional) Whether to include style info.
    - `colorFormat:ColorFormat`: (Optional) The color format to get config with (default: hex).
    - `showAccessibilityInfo:boolean`: (Optional) Whether to show accessibility info (default: true).
  """
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
    - `nodeIds:array`: Ids of the node to get highlight object for.
  """
  def get_grid_highlight_objects_for_test(node_ids) do
    params = as_query([{"nodeIds", node_ids}])
    {"Overlay.getGridHighlightObjectsForTest", params}
  end

  @doc """
  For Source Order Viewer testing.
  ## Parameters:
    - `nodeId:DOM.NodeId`: Id of the node to highlight.
  """
  def get_source_order_highlight_object_for_test(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"Overlay.getSourceOrderHighlightObjectForTest", params}
  end

  @doc """
  Hides any highlight.
  """
  def hide_highlight() do
    {"Overlay.hideHighlight", %{}}
  end

  @doc """
  Highlights owner element of the frame with given id.
  Deprecated: Doesn't work reliablity and cannot be fixed due to process
  separatation (the owner node might be in a different process). Determine
  the owner node in the client and use highlightNode.
  ## Parameters:
    - `frameId:Page.FrameId`: Identifier of the frame to highlight.
    - `contentColor:DOM.RGBA`: (Optional) The content box highlight fill color (default: transparent).
    - `contentOutlineColor:DOM.RGBA`: (Optional) The content box highlight outline color (default: transparent).
  """
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
    - `highlightConfig:HighlightConfig`: A descriptor for the highlight appearance.
    - `nodeId:DOM.NodeId`: (Optional) Identifier of the node to highlight.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Identifier of the backend node to highlight.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node to be highlighted.
    - `selector:string`: (Optional) Selectors to highlight relevant nodes.
  """
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
    - `quad:DOM.Quad`: Quad to highlight
    - `color:DOM.RGBA`: (Optional) The highlight fill color (default: transparent).
    - `outlineColor:DOM.RGBA`: (Optional) The highlight outline color (default: transparent).
  """
  def highlight_quad(quad, color \\ nil, outline_color \\ nil) do
    params = as_query([{"quad", quad}, {"color", color}, {"outlineColor", outline_color}])
    {"Overlay.highlightQuad", params}
  end

  @doc """
  Highlights given rectangle. Coordinates are absolute with respect to the main frame viewport.
  ## Parameters:
    - `x:integer`: X coordinate
    - `y:integer`: Y coordinate
    - `width:integer`: Rectangle width
    - `height:integer`: Rectangle height
    - `color:DOM.RGBA`: (Optional) The highlight fill color (default: transparent).
    - `outlineColor:DOM.RGBA`: (Optional) The highlight outline color (default: transparent).
  """
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
    - `sourceOrderConfig:SourceOrderConfig`: A descriptor for the appearance of the overlay drawing.
    - `nodeId:DOM.NodeId`: (Optional) Identifier of the node to highlight.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Identifier of the backend node to highlight.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node to be highlighted.
  """
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
    - `mode:InspectMode`: Set an inspection mode.
    - `highlightConfig:HighlightConfig`: (Optional) A descriptor for the highlight appearance of hovered-over nodes. May be omitted if `enabled
  == false`.
  """
  def set_inspect_mode(mode, highlight_config \\ nil) do
    params = as_query([{"mode", mode}, {"highlightConfig", highlight_config}])
    {"Overlay.setInspectMode", params}
  end

  @doc """
  Highlights owner element of all frames detected to be ads.
  ## Parameters:
    - `show:boolean`: True for showing ad highlights
  """
  def set_show_ad_highlights(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowAdHighlights", params}
  end

  @doc """
  ## Parameters:
    - `message:string`: (Optional) The message to display, also triggers resume and step over controls.
  """
  def set_paused_in_debugger_message(message \\ nil) do
    params = as_query([{"message", message}])
    {"Overlay.setPausedInDebuggerMessage", params}
  end

  @doc """
  Requests that backend shows debug borders on layers
  ## Parameters:
    - `show:boolean`: True for showing debug borders
  """
  def set_show_debug_borders(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowDebugBorders", params}
  end

  @doc """
  Requests that backend shows the FPS counter
  ## Parameters:
    - `show:boolean`: True for showing the FPS counter
  """
  def set_show_fps_counter(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowFPSCounter", params}
  end

  @doc """
  Highlight multiple elements with the CSS Grid overlay.
  ## Parameters:
    - `gridNodeHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_grid_overlays(grid_node_highlight_configs) do
    params = as_query([{"gridNodeHighlightConfigs", grid_node_highlight_configs}])
    {"Overlay.setShowGridOverlays", params}
  end

  @doc """
  ## Parameters:
    - `flexNodeHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_flex_overlays(flex_node_highlight_configs) do
    params = as_query([{"flexNodeHighlightConfigs", flex_node_highlight_configs}])
    {"Overlay.setShowFlexOverlays", params}
  end

  @doc """
  ## Parameters:
    - `scrollSnapHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_scroll_snap_overlays(scroll_snap_highlight_configs) do
    params = as_query([{"scrollSnapHighlightConfigs", scroll_snap_highlight_configs}])
    {"Overlay.setShowScrollSnapOverlays", params}
  end

  @doc """
  ## Parameters:
    - `containerQueryHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_container_query_overlays(container_query_highlight_configs) do
    params = as_query([{"containerQueryHighlightConfigs", container_query_highlight_configs}])
    {"Overlay.setShowContainerQueryOverlays", params}
  end

  @doc """
  Requests that backend shows paint rectangles
  ## Parameters:
    - `result:boolean`: True for showing paint rectangles
  """
  def set_show_paint_rects(result) do
    params = as_query([{"result", result}])
    {"Overlay.setShowPaintRects", params}
  end

  @doc """
  Requests that backend shows layout shift regions
  ## Parameters:
    - `result:boolean`: True for showing layout shift regions
  """
  def set_show_layout_shift_regions(result) do
    params = as_query([{"result", result}])
    {"Overlay.setShowLayoutShiftRegions", params}
  end

  @doc """
  Requests that backend shows scroll bottleneck rects
  ## Parameters:
    - `show:boolean`: True for showing scroll bottleneck rects
  """
  def set_show_scroll_bottleneck_rects(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowScrollBottleneckRects", params}
  end

  @doc """
  Deprecated, no longer has any effect.
  ## Parameters:
    - `show:boolean`: True for showing hit-test borders
  """
  def set_show_hit_test_borders(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowHitTestBorders", params}
  end

  @doc """
  Request that backend shows an overlay with web vital metrics.
  ## Parameters:
    - `show:boolean`: description not provided :(
  """
  def set_show_web_vitals(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowWebVitals", params}
  end

  @doc """
  Paints viewport size upon main frame resize.
  ## Parameters:
    - `show:boolean`: Whether to paint size or not.
  """
  def set_show_viewport_size_on_resize(show) do
    params = as_query([{"show", show}])
    {"Overlay.setShowViewportSizeOnResize", params}
  end

  @doc """
  Add a dual screen device hinge
  ## Parameters:
    - `hingeConfig:HingeConfig`: (Optional) hinge data, null means hideHinge
  """
  def set_show_hinge(hinge_config \\ nil) do
    params = as_query([{"hingeConfig", hinge_config}])
    {"Overlay.setShowHinge", params}
  end

  @doc """
  Show elements in isolation mode with overlays.
  ## Parameters:
    - `isolatedElementHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_isolated_elements(isolated_element_highlight_configs) do
    params = as_query([{"isolatedElementHighlightConfigs", isolated_element_highlight_configs}])
    {"Overlay.setShowIsolatedElements", params}
  end
end
