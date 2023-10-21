defmodule CDPotion.Domain.CSS do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type css_computed_style_property :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "CSS container query rule descriptor."
  @type css_container_query :: %{
          logicalAxes: CDPotion.Domain.DOM.logical_axes() | nil,
          name: String.t() | nil,
          physicalAxes: CDPotion.Domain.DOM.physical_axes() | nil,
          range: CDPotion.Domain.CSS.source_range() | nil,
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          text: String.t()
        }

  @typedoc "CSS keyframe rule representation."
  @type css_keyframe_rule :: %{
          keyText: CDPotion.Domain.CSS.value(),
          origin: CDPotion.Domain.CSS.style_sheet_origin(),
          style: CDPotion.Domain.CSS.css_style(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil
        }

  @typedoc "CSS keyframes rule representation."
  @type css_keyframes_rule :: %{
          animationName: CDPotion.Domain.CSS.value(),
          keyframes: list(CDPotion.Domain.CSS.css_keyframe_rule())
        }

  @typedoc "CSS Layer at-rule descriptor."
  @type css_layer :: %{
          range: CDPotion.Domain.CSS.source_range() | nil,
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          text: String.t()
        }

  @typedoc "CSS Layer data."
  @type css_layer_data :: %{
          name: String.t(),
          order: number(),
          subLayers: list(CDPotion.Domain.CSS.css_layer_data()) | nil
        }

  @typedoc "CSS media rule descriptor."
  @type css_media :: %{
          mediaList: list(CDPotion.Domain.CSS.media_query()) | nil,
          range: CDPotion.Domain.CSS.source_range() | nil,
          source: :mediaRule | :importRule | :linkedSheet | :inlineSheet,
          sourceURL: String.t() | nil,
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          text: String.t()
        }

  @typedoc "CSS position-fallback rule representation."
  @type css_position_fallback_rule :: %{
          name: CDPotion.Domain.CSS.value(),
          tryRules: list(CDPotion.Domain.CSS.css_try_rule())
        }

  @typedoc "CSS property declaration data."
  @type css_property :: %{
          disabled: boolean() | nil,
          implicit: boolean() | nil,
          important: boolean() | nil,
          longhandProperties: list(CDPotion.Domain.CSS.css_property()) | nil,
          name: String.t(),
          parsedOk: boolean() | nil,
          range: CDPotion.Domain.CSS.source_range() | nil,
          text: String.t() | nil,
          value: String.t()
        }

  @typedoc "CSS rule representation."
  @type css_rule :: %{
          containerQueries: list(CDPotion.Domain.CSS.css_container_query()) | nil,
          layers: list(CDPotion.Domain.CSS.css_layer()) | nil,
          media: list(CDPotion.Domain.CSS.css_media()) | nil,
          nestingSelectors: list(String.t()) | nil,
          origin: CDPotion.Domain.CSS.style_sheet_origin(),
          ruleTypes: list(CDPotion.Domain.CSS.css_rule_type()) | nil,
          scopes: list(CDPotion.Domain.CSS.css_scope()) | nil,
          selectorList: CDPotion.Domain.CSS.selector_list(),
          style: CDPotion.Domain.CSS.css_style(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          supports: list(CDPotion.Domain.CSS.css_supports()) | nil
        }

  @typedoc "Enum indicating the type of a CSS rule, used to represent the order of a style rule's ancestors.
This list only contains rule types that are collected during the ancestor rule collection."
  @type css_rule_type ::
          :MediaRule | :SupportsRule | :ContainerRule | :LayerRule | :ScopeRule | :StyleRule

  @typedoc "CSS Scope at-rule descriptor."
  @type css_scope :: %{
          range: CDPotion.Domain.CSS.source_range() | nil,
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          text: String.t()
        }

  @typedoc "CSS style representation."
  @type css_style :: %{
          cssProperties: list(CDPotion.Domain.CSS.css_property()),
          cssText: String.t() | nil,
          range: CDPotion.Domain.CSS.source_range() | nil,
          shorthandEntries: list(CDPotion.Domain.CSS.shorthand_entry()),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil
        }

  @typedoc "CSS stylesheet metainformation."
  @type css_style_sheet_header :: %{
          disabled: boolean(),
          endColumn: number(),
          endLine: number(),
          frameId: CDPotion.Domain.Page.frame_id(),
          hasSourceURL: boolean() | nil,
          isConstructed: boolean(),
          isInline: boolean(),
          isMutable: boolean(),
          length: number(),
          loadingFailed: boolean() | nil,
          origin: CDPotion.Domain.CSS.style_sheet_origin(),
          ownerNode: CDPotion.Domain.DOM.backend_node_id() | nil,
          sourceMapURL: String.t() | nil,
          sourceURL: String.t(),
          startColumn: number(),
          startLine: number(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id(),
          title: String.t()
        }

  @typedoc "CSS Supports at-rule descriptor."
  @type css_supports :: %{
          active: boolean(),
          range: CDPotion.Domain.CSS.source_range() | nil,
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil,
          text: String.t()
        }

  @typedoc "CSS try rule representation."
  @type css_try_rule :: %{
          origin: CDPotion.Domain.CSS.style_sheet_origin(),
          style: CDPotion.Domain.CSS.css_style(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id() | nil
        }

  @typedoc "Properties of a web font: https://www.w3.org/TR/2008/REC-CSS2-20080411/fonts.html#font-descriptions
and additional information such as platformFontFamily and fontVariationAxes."
  @type font_face :: %{
          fontDisplay: String.t(),
          fontFamily: String.t(),
          fontStretch: String.t(),
          fontStyle: String.t(),
          fontVariant: String.t(),
          fontVariationAxes: list(CDPotion.Domain.CSS.font_variation_axis()) | nil,
          fontWeight: String.t(),
          platformFontFamily: String.t(),
          src: String.t(),
          unicodeRange: String.t()
        }

  @typedoc "Information about font variation axes for variable fonts"
  @type font_variation_axis :: %{
          defaultValue: number(),
          maxValue: number(),
          minValue: number(),
          name: String.t(),
          tag: String.t()
        }

  @typedoc "Inherited pseudo element matches from pseudos of an ancestor node."
  @type inherited_pseudo_element_matches :: %{
          pseudoElements: list(CDPotion.Domain.CSS.pseudo_element_matches())
        }

  @typedoc "Inherited CSS rule collection from ancestor node."
  @type inherited_style_entry :: %{
          inlineStyle: CDPotion.Domain.CSS.css_style() | nil,
          matchedCSSRules: list(CDPotion.Domain.CSS.rule_match())
        }

  @typedoc "Media query descriptor."
  @type media_query :: %{
          active: boolean(),
          expressions: list(CDPotion.Domain.CSS.media_query_expression())
        }

  @typedoc "Media query expression descriptor."
  @type media_query_expression :: %{
          computedLength: number() | nil,
          feature: String.t(),
          unit: String.t(),
          value: number(),
          valueRange: CDPotion.Domain.CSS.source_range() | nil
        }

  @typedoc "Information about amount of glyphs that were rendered with given font."
  @type platform_font_usage :: %{
          familyName: String.t(),
          glyphCount: number(),
          isCustomFont: boolean()
        }

  @typedoc "CSS rule collection for a single pseudo style."
  @type pseudo_element_matches :: %{
          matches: list(CDPotion.Domain.CSS.rule_match()),
          pseudoIdentifier: String.t() | nil,
          pseudoType: CDPotion.Domain.DOM.pseudo_type()
        }

  @typedoc "Match data for a CSS rule."
  @type rule_match :: %{
          matchingSelectors: list(integer()),
          rule: CDPotion.Domain.CSS.css_rule()
        }

  @typedoc "CSS coverage information."
  @type rule_usage :: %{
          endOffset: number(),
          startOffset: number(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id(),
          used: boolean()
        }

  @typedoc "Selector list data."
  @type selector_list :: %{
          selectors: list(CDPotion.Domain.CSS.value()),
          text: String.t()
        }

  @typedoc "description not provided :("
  @type shorthand_entry :: %{
          important: boolean() | nil,
          name: String.t(),
          value: String.t()
        }

  @typedoc "Text range within a resource. All numbers are zero-based."
  @type source_range :: %{
          endColumn: integer(),
          endLine: integer(),
          startColumn: integer(),
          startLine: integer()
        }

  @typedoc "Specificity:
https://drafts.csswg.org/selectors/#specificity-rules"
  @type specificity :: %{
          a: integer(),
          b: integer(),
          c: integer()
        }

  @typedoc "A descriptor of operation to mutate style declaration text."
  @type style_declaration_edit :: %{
          range: CDPotion.Domain.CSS.source_range(),
          styleSheetId: CDPotion.Domain.CSS.style_sheet_id(),
          text: String.t()
        }

  @typedoc "description not provided :("
  @type style_sheet_id :: String.t()

  @typedoc "Stylesheet type: 'injected' for stylesheets injected via extension, 'user-agent' for user-agent
stylesheets, 'inspector' for stylesheets created by the inspector (i.e. those holding the 'via
inspector' rules), 'regular' for regular stylesheets."
  @type style_sheet_origin :: :injected | :"user-agent" | :inspector | :regular

  @typedoc "Data for a simple selector (these are delimited by commas in a selector list)."
  @type value :: %{
          range: CDPotion.Domain.CSS.source_range() | nil,
          specificity: CDPotion.Domain.CSS.specificity() | nil,
          text: String.t()
        }

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
