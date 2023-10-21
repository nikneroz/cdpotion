defmodule CDPotion.Domain.DOM do
  use CDPotion.Utils
  @typedoc "Backend node with a friendly name."
  @type backend_node :: %{
          backendNodeId: CDPotion.Domain.DOM.backend_node_id(),
          nodeName: String.t(),
          nodeType: integer()
        }

  @typedoc "Unique DOM node identifier used to reference a node that may not have been pushed to the
front-end."
  @type backend_node_id :: integer()

  @typedoc "Box model."
  @type box_model :: %{
          border: CDPotion.Domain.DOM.quad(),
          content: CDPotion.Domain.DOM.quad(),
          height: integer(),
          margin: CDPotion.Domain.DOM.quad(),
          padding: CDPotion.Domain.DOM.quad(),
          shapeOutside: CDPotion.Domain.DOM.shape_outside_info() | nil,
          width: integer()
        }

  @typedoc "description not provided :("
  @type css_computed_style_property :: %{
          name: String.t(),
          value: String.t()
        }

  @typedoc "Document compatibility mode."
  @type compatibility_mode :: :QuirksMode | :LimitedQuirksMode | :NoQuirksMode

  @typedoc "ContainerSelector logical axes"
  @type logical_axes :: :Inline | :Block | :Both

  @typedoc "DOM interaction is implemented in terms of mirror objects that represent the actual DOM nodes.
DOMNode is a base node mirror type."
  @type node_element :: %{
          assignedSlot: CDPotion.Domain.DOM.backend_node() | nil,
          attributes: list(String.t()) | nil,
          backendNodeId: CDPotion.Domain.DOM.backend_node_id(),
          baseURL: String.t() | nil,
          childNodeCount: integer() | nil,
          children: list(CDPotion.Domain.DOM.node_element()) | nil,
          compatibilityMode: CDPotion.Domain.DOM.compatibility_mode() | nil,
          contentDocument: CDPotion.Domain.DOM.node_element() | nil,
          distributedNodes: list(CDPotion.Domain.DOM.backend_node()) | nil,
          documentURL: String.t() | nil,
          frameId: CDPotion.Domain.Page.frame_id() | nil,
          importedDocument: CDPotion.Domain.DOM.node_element() | nil,
          internalSubset: String.t() | nil,
          isSVG: boolean() | nil,
          localName: String.t(),
          name: String.t() | nil,
          nodeId: CDPotion.Domain.DOM.node_id(),
          nodeName: String.t(),
          nodeType: integer(),
          nodeValue: String.t(),
          parentId: CDPotion.Domain.DOM.node_id() | nil,
          pseudoElements: list(CDPotion.Domain.DOM.node_element()) | nil,
          pseudoIdentifier: String.t() | nil,
          pseudoType: CDPotion.Domain.DOM.pseudo_type() | nil,
          publicId: String.t() | nil,
          shadowRootType: CDPotion.Domain.DOM.shadow_root_type() | nil,
          shadowRoots: list(CDPotion.Domain.DOM.node_element()) | nil,
          systemId: String.t() | nil,
          templateContent: CDPotion.Domain.DOM.node_element() | nil,
          value: String.t() | nil,
          xmlVersion: String.t() | nil
        }

  @typedoc "Unique DOM node identifier."
  @type node_id :: integer()

  @typedoc "ContainerSelector physical axes"
  @type physical_axes :: :Horizontal | :Vertical | :Both

  @typedoc "Pseudo element type."
  @type pseudo_type ::
          :"first-line"
          | :"first-letter"
          | :before
          | :after
          | :marker
          | :backdrop
          | :selection
          | :"target-text"
          | :"spelling-error"
          | :"grammar-error"
          | :highlight
          | :"first-line-inherited"
          | :scrollbar
          | :"scrollbar-thumb"
          | :"scrollbar-button"
          | :"scrollbar-track"
          | :"scrollbar-track-piece"
          | :"scrollbar-corner"
          | :resizer
          | :"input-list-button"
          | :"view-transition"
          | :"view-transition-group"
          | :"view-transition-image-pair"
          | :"view-transition-old"
          | :"view-transition-new"

  @typedoc "An array of quad vertices, x immediately followed by y for each point, points clock-wise."
  @type quad :: list(number())

  @typedoc "A structure holding an RGBA color."
  @type rgba :: %{
          a: number() | nil,
          b: integer(),
          g: integer(),
          r: integer()
        }

  @typedoc "Rectangle."
  @type rect :: %{
          height: number(),
          width: number(),
          x: number(),
          y: number()
        }

  @typedoc "Shadow root type."
  @type shadow_root_type :: :"user-agent" | :open | :closed

  @typedoc "CSS Shape Outside details."
  @type shape_outside_info :: %{
          bounds: CDPotion.Domain.DOM.quad(),
          marginShape: list(any()),
          shape: list(any())
        }

  @doc """
  Collects class names for the node with given id and all of it's child nodes.
  ## Parameters:
    - `node_id`:Id of the node to collect class names.
  """
  @spec collect_class_names_from_subtree(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def collect_class_names_from_subtree(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.collectClassNamesFromSubtree", params}
  end

  @doc """
  Creates a deep copy of the specified node and places it into the target container before the
  given anchor.
  ## Parameters:
    - `node_id`:Id of the node to copy.
  - `target_node_id`:Id of the element to drop the copy into.
  - `insert_before_node_id`:(Optional) Drop the copy before this node (if absent, the copy becomes the last child of
  `targetNodeId`).
  """
  @spec copy_to(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.NodeId
        ) :: {String.t(), map()}
  def copy_to(node_id, target_node_id, insert_before_node_id \\ nil) do
    params =
      as_query([
        {"nodeId", node_id},
        {"targetNodeId", target_node_id},
        {"insertBeforeNodeId", insert_before_node_id}
      ])

    {"DOM.copyTo", params}
  end

  @doc """
  Describes node given its id, does not require domain to be enabled. Does not start tracking any
  objects, can be used for automation.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  - `depth`:(Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
  - `pierce`:(Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  @spec describe_node(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId,
          integer(),
          boolean()
        ) :: {String.t(), map()}
  def describe_node(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        depth \\ nil,
        pierce \\ nil
      ) do
    params =
      as_query([
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id},
        {"depth", depth},
        {"pierce", pierce}
      ])

    {"DOM.describeNode", params}
  end

  @doc """
  Scrolls the specified rect of the given node into view if not already visible.
  Note: exactly one between nodeId, backendNodeId and objectId should be passed
  to identify the node.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  - `rect`:(Optional) The rect to be scrolled into view, relative to the node's border box, in CSS pixels.
  When omitted, center of the node will be used, similar to Element.scrollIntoView.
  """
  @spec scroll_into_view_if_needed(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId,
          CDPotion.Domain.DOM.Rect
        ) :: {String.t(), map()}
  def scroll_into_view_if_needed(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        rect \\ nil
      ) do
    params =
      as_query([
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id},
        {"rect", rect}
      ])

    {"DOM.scrollIntoViewIfNeeded", params}
  end

  @doc """
  Disables DOM agent for the given page.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"DOM.disable", %{}}
  end

  @doc """
  Discards search results from the session with the given id. `getSearchResults` should no longer
  be called for that search.
  ## Parameters:
    - `search_id`:Unique search session identifier.
  """
  @spec discard_search_results(String.t()) :: {String.t(), map()}
  def discard_search_results(search_id) do
    params = as_query([{"searchId", search_id}])
    {"DOM.discardSearchResults", params}
  end

  @doc """
  Enables DOM agent for the given page.
  ## Parameters:
    - `include_whitespace`:(Optional) Whether to include whitespaces in the children array of returned Nodes.
  """
  @spec enable(String.t()) :: {String.t(), map()}
  def enable(include_whitespace \\ nil) do
    params = as_query([{"includeWhitespace", include_whitespace}])
    {"DOM.enable", params}
  end

  @doc """
  Focuses the given element.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  """
  @spec focus(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def focus(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"DOM.focus", params}
  end

  @doc """
  Returns attributes for the specified node.
  ## Parameters:
    - `node_id`:Id of the node to retrieve attibutes for.
  """
  @spec get_attributes(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def get_attributes(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.getAttributes", params}
  end

  @doc """
  Returns boxes for the given node.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  """
  @spec get_box_model(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def get_box_model(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"DOM.getBoxModel", params}
  end

  @doc """
  Returns quads that describe node position on the page. This method
  might return multiple quads for inline nodes.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  """
  @spec get_content_quads(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def get_content_quads(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"DOM.getContentQuads", params}
  end

  @doc """
  Returns the root DOM node (and optionally the subtree) to the caller.
  Implicitly enables the DOM domain events for the current target.
  ## Parameters:
    - `depth`:(Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
  - `pierce`:(Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  @spec get_document(integer(), boolean()) :: {String.t(), map()}
  def get_document(depth \\ nil, pierce \\ nil) do
    params = as_query([{"depth", depth}, {"pierce", pierce}])
    {"DOM.getDocument", params}
  end

  @doc """
  Returns the root DOM node (and optionally the subtree) to the caller.
  Deprecated, as it is not designed to work well with the rest of the DOM agent.
  Use DOMSnapshot.captureSnapshot instead.
  ## Parameters:
    - `depth`:(Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
  - `pierce`:(Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  @spec get_flattened_document(integer(), boolean()) :: {String.t(), map()}
  def get_flattened_document(depth \\ nil, pierce \\ nil) do
    params = as_query([{"depth", depth}, {"pierce", pierce}])
    {"DOM.getFlattenedDocument", params}
  end

  @doc """
  Finds nodes with a given computed style in a subtree.
  ## Parameters:
    - `node_id`:Node ID pointing to the root of a subtree.
  - `computed_styles`:The style to filter nodes by (includes nodes if any of properties matches).
  - `pierce`:(Optional) Whether or not iframes and shadow roots in the same target should be traversed when returning the
  results (default is false).
  """
  @spec get_nodes_for_subtree_by_style(
          CDPotion.Domain.DOM.NodeId,
          list(CDPotion.Domain.DOM.CSSComputedStyleProperty),
          boolean()
        ) :: {String.t(), map()}
  def get_nodes_for_subtree_by_style(node_id, computed_styles, pierce \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"computedStyles", computed_styles}, {"pierce", pierce}])

    {"DOM.getNodesForSubtreeByStyle", params}
  end

  @doc """
  Returns node id at given location. Depending on whether DOM domain is enabled, nodeId is
  either returned or not.
  ## Parameters:
    - `x`:X coordinate.
  - `y`:Y coordinate.
  - `include_user_agent_shadow_dom`:(Optional) False to skip to the nearest non-UA shadow root ancestor (default: false).
  - `ignore_pointer_events_none`:(Optional) Whether to ignore pointer-events: none on elements and hit test them.
  """
  @spec get_node_for_location(integer(), integer(), boolean(), boolean()) :: {String.t(), map()}
  def get_node_for_location(
        x,
        y,
        include_user_agent_shadow_dom \\ nil,
        ignore_pointer_events_none \\ nil
      ) do
    params =
      as_query([
        {"x", x},
        {"y", y},
        {"includeUserAgentShadowDOM", include_user_agent_shadow_dom},
        {"ignorePointerEventsNone", ignore_pointer_events_none}
      ])

    {"DOM.getNodeForLocation", params}
  end

  @doc """
  Returns node's HTML markup.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  """
  @spec get_outer_html(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def get_outer_html(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"DOM.getOuterHTML", params}
  end

  @doc """
  Returns the id of the nearest ancestor that is a relayout boundary.
  ## Parameters:
    - `node_id`:Id of the node.
  """
  @spec get_relayout_boundary(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def get_relayout_boundary(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.getRelayoutBoundary", params}
  end

  @doc """
  Returns search results from given `fromIndex` to given `toIndex` from the search with the given
  identifier.
  ## Parameters:
    - `search_id`:Unique search session identifier.
  - `from_index`:Start index of the search result to be returned.
  - `to_index`:End index of the search result to be returned.
  """
  @spec get_search_results(String.t(), integer(), integer()) :: {String.t(), map()}
  def get_search_results(search_id, from_index, to_index) do
    params = as_query([{"searchId", search_id}, {"fromIndex", from_index}, {"toIndex", to_index}])
    {"DOM.getSearchResults", params}
  end

  @doc """
  Hides any highlight.
  """
  @spec hide_highlight() :: {String.t(), map()}
  def hide_highlight() do
    {"DOM.hideHighlight", %{}}
  end

  @doc """
  Highlights DOM node.
  """
  @spec highlight_node() :: {String.t(), map()}
  def highlight_node() do
    {"DOM.highlightNode", %{}}
  end

  @doc """
  Highlights given rectangle.
  """
  @spec highlight_rect() :: {String.t(), map()}
  def highlight_rect() do
    {"DOM.highlightRect", %{}}
  end

  @doc """
  Marks last undoable state.
  """
  @spec mark_undoable_state() :: {String.t(), map()}
  def mark_undoable_state() do
    {"DOM.markUndoableState", %{}}
  end

  @doc """
  Moves node into the new container, places it before the given anchor.
  ## Parameters:
    - `node_id`:Id of the node to move.
  - `target_node_id`:Id of the element to drop the moved node into.
  - `insert_before_node_id`:(Optional) Drop node before this one (if absent, the moved node becomes the last child of
  `targetNodeId`).
  """
  @spec move_to(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.NodeId
        ) :: {String.t(), map()}
  def move_to(node_id, target_node_id, insert_before_node_id \\ nil) do
    params =
      as_query([
        {"nodeId", node_id},
        {"targetNodeId", target_node_id},
        {"insertBeforeNodeId", insert_before_node_id}
      ])

    {"DOM.moveTo", params}
  end

  @doc """
  Searches for a given string in the DOM tree. Use `getSearchResults` to access search results or
  `cancelSearch` to end this search session.
  ## Parameters:
    - `query`:Plain text or query selector or XPath search query.
  - `include_user_agent_shadow_dom`:(Optional) True to search in user agent shadow DOM.
  """
  @spec perform_search(String.t(), boolean()) :: {String.t(), map()}
  def perform_search(query, include_user_agent_shadow_dom \\ nil) do
    params =
      as_query([{"query", query}, {"includeUserAgentShadowDOM", include_user_agent_shadow_dom}])

    {"DOM.performSearch", params}
  end

  @doc """
  Requests that the node is sent to the caller given its path. // FIXME, use XPath
  ## Parameters:
    - `path`:Path to node in the proprietary format.
  """
  @spec push_node_by_path_to_frontend(String.t()) :: {String.t(), map()}
  def push_node_by_path_to_frontend(path) do
    params = as_query([{"path", path}])
    {"DOM.pushNodeByPathToFrontend", params}
  end

  @doc """
  Requests that a batch of nodes is sent to the caller given their backend node ids.
  ## Parameters:
    - `backend_node_ids`:The array of backend node ids.
  """
  @spec push_nodes_by_backend_ids_to_frontend(list(CDPotion.Domain.DOM.BackendNodeId)) ::
          {String.t(), map()}
  def push_nodes_by_backend_ids_to_frontend(backend_node_ids) do
    params = as_query([{"backendNodeIds", backend_node_ids}])
    {"DOM.pushNodesByBackendIdsToFrontend", params}
  end

  @doc """
  Executes `querySelector` on a given node.
  ## Parameters:
    - `node_id`:Id of the node to query upon.
  - `selector`:Selector string.
  """
  @spec query_selector(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def query_selector(node_id, selector) do
    params = as_query([{"nodeId", node_id}, {"selector", selector}])
    {"DOM.querySelector", params}
  end

  @doc """
  Executes `querySelectorAll` on a given node.
  ## Parameters:
    - `node_id`:Id of the node to query upon.
  - `selector`:Selector string.
  """
  @spec query_selector_all(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def query_selector_all(node_id, selector) do
    params = as_query([{"nodeId", node_id}, {"selector", selector}])
    {"DOM.querySelectorAll", params}
  end

  @doc """
  Returns NodeIds of current top layer elements.
  Top layer is rendered closest to the user within a viewport, therefore its elements always
  appear on top of all other content.
  """
  @spec get_top_layer_elements() :: {String.t(), map()}
  def get_top_layer_elements() do
    {"DOM.getTopLayerElements", %{}}
  end

  @doc """
  Re-does the last undone action.
  """
  @spec redo() :: {String.t(), map()}
  def redo() do
    {"DOM.redo", %{}}
  end

  @doc """
  Removes attribute with given name from an element with given id.
  ## Parameters:
    - `node_id`:Id of the element to remove attribute from.
  - `name`:Name of the attribute to remove.
  """
  @spec remove_attribute(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def remove_attribute(node_id, name) do
    params = as_query([{"nodeId", node_id}, {"name", name}])
    {"DOM.removeAttribute", params}
  end

  @doc """
  Removes node with given id.
  ## Parameters:
    - `node_id`:Id of the node to remove.
  """
  @spec remove_node(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def remove_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.removeNode", params}
  end

  @doc """
  Requests that children of the node with given id are returned to the caller in form of
  `setChildNodes` events where not only immediate children are retrieved, but all children down to
  the specified depth.
  ## Parameters:
    - `node_id`:Id of the node to get children for.
  - `depth`:(Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
  - `pierce`:(Optional) Whether or not iframes and shadow roots should be traversed when returning the sub-tree
  (default is false).
  """
  @spec request_child_nodes(CDPotion.Domain.DOM.NodeId, integer(), boolean()) ::
          {String.t(), map()}
  def request_child_nodes(node_id, depth \\ nil, pierce \\ nil) do
    params = as_query([{"nodeId", node_id}, {"depth", depth}, {"pierce", pierce}])
    {"DOM.requestChildNodes", params}
  end

  @doc """
  Requests that the node is sent to the caller given the JavaScript node object reference. All
  nodes that form the path from the node to the root are also sent to the client as a series of
  `setChildNodes` notifications.
  ## Parameters:
    - `object_id`:JavaScript object id to convert into node.
  """
  @spec request_node(CDPotion.Domain.Runtime.RemoteObjectId) :: {String.t(), map()}
  def request_node(object_id) do
    params = as_query([{"objectId", object_id}])
    {"DOM.requestNode", params}
  end

  @doc """
  Resolves the JavaScript node object for a given NodeId or BackendNodeId.
  ## Parameters:
    - `node_id`:(Optional) Id of the node to resolve.
  - `backend_node_id`:(Optional) Backend identifier of the node to resolve.
  - `object_group`:(Optional) Symbolic group name that can be used to release multiple objects.
  - `execution_context_id`:(Optional) Execution context in which to resolve the node.
  """
  @spec resolve_node(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          String.t(),
          CDPotion.Domain.Runtime.ExecutionContextId
        ) :: {String.t(), map()}
  def resolve_node(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_group \\ nil,
        execution_context_id \\ nil
      ) do
    params =
      as_query([
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectGroup", object_group},
        {"executionContextId", execution_context_id}
      ])

    {"DOM.resolveNode", params}
  end

  @doc """
  Sets attribute for an element with given id.
  ## Parameters:
    - `node_id`:Id of the element to set attribute for.
  - `name`:Attribute name.
  - `value`:Attribute value.
  """
  @spec set_attribute_value(CDPotion.Domain.DOM.NodeId, String.t(), String.t()) ::
          {String.t(), map()}
  def set_attribute_value(node_id, name, value) do
    params = as_query([{"nodeId", node_id}, {"name", name}, {"value", value}])
    {"DOM.setAttributeValue", params}
  end

  @doc """
  Sets attributes on element with given id. This method is useful when user edits some existing
  attribute value and types in several attribute name/value pairs.
  ## Parameters:
    - `node_id`:Id of the element to set attributes for.
  - `text`:Text with a number of attributes. Will parse this text using HTML parser.
  - `name`:(Optional) Attribute name to replace with new attributes derived from text in case text parsed
  successfully.
  """
  @spec set_attributes_as_text(CDPotion.Domain.DOM.NodeId, String.t(), String.t()) ::
          {String.t(), map()}
  def set_attributes_as_text(node_id, text, name \\ nil) do
    params = as_query([{"nodeId", node_id}, {"text", text}, {"name", name}])
    {"DOM.setAttributesAsText", params}
  end

  @doc """
  Sets files for the given file input element.
  ## Parameters:
    - `files`:Array of file paths to set.
  - `node_id`:(Optional) Identifier of the node.
  - `backend_node_id`:(Optional) Identifier of the backend node.
  - `object_id`:(Optional) JavaScript object id of the node wrapper.
  """
  @spec set_file_input_files(
          list(String.t()),
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def set_file_input_files(files, node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([
        {"files", files},
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id}
      ])

    {"DOM.setFileInputFiles", params}
  end

  @doc """
  Sets if stack traces should be captured for Nodes. See `Node.getNodeStackTraces`. Default is disabled.
  ## Parameters:
    - `enable`:Enable or disable.
  """
  @spec set_node_stack_traces_enabled(boolean()) :: {String.t(), map()}
  def set_node_stack_traces_enabled(enable) do
    params = as_query([{"enable", enable}])
    {"DOM.setNodeStackTracesEnabled", params}
  end

  @doc """
  Gets stack traces associated with a Node. As of now, only provides stack trace for Node creation.
  ## Parameters:
    - `node_id`:Id of the node to get stack traces for.
  """
  @spec get_node_stack_traces(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def get_node_stack_traces(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.getNodeStackTraces", params}
  end

  @doc """
  Returns file information for the given
  File wrapper.
  ## Parameters:
    - `object_id`:JavaScript object id of the node wrapper.
  """
  @spec get_file_info(CDPotion.Domain.Runtime.RemoteObjectId) :: {String.t(), map()}
  def get_file_info(object_id) do
    params = as_query([{"objectId", object_id}])
    {"DOM.getFileInfo", params}
  end

  @doc """
  Enables console to refer to the node with given id via $x (see Command Line API for more details
  $x functions).
  ## Parameters:
    - `node_id`:DOM node id to be accessible by means of $x command line API.
  """
  @spec set_inspected_node(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def set_inspected_node(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.setInspectedNode", params}
  end

  @doc """
  Sets node name for a node with given id.
  ## Parameters:
    - `node_id`:Id of the node to set name for.
  - `name`:New node's name.
  """
  @spec set_node_name(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def set_node_name(node_id, name) do
    params = as_query([{"nodeId", node_id}, {"name", name}])
    {"DOM.setNodeName", params}
  end

  @doc """
  Sets node value for a node with given id.
  ## Parameters:
    - `node_id`:Id of the node to set value for.
  - `value`:New node's value.
  """
  @spec set_node_value(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def set_node_value(node_id, value) do
    params = as_query([{"nodeId", node_id}, {"value", value}])
    {"DOM.setNodeValue", params}
  end

  @doc """
  Sets node HTML markup, returns new node id.
  ## Parameters:
    - `node_id`:Id of the node to set markup for.
  - `outer_html`:Outer HTML markup to set.
  """
  @spec set_outer_html(CDPotion.Domain.DOM.NodeId, String.t()) :: {String.t(), map()}
  def set_outer_html(node_id, outer_html) do
    params = as_query([{"nodeId", node_id}, {"outerHTML", outer_html}])
    {"DOM.setOuterHTML", params}
  end

  @doc """
  Undoes the last performed action.
  """
  @spec undo() :: {String.t(), map()}
  def undo() do
    {"DOM.undo", %{}}
  end

  @doc """
  Returns iframe node that owns iframe with the given domain.
  ## Parameters:
    - `frame_id`:description not provided :(
  """
  @spec get_frame_owner(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_frame_owner(frame_id) do
    params = as_query([{"frameId", frame_id}])
    {"DOM.getFrameOwner", params}
  end

  @doc """
  Returns the query container of the given node based on container query
  conditions: containerName, physical, and logical axes. If no axes are
  provided, the style container is returned, which is the direct parent or the
  closest element with a matching container-name.
  ## Parameters:
    - `node_id`:description not provided :(
  - `container_name`:(Optional) description not provided :(
  - `physical_axes`:(Optional) description not provided :(
  - `logical_axes`:(Optional) description not provided :(
  """
  @spec get_container_for_node(
          CDPotion.Domain.DOM.NodeId,
          String.t(),
          CDPotion.Domain.DOM.PhysicalAxes,
          CDPotion.Domain.DOM.LogicalAxes
        ) :: {String.t(), map()}
  def get_container_for_node(
        node_id,
        container_name \\ nil,
        physical_axes \\ nil,
        logical_axes \\ nil
      ) do
    params =
      as_query([
        {"nodeId", node_id},
        {"containerName", container_name},
        {"physicalAxes", physical_axes},
        {"logicalAxes", logical_axes}
      ])

    {"DOM.getContainerForNode", params}
  end

  @doc """
  Returns the descendants of a container query container that have
  container queries against this container.
  ## Parameters:
    - `node_id`:Id of the container node to find querying descendants from.
  """
  @spec get_querying_descendants_for_container(CDPotion.Domain.DOM.NodeId) :: {String.t(), map()}
  def get_querying_descendants_for_container(node_id) do
    params = as_query([{"nodeId", node_id}])
    {"DOM.getQueryingDescendantsForContainer", params}
  end
end
