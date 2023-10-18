defmodule CDPotion.Domain.Overlay do
  @doc """
  Disables domain notifications.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables domain notifications.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  For Persistent Grid testing.
  ## Parameters:
    - `nodeIds:array`: Ids of the node to get highlight object for.
  """
  def get_grid_highlight_objects_for_test(node_ids) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  For Source Order Viewer testing.
  ## Parameters:
    - `nodeId:DOM.NodeId`: Id of the node to highlight.
  """
  def get_source_order_highlight_object_for_test(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Hides any highlight.
  """
  def hide_highlight() do
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Highlights given quad. Coordinates are absolute with respect to the main frame viewport.
  ## Parameters:
    - `quad:DOM.Quad`: Quad to highlight
    - `color:DOM.RGBA`: (Optional) The highlight fill color (default: transparent).
    - `outlineColor:DOM.RGBA`: (Optional) The highlight outline color (default: transparent).
  """
  def highlight_quad(quad, color \\ nil, outline_color \\ nil) do
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Highlights owner element of all frames detected to be ads.
  ## Parameters:
    - `show:boolean`: True for showing ad highlights
  """
  def set_show_ad_highlights(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
    - `message:string`: (Optional) The message to display, also triggers resume and step over controls.
  """
  def set_paused_in_debugger_message(message \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that backend shows debug borders on layers
  ## Parameters:
    - `show:boolean`: True for showing debug borders
  """
  def set_show_debug_borders(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that backend shows the FPS counter
  ## Parameters:
    - `show:boolean`: True for showing the FPS counter
  """
  def set_show_fps_counter(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Highlight multiple elements with the CSS Grid overlay.
  ## Parameters:
    - `gridNodeHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_grid_overlays(grid_node_highlight_configs) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
    - `flexNodeHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_flex_overlays(flex_node_highlight_configs) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
    - `scrollSnapHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_scroll_snap_overlays(scroll_snap_highlight_configs) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  ## Parameters:
    - `containerQueryHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_container_query_overlays(container_query_highlight_configs) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that backend shows paint rectangles
  ## Parameters:
    - `result:boolean`: True for showing paint rectangles
  """
  def set_show_paint_rects(result) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that backend shows layout shift regions
  ## Parameters:
    - `result:boolean`: True for showing layout shift regions
  """
  def set_show_layout_shift_regions(result) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that backend shows scroll bottleneck rects
  ## Parameters:
    - `show:boolean`: True for showing scroll bottleneck rects
  """
  def set_show_scroll_bottleneck_rects(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Deprecated, no longer has any effect.
  ## Parameters:
    - `show:boolean`: True for showing hit-test borders
  """
  def set_show_hit_test_borders(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Request that backend shows an overlay with web vital metrics.
  ## Parameters:
    - `show:boolean`: description not provided :(
  """
  def set_show_web_vitals(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Paints viewport size upon main frame resize.
  ## Parameters:
    - `show:boolean`: Whether to paint size or not.
  """
  def set_show_viewport_size_on_resize(show) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Add a dual screen device hinge
  ## Parameters:
    - `hingeConfig:HingeConfig`: (Optional) hinge data, null means hideHinge
  """
  def set_show_hinge(hinge_config \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Show elements in isolation mode with overlays.
  ## Parameters:
    - `isolatedElementHighlightConfigs:array`: An array of node identifiers and descriptors for the highlight appearance.
  """
  def set_show_isolated_elements(isolated_element_highlight_configs) do
    execute(session, :navigate, %{"url" => url})
  end
end
