defmodule CDPotion.Domain.DOMSnapshot do
  use CDPotion.Utils
  @typedoc "Index of the string in the strings table."
  @type array_of_strings :: list(CDPotion.Domain.DOMSnapshot.string_index())

  @typedoc "A subset of the full ComputedStyle as defined by the request whitelist."
  @type computed_style :: %{
          properties: list(CDPotion.Domain.DOMSnapshot.name_value())
        }

  @typedoc "A Node in the DOM tree."
  @type dom_node :: %{
          attributes: list(CDPotion.Domain.DOMSnapshot.name_value()) | nil,
          backendNodeId: CDPotion.Domain.DOM.backend_node_id(),
          baseURL: String.t() | nil,
          childNodeIndexes: list(integer()) | nil,
          contentDocumentIndex: integer() | nil,
          contentLanguage: String.t() | nil,
          currentSourceURL: String.t() | nil,
          documentEncoding: String.t() | nil,
          documentURL: String.t() | nil,
          eventListeners: list(CDPotion.Domain.DOMDebugger.event_listener()) | nil,
          frameId: CDPotion.Domain.Page.frame_id() | nil,
          inputChecked: boolean() | nil,
          inputValue: String.t() | nil,
          isClickable: boolean() | nil,
          layoutNodeIndex: integer() | nil,
          nodeName: String.t(),
          nodeType: integer(),
          nodeValue: String.t(),
          optionSelected: boolean() | nil,
          originURL: String.t() | nil,
          pseudoElementIndexes: list(integer()) | nil,
          pseudoType: CDPotion.Domain.DOM.pseudo_type() | nil,
          publicId: String.t() | nil,
          scrollOffsetX: number() | nil,
          scrollOffsetY: number() | nil,
          shadowRootType: CDPotion.Domain.DOM.shadow_root_type() | nil,
          systemId: String.t() | nil,
          textValue: String.t() | nil
        }

  @typedoc "Document snapshot."
  @type document_snapshot :: %{
          baseURL: CDPotion.Domain.DOMSnapshot.string_index(),
          contentHeight: number() | nil,
          contentLanguage: CDPotion.Domain.DOMSnapshot.string_index(),
          contentWidth: number() | nil,
          documentURL: CDPotion.Domain.DOMSnapshot.string_index(),
          encodingName: CDPotion.Domain.DOMSnapshot.string_index(),
          frameId: CDPotion.Domain.DOMSnapshot.string_index(),
          layout: CDPotion.Domain.DOMSnapshot.layout_tree_snapshot(),
          nodes: CDPotion.Domain.DOMSnapshot.node_tree_snapshot(),
          publicId: CDPotion.Domain.DOMSnapshot.string_index(),
          scrollOffsetX: number() | nil,
          scrollOffsetY: number() | nil,
          systemId: CDPotion.Domain.DOMSnapshot.string_index(),
          textBoxes: CDPotion.Domain.DOMSnapshot.text_box_snapshot(),
          title: CDPotion.Domain.DOMSnapshot.string_index()
        }

  @typedoc "Details of post layout rendered text positions. The exact layout should not be regarded as
stable and may change between versions."
  @type inline_text_box :: %{
          boundingBox: CDPotion.Domain.DOM.rect(),
          numCharacters: integer(),
          startCharacterIndex: integer()
        }

  @typedoc "Details of an element in the DOM tree with a LayoutObject."
  @type layout_tree_node :: %{
          boundingBox: CDPotion.Domain.DOM.rect(),
          domNodeIndex: integer(),
          inlineTextNodes: list(CDPotion.Domain.DOMSnapshot.inline_text_box()) | nil,
          isStackingContext: boolean() | nil,
          layoutText: String.t() | nil,
          paintOrder: integer() | nil,
          styleIndex: integer() | nil
        }

  @typedoc "Table of details of an element in the DOM tree with a LayoutObject."
  @type layout_tree_snapshot :: %{
          blendedBackgroundColors: list(CDPotion.Domain.DOMSnapshot.string_index()) | nil,
          bounds: list(CDPotion.Domain.DOMSnapshot.rectangle()),
          clientRects: list(CDPotion.Domain.DOMSnapshot.rectangle()) | nil,
          nodeIndex: list(integer()),
          offsetRects: list(CDPotion.Domain.DOMSnapshot.rectangle()) | nil,
          paintOrders: list(integer()) | nil,
          scrollRects: list(CDPotion.Domain.DOMSnapshot.rectangle()) | nil,
          stackingContexts: CDPotion.Domain.DOMSnapshot.rare_boolean_data(),
          styles: list(CDPotion.Domain.DOMSnapshot.array_of_strings()),
          text: list(CDPotion.Domain.DOMSnapshot.string_index()),
          textColorOpacities: list(number()) | nil
        }

  @typedoc "A name/value pair."
  @type name_value :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "Table containing nodes."
  @type node_tree_snapshot :: %{
          attributes: list(CDPotion.Domain.DOMSnapshot.array_of_strings()) | nil,
          backendNodeId: list(CDPotion.Domain.DOM.backend_node_id()) | nil,
          contentDocumentIndex: CDPotion.Domain.DOMSnapshot.rare_integer_data() | nil,
          currentSourceURL: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          inputChecked: CDPotion.Domain.DOMSnapshot.rare_boolean_data() | nil,
          inputValue: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          isClickable: CDPotion.Domain.DOMSnapshot.rare_boolean_data() | nil,
          nodeName: list(CDPotion.Domain.DOMSnapshot.string_index()) | nil,
          nodeType: list(integer()) | nil,
          nodeValue: list(CDPotion.Domain.DOMSnapshot.string_index()) | nil,
          optionSelected: CDPotion.Domain.DOMSnapshot.rare_boolean_data() | nil,
          originURL: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          parentIndex: list(integer()) | nil,
          pseudoIdentifier: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          pseudoType: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          shadowRootType: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil,
          textValue: CDPotion.Domain.DOMSnapshot.rare_string_data() | nil
        }

  @typedoc "description not provided :("
  @type rare_boolean_data :: %{
          index: list(integer())
        }

  @typedoc "description not provided :("
  @type rare_integer_data :: %{
          index: list(integer()),
          value: list(integer())
        }

  @typedoc "Data that is only present on rare nodes."
  @type rare_string_data :: %{
          index: list(integer()),
          value: list(CDPotion.Domain.DOMSnapshot.string_index())
        }

  @typedoc "description not provided :("
  @type rectangle :: list(number())

  @typedoc "Index of the string in the strings table."
  @type string_index :: integer()

  @typedoc "Table of details of the post layout rendered text positions. The exact layout should not be regarded as
stable and may change between versions."
  @type text_box_snapshot :: %{
          bounds: list(CDPotion.Domain.DOMSnapshot.rectangle()),
          layoutIndex: list(integer()),
          length: list(integer()),
          start: list(integer())
        }

  @doc """
  Disables DOM snapshot agent for the given page.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"DOMSnapshot.disable", %{}}
  end

  @doc """
  Enables DOM snapshot agent for the given page.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"DOMSnapshot.enable", %{}}
  end

  @doc """
  Returns a document snapshot, including the full DOM tree of the root node (including iframes,
  template contents, and imported documents) in a flattened array, as well as layout and
  white-listed computed style information for the nodes. Shadow DOM in the returned DOM tree is
  flattened.
  ## Parameters:
    - `computed_style_whitelist`:Whitelist of computed styles to return.
  - `include_event_listeners`:(Optional) Whether or not to retrieve details of DOM listeners (default false).
  - `include_paint_order`:(Optional) Whether to determine and include the paint order index of LayoutTreeNodes (default false).
  - `include_user_agent_shadow_tree`:(Optional) Whether to include UA shadow tree in the snapshot (default false).
  """
  @spec get_snapshot(list(String.t()), boolean(), boolean(), boolean()) :: {String.t(), map()}
  def get_snapshot(
        computed_style_whitelist,
        include_event_listeners \\ nil,
        include_paint_order \\ nil,
        include_user_agent_shadow_tree \\ nil
      ) do
    params =
      as_query([
        {"computedStyleWhitelist", computed_style_whitelist},
        {"includeEventListeners", include_event_listeners},
        {"includePaintOrder", include_paint_order},
        {"includeUserAgentShadowTree", include_user_agent_shadow_tree}
      ])

    {"DOMSnapshot.getSnapshot", params}
  end

  @doc """
  Returns a document snapshot, including the full DOM tree of the root node (including iframes,
  template contents, and imported documents) in a flattened array, as well as layout and
  white-listed computed style information for the nodes. Shadow DOM in the returned DOM tree is
  flattened.
  ## Parameters:
    - `computed_styles`:Whitelist of computed styles to return.
  - `include_paint_order`:(Optional) Whether to include layout object paint orders into the snapshot.
  - `include_dom_rects`:(Optional) Whether to include DOM rectangles (offsetRects, clientRects, scrollRects) into the snapshot
  - `include_blended_background_colors`:(Optional) Whether to include blended background colors in the snapshot (default: false).
  Blended background color is achieved by blending background colors of all elements
  that overlap with the current element.
  - `include_text_color_opacities`:(Optional) Whether to include text color opacity in the snapshot (default: false).
  An element might have the opacity property set that affects the text color of the element.
  The final text color opacity is computed based on the opacity of all overlapping elements.
  """
  @spec capture_snapshot(list(String.t()), boolean(), boolean(), boolean(), boolean()) ::
          {String.t(), map()}
  def capture_snapshot(
        computed_styles,
        include_paint_order \\ nil,
        include_dom_rects \\ nil,
        include_blended_background_colors \\ nil,
        include_text_color_opacities \\ nil
      ) do
    params =
      as_query([
        {"computedStyles", computed_styles},
        {"includePaintOrder", include_paint_order},
        {"includeDOMRects", include_dom_rects},
        {"includeBlendedBackgroundColors", include_blended_background_colors},
        {"includeTextColorOpacities", include_text_color_opacities}
      ])

    {"DOMSnapshot.captureSnapshot", params}
  end
end
