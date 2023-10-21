defmodule CDPotion.Domain.DOMSnapshot do
  use CDPotion.Utils
  @doc "Index of the string in the strings table."
  @type ArrayOfStrings :: list(StringIndex)

  @doc "A subset of the full ComputedStyle as defined by the request whitelist."
  @type ComputedStyle :: %{
          properties: list(DOMSnapshot.NameValue)
        }

  @doc "A Node in the DOM tree."
  @type DOMNode :: %{
          attributes: list(DOMSnapshot.NameValue) | nil,
          backendNodeId: DOM.BackendNodeId,
          baseURL: String.t() | nil,
          childNodeIndexes: list(integer()) | nil,
          contentDocumentIndex: integer() | nil,
          contentLanguage: String.t() | nil,
          currentSourceURL: String.t() | nil,
          documentEncoding: String.t() | nil,
          documentURL: String.t() | nil,
          eventListeners: list(DOMDebugger.EventListener) | nil,
          frameId: Page.FrameId | nil,
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
          pseudoType: DOM.PseudoType | nil,
          publicId: String.t() | nil,
          scrollOffsetX: number() | nil,
          scrollOffsetY: number() | nil,
          shadowRootType: DOM.ShadowRootType | nil,
          systemId: String.t() | nil,
          textValue: String.t() | nil
        }

  @doc "Document snapshot."
  @type DocumentSnapshot :: %{
          baseURL: DOMSnapshot.StringIndex,
          contentHeight: number() | nil,
          contentLanguage: DOMSnapshot.StringIndex,
          contentWidth: number() | nil,
          documentURL: DOMSnapshot.StringIndex,
          encodingName: DOMSnapshot.StringIndex,
          frameId: DOMSnapshot.StringIndex,
          layout: DOMSnapshot.LayoutTreeSnapshot,
          nodes: DOMSnapshot.NodeTreeSnapshot,
          publicId: DOMSnapshot.StringIndex,
          scrollOffsetX: number() | nil,
          scrollOffsetY: number() | nil,
          systemId: DOMSnapshot.StringIndex,
          textBoxes: DOMSnapshot.TextBoxSnapshot,
          title: DOMSnapshot.StringIndex
        }

  @doc "Details of post layout rendered text positions. The exact layout should not be regarded as
stable and may change between versions."
  @type InlineTextBox :: %{
          boundingBox: DOM.Rect,
          numCharacters: integer(),
          startCharacterIndex: integer()
        }

  @doc "Details of an element in the DOM tree with a LayoutObject."
  @type LayoutTreeNode :: %{
          boundingBox: DOM.Rect,
          domNodeIndex: integer(),
          inlineTextNodes: list(DOMSnapshot.InlineTextBox) | nil,
          isStackingContext: boolean() | nil,
          layoutText: String.t() | nil,
          paintOrder: integer() | nil,
          styleIndex: integer() | nil
        }

  @doc "Table of details of an element in the DOM tree with a LayoutObject."
  @type LayoutTreeSnapshot :: %{
          blendedBackgroundColors: list(DOMSnapshot.StringIndex) | nil,
          bounds: list(DOMSnapshot.Rectangle),
          clientRects: list(DOMSnapshot.Rectangle) | nil,
          nodeIndex: list(integer()),
          offsetRects: list(DOMSnapshot.Rectangle) | nil,
          paintOrders: list(integer()) | nil,
          scrollRects: list(DOMSnapshot.Rectangle) | nil,
          stackingContexts: DOMSnapshot.RareBooleanData,
          styles: list(DOMSnapshot.ArrayOfStrings),
          text: list(DOMSnapshot.StringIndex),
          textColorOpacities: list(number()) | nil
        }

  @doc "A name/value pair."
  @type NameValue :: %{
          name: String.t(),
          value: String.t()
        }

  @doc "Table containing nodes."
  @type NodeTreeSnapshot :: %{
          attributes: list(DOMSnapshot.ArrayOfStrings) | nil,
          backendNodeId: list(DOM.BackendNodeId) | nil,
          contentDocumentIndex: DOMSnapshot.RareIntegerData | nil,
          currentSourceURL: DOMSnapshot.RareStringData | nil,
          inputChecked: DOMSnapshot.RareBooleanData | nil,
          inputValue: DOMSnapshot.RareStringData | nil,
          isClickable: DOMSnapshot.RareBooleanData | nil,
          nodeName: list(DOMSnapshot.StringIndex) | nil,
          nodeType: list(integer()) | nil,
          nodeValue: list(DOMSnapshot.StringIndex) | nil,
          optionSelected: DOMSnapshot.RareBooleanData | nil,
          originURL: DOMSnapshot.RareStringData | nil,
          parentIndex: list(integer()) | nil,
          pseudoIdentifier: DOMSnapshot.RareStringData | nil,
          pseudoType: DOMSnapshot.RareStringData | nil,
          shadowRootType: DOMSnapshot.RareStringData | nil,
          textValue: DOMSnapshot.RareStringData | nil
        }

  @doc "description not provided :("
  @type RareBooleanData :: %{
          index: list(integer())
        }

  @doc "description not provided :("
  @type RareIntegerData :: %{
          index: list(integer()),
          value: list(integer())
        }

  @doc "Data that is only present on rare nodes."
  @type RareStringData :: %{
          index: list(integer()),
          value: list(DOMSnapshot.StringIndex)
        }

  @doc "description not provided :("
  @type Rectangle :: list(number())

  @doc "Index of the string in the strings table."
  @type StringIndex :: integer()

  @doc "Table of details of the post layout rendered text positions. The exact layout should not be regarded as
stable and may change between versions."
  @type TextBoxSnapshot :: %{
          bounds: list(DOMSnapshot.Rectangle),
          layoutIndex: list(integer()),
          length: list(integer()),
          start: list(integer())
        }

  @doc """
  Disables DOM snapshot agent for the given page.
  """
  def disable() do
    {"DOMSnapshot.disable", %{}}
  end

  @doc """
  Enables DOM snapshot agent for the given page.
  """
  def enable() do
    {"DOMSnapshot.enable", %{}}
  end

  @doc """
  Returns a document snapshot, including the full DOM tree of the root node (including iframes,
  template contents, and imported documents) in a flattened array, as well as layout and
  white-listed computed style information for the nodes. Shadow DOM in the returned DOM tree is
  flattened.
  ## Parameters:
    - `computedStyleWhitelist:array`: Whitelist of computed styles to return.
    - `includeEventListeners:boolean`: (Optional) Whether or not to retrieve details of DOM listeners (default false).
    - `includePaintOrder:boolean`: (Optional) Whether to determine and include the paint order index of LayoutTreeNodes (default false).
    - `includeUserAgentShadowTree:boolean`: (Optional) Whether to include UA shadow tree in the snapshot (default false).
  """
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
    - `computedStyles:array`: Whitelist of computed styles to return.
    - `includePaintOrder:boolean`: (Optional) Whether to include layout object paint orders into the snapshot.
    - `includeDOMRects:boolean`: (Optional) Whether to include DOM rectangles (offsetRects, clientRects, scrollRects) into the snapshot
    - `includeBlendedBackgroundColors:boolean`: (Optional) Whether to include blended background colors in the snapshot (default: false).
  Blended background color is achieved by blending background colors of all elements
  that overlap with the current element.
    - `includeTextColorOpacities:boolean`: (Optional) Whether to include text color opacity in the snapshot (default: false).
  An element might have the opacity property set that affects the text color of the element.
  The final text color opacity is computed based on the opacity of all overlapping elements.
  """
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
