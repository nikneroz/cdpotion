defmodule CDPotion.Domain.DOMSnapshot do

@doc """
Disables DOM snapshot agent for the given page.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables DOM snapshot agent for the given page.
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
end
end