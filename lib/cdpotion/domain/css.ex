defmodule CDPotion.Domain.CSS do
  use CDPotion.Utils

  @doc """
  Inserts a new rule with the given `ruleText` in a stylesheet with given `styleSheetId`, at the
  position specified by `location`.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: The css style sheet identifier where a new rule should be inserted.
    - `ruleText:string`: The text of a new rule.
    - `location:SourceRange`: Text position of a new rule in the target style sheet.
  """
  def add_rule(style_sheet_id, rule_text, location) do
    params =
      as_query([{"styleSheetId", style_sheet_id}, {"ruleText", rule_text}, {"location", location}])

    {"CSS.addRule", params}
  end

  @doc """
  Returns all class names from specified stylesheet.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
  """
  def collect_class_names(style_sheet_id) do
    params = as_query([{"styleSheetId", style_sheet_id}])
    {"CSS.collectClassNames", params}
  end

  @doc """
  Creates a new special "via-inspector" stylesheet in the frame with given `frameId`.
  ## Parameters:
    - `frameId:Page.FrameId`: Identifier of the frame where "via-inspector" stylesheet should be created.
  """
  def create_style_sheet(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"CSS.createStyleSheet", params}
  end

  @doc """
  Disables the CSS agent for the given page.
  """
  def disable() do
    {"CSS.disable", %{}}
  end

  @doc """
  Enables the CSS agent for the given page. Clients should not assume that the CSS agent has been
  enabled until the result of this command is received.
  """
  def enable() do
    {"CSS.enable", %{}}
  end

  @doc """
  Ensures that the given node will have specified pseudo-classes whenever its style is computed by
  the browser.
  ## Parameters:
    - `nodeId:DOM.NodeId`: The element id for which to force the pseudo state.
    - `forcedPseudoClasses:array`: Element pseudo classes to force when computing the element's style.
  """
  def force_pseudo_state(node_id, forced_pseudo_classes) do
    params = as_query([{"nodeId", node_id}, {"forcedPseudoClasses", forced_pseudo_classes}])
    {"CSS.forcePseudoState", params}
  end

  @doc """
  ## Parameters:
    - `nodeId:DOM.NodeId`: Id of the node to get background colors for.
  """
  def get_background_colors(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getBackgroundColors", params}
  end

  @doc """
  Returns the computed style for a DOM node identified by `nodeId`.
  ## Parameters:
    - `nodeId:DOM.NodeId`: description not provided :(
  """
  def get_computed_style_for_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getComputedStyleForNode", params}
  end

  @doc """
  Returns the styles defined inline (explicitly in the "style" attribute and implicitly, using DOM
  attributes) for a DOM node identified by `nodeId`.
  ## Parameters:
    - `nodeId:DOM.NodeId`: description not provided :(
  """
  def get_inline_styles_for_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getInlineStylesForNode", params}
  end

  @doc """
  Returns requested styles for a DOM node identified by `nodeId`.
  ## Parameters:
    - `nodeId:DOM.NodeId`: description not provided :(
  """
  def get_matched_styles_for_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getMatchedStylesForNode", params}
  end

  @doc """
  Returns all media queries parsed by the rendering engine.
  """
  def get_media_queries() do
    {"CSS.getMediaQueries", %{}}
  end

  @doc """
  Requests information about platform fonts which we used to render child TextNodes in the given
  node.
  ## Parameters:
    - `nodeId:DOM.NodeId`: description not provided :(
  """
  def get_platform_fonts_for_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getPlatformFontsForNode", params}
  end

  @doc """
  Returns the current textual content for a stylesheet.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
  """
  def get_style_sheet_text(style_sheet_id) do
    params = as_query([{"styleSheetId", style_sheet_id}])
    {"CSS.getStyleSheetText", params}
  end

  @doc """
  Returns all layers parsed by the rendering engine for the tree scope of a node.
  Given a DOM element identified by nodeId, getLayersForNode returns the root
  layer for the nearest ancestor document or shadow root. The layer root contains
  the full layer tree for the tree scope and their ordering.
  ## Parameters:
    - `nodeId:DOM.NodeId`: description not provided :(
  """
  def get_layers_for_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"CSS.getLayersForNode", params}
  end

  @doc """
  Starts tracking the given computed styles for updates. The specified array of properties
  replaces the one previously specified. Pass empty array to disable tracking.
  Use takeComputedStyleUpdates to retrieve the list of nodes that had properties modified.
  The changes to computed style properties are only tracked for nodes pushed to the front-end
  by the DOM agent. If no changes to the tracked properties occur after the node has been pushed
  to the front-end, no updates will be issued for the node.
  ## Parameters:
    - `propertiesToTrack:array`: description not provided :(
  """
  def track_computed_style_updates(properties_to_track) do
    params = as_query([{"propertiesToTrack", properties_to_track}])
    {"CSS.trackComputedStyleUpdates", params}
  end

  @doc """
  Polls the next batch of computed style updates.
  """
  def take_computed_style_updates() do
    {"CSS.takeComputedStyleUpdates", %{}}
  end

  @doc """
  Find a rule with the given active property for the given node and set the new value for this
  property
  ## Parameters:
    - `nodeId:DOM.NodeId`: The element id for which to set property.
    - `propertyName:string`: description not provided :(
    - `value:string`: description not provided :(
  """
  def set_effective_property_value_for_node(node_id, property_name, value) do
    params = as_query([{"nodeId", node_id}, {"propertyName", property_name}, {"value", value}])
    {"CSS.setEffectivePropertyValueForNode", params}
  end

  @doc """
  Modifies the keyframe rule key text.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `keyText:string`: description not provided :(
  """
  def set_keyframe_key(style_sheet_id, range, key_text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"keyText", key_text}])
    {"CSS.setKeyframeKey", params}
  end

  @doc """
  Modifies the rule selector.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `text:string`: description not provided :(
  """
  def set_media_text(style_sheet_id, range, text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"text", text}])
    {"CSS.setMediaText", params}
  end

  @doc """
  Modifies the expression of a container query.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `text:string`: description not provided :(
  """
  def set_container_query_text(style_sheet_id, range, text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"text", text}])
    {"CSS.setContainerQueryText", params}
  end

  @doc """
  Modifies the expression of a supports at-rule.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `text:string`: description not provided :(
  """
  def set_supports_text(style_sheet_id, range, text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"text", text}])
    {"CSS.setSupportsText", params}
  end

  @doc """
  Modifies the expression of a scope at-rule.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `text:string`: description not provided :(
  """
  def set_scope_text(style_sheet_id, range, text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"text", text}])
    {"CSS.setScopeText", params}
  end

  @doc """
  Modifies the rule selector.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `range:SourceRange`: description not provided :(
    - `selector:string`: description not provided :(
  """
  def set_rule_selector(style_sheet_id, range, selector) do
    params =
      as_query([{"styleSheetId", style_sheet_id}, {"range", range}, {"selector", selector}])

    {"CSS.setRuleSelector", params}
  end

  @doc """
  Sets the new stylesheet text.
  ## Parameters:
    - `styleSheetId:StyleSheetId`: description not provided :(
    - `text:string`: description not provided :(
  """
  def set_style_sheet_text(style_sheet_id, text) do
    params = as_query([{"styleSheetId", style_sheet_id}, {"text", text}])
    {"CSS.setStyleSheetText", params}
  end

  @doc """
  Applies specified style edits one after another in the given order.
  ## Parameters:
    - `edits:array`: description not provided :(
  """
  def set_style_texts(edits) do
    params = as_query([{"edits", edits}])
    {"CSS.setStyleTexts", params}
  end

  @doc """
  Enables the selector recording.
  """
  def start_rule_usage_tracking() do
    {"CSS.startRuleUsageTracking", %{}}
  end

  @doc """
  Stop tracking rule usage and return the list of rules that were used since last call to
  `takeCoverageDelta` (or since start of coverage instrumentation).
  """
  def stop_rule_usage_tracking() do
    {"CSS.stopRuleUsageTracking", %{}}
  end

  @doc """
  Obtain list of rules that became used since last call to this method (or since start of coverage
  instrumentation).
  """
  def take_coverage_delta() do
    {"CSS.takeCoverageDelta", %{}}
  end

  @doc """
  Enables/disables rendering of local CSS fonts (enabled by default).
  ## Parameters:
    - `enabled:boolean`: Whether rendering of local fonts is enabled.
  """
  def set_local_fonts_enabled(enabled) do
    params = as_query([{"enabled", enabled}])
    {"CSS.setLocalFontsEnabled", params}
  end
end
