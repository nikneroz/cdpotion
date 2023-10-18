defmodule CDPotion.Domain.DOM do
  @doc """
  Collects class names for the node with given id and all of it's child nodes.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to collect class names.
  """
  def collect_class_names_from_subtree(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Creates a deep copy of the specified node and places it into the target container before the
  given anchor.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to copy.
    - `targetNodeId:NodeId`: Id of the element to drop the copy into.
    - `insertBeforeNodeId:NodeId`: (Optional) Drop the copy before this node (if absent, the copy becomes the last child of
  `targetNodeId`).
  """
  def copy_to(node_id, target_node_id, insert_before_node_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Describes node given its id, does not require domain to be enabled. Does not start tracking any
  objects, can be used for automation.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
    - `depth:integer`: (Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  def describe_node(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        depth \\ nil,
        pierce \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Scrolls the specified rect of the given node into view if not already visible.
  Note: exactly one between nodeId, backendNodeId and objectId should be passed
  to identify the node.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
    - `rect:Rect`: (Optional) The rect to be scrolled into view, relative to the node's border box, in CSS pixels.
  When omitted, center of the node will be used, similar to Element.scrollIntoView.
  """
  def scroll_into_view_if_needed(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        rect \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables DOM agent for the given page.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Discards search results from the session with the given id. `getSearchResults` should no longer
  be called for that search.
  ## Parameters:
  - `searchId:string`: Unique search session identifier.
  """
  def discard_search_results(search_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables DOM agent for the given page.
  ## Parameters:
  - `includeWhitespace:string`: (Optional) Whether to include whitespaces in the children array of returned Nodes.
  """
  def enable(include_whitespace \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Focuses the given element.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
  """
  def focus(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns attributes for the specified node.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to retrieve attibutes for.
  """
  def get_attributes(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns boxes for the given node.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
  """
  def get_box_model(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns quads that describe node position on the page. This method
  might return multiple quads for inline nodes.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
  """
  def get_content_quads(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the root DOM node (and optionally the subtree) to the caller.
  Implicitly enables the DOM domain events for the current target.
  ## Parameters:
  - `depth:integer`: (Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  def get_document(depth \\ nil, pierce \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the root DOM node (and optionally the subtree) to the caller.
  Deprecated, as it is not designed to work well with the rest of the DOM agent.
  Use DOMSnapshot.captureSnapshot instead.
  ## Parameters:
  - `depth:integer`: (Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots should be traversed when returning the subtree
  (default is false).
  """
  def get_flattened_document(depth \\ nil, pierce \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Finds nodes with a given computed style in a subtree.
  ## Parameters:
  - `nodeId:NodeId`: Node ID pointing to the root of a subtree.
    - `computedStyles:array`: The style to filter nodes by (includes nodes if any of properties matches).
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots in the same target should be traversed when returning the
  results (default is false).
  """
  def get_nodes_for_subtree_by_style(node_id, computed_styles, pierce \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns node id at given location. Depending on whether DOM domain is enabled, nodeId is
  either returned or not.
  ## Parameters:
  - `x:integer`: X coordinate.
    - `y:integer`: Y coordinate.
    - `includeUserAgentShadowDOM:boolean`: (Optional) False to skip to the nearest non-UA shadow root ancestor (default: false).
    - `ignorePointerEventsNone:boolean`: (Optional) Whether to ignore pointer-events: none on elements and hit test them.
  """
  def get_node_for_location(
        x,
        y,
        include_user_agent_shadow_do_m \\ nil,
        ignore_pointer_events_none \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns node's HTML markup.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
  """
  def get_outer_html(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the id of the nearest ancestor that is a relayout boundary.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node.
  """
  def get_relayout_boundary(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns search results from given `fromIndex` to given `toIndex` from the search with the given
  identifier.
  ## Parameters:
  - `searchId:string`: Unique search session identifier.
    - `fromIndex:integer`: Start index of the search result to be returned.
    - `toIndex:integer`: End index of the search result to be returned.
  """
  def get_search_results(search_id, from_index, to_index) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Hides any highlight.
  """
  def hide_highlight() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Highlights DOM node.
  """
  def highlight_node() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Highlights given rectangle.
  """
  def highlight_rect() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Marks last undoable state.
  """
  def mark_undoable_state() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Moves node into the new container, places it before the given anchor.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to move.
    - `targetNodeId:NodeId`: Id of the element to drop the moved node into.
    - `insertBeforeNodeId:NodeId`: (Optional) Drop node before this one (if absent, the moved node becomes the last child of
  `targetNodeId`).
  """
  def move_to(node_id, target_node_id, insert_before_node_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Searches for a given string in the DOM tree. Use `getSearchResults` to access search results or
  `cancelSearch` to end this search session.
  ## Parameters:
  - `query:string`: Plain text or query selector or XPath search query.
    - `includeUserAgentShadowDOM:boolean`: (Optional) True to search in user agent shadow DOM.
  """
  def perform_search(query, include_user_agent_shadow_do_m \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that the node is sent to the caller given its path. // FIXME, use XPath
  ## Parameters:
  - `path:string`: Path to node in the proprietary format.
  """
  def push_node_by_path_to_frontend(path) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that a batch of nodes is sent to the caller given their backend node ids.
  ## Parameters:
  - `backendNodeIds:array`: The array of backend node ids.
  """
  def push_nodes_by_backend_ids_to_frontend(backend_node_ids) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Executes `querySelector` on a given node.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to query upon.
    - `selector:string`: Selector string.
  """
  def query_selector(node_id, selector) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Executes `querySelectorAll` on a given node.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to query upon.
    - `selector:string`: Selector string.
  """
  def query_selector_all(node_id, selector) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns NodeIds of current top layer elements.
  Top layer is rendered closest to the user within a viewport, therefore its elements always
  appear on top of all other content.
  """
  def get_top_layer_elements() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Re-does the last undone action.
  """
  def redo() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes attribute with given name from an element with given id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the element to remove attribute from.
    - `name:string`: Name of the attribute to remove.
  """
  def remove_attribute(node_id, name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Removes node with given id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to remove.
  """
  def remove_node(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that children of the node with given id are returned to the caller in form of
  `setChildNodes` events where not only immediate children are retrieved, but all children down to
  the specified depth.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to get children for.
    - `depth:integer`: (Optional) The maximum depth at which children should be retrieved, defaults to 1. Use -1 for the
  entire subtree or provide an integer larger than 0.
    - `pierce:boolean`: (Optional) Whether or not iframes and shadow roots should be traversed when returning the sub-tree
  (default is false).
  """
  def request_child_nodes(node_id, depth \\ nil, pierce \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Requests that the node is sent to the caller given the JavaScript node object reference. All
  nodes that form the path from the node to the root are also sent to the client as a series of
  `setChildNodes` notifications.
  ## Parameters:
  - `objectId:Runtime.RemoteObjectId`: JavaScript object id to convert into node.
  """
  def request_node(object_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Resolves the JavaScript node object for a given NodeId or BackendNodeId.
  ## Parameters:
  - `nodeId:NodeId`: (Optional) Id of the node to resolve.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Backend identifier of the node to resolve.
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects.
    - `executionContextId:Runtime.ExecutionContextId`: (Optional) Execution context in which to resolve the node.
  """
  def resolve_node(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_group \\ nil,
        execution_context_id \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets attribute for an element with given id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the element to set attribute for.
    - `name:string`: Attribute name.
    - `value:string`: Attribute value.
  """
  def set_attribute_value(node_id, name, value) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets attributes on element with given id. This method is useful when user edits some existing
  attribute value and types in several attribute name/value pairs.
  ## Parameters:
  - `nodeId:NodeId`: Id of the element to set attributes for.
    - `text:string`: Text with a number of attributes. Will parse this text using HTML parser.
    - `name:string`: (Optional) Attribute name to replace with new attributes derived from text in case text parsed
  successfully.
  """
  def set_attributes_as_text(node_id, text, name \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets files for the given file input element.
  ## Parameters:
  - `files:array`: Array of file paths to set.
    - `nodeId:NodeId`: (Optional) Identifier of the node.
    - `backendNodeId:BackendNodeId`: (Optional) Identifier of the backend node.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper.
  """
  def set_file_input_files(files, node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets if stack traces should be captured for Nodes. See `Node.getNodeStackTraces`. Default is disabled.
  ## Parameters:
  - `enable:boolean`: Enable or disable.
  """
  def set_node_stack_traces_enabled(enable) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets stack traces associated with a Node. As of now, only provides stack trace for Node creation.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to get stack traces for.
  """
  def get_node_stack_traces(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns file information for the given
  File wrapper.
  ## Parameters:
  - `objectId:Runtime.RemoteObjectId`: JavaScript object id of the node wrapper.
  """
  def get_file_info(object_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables console to refer to the node with given id via $x (see Command Line API for more details
  $x functions).
  ## Parameters:
  - `nodeId:NodeId`: DOM node id to be accessible by means of $x command line API.
  """
  def set_inspected_node(node_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets node name for a node with given id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to set name for.
    - `name:string`: New node's name.
  """
  def set_node_name(node_id, name) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets node value for a node with given id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to set value for.
    - `value:string`: New node's value.
  """
  def set_node_value(node_id, value) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets node HTML markup, returns new node id.
  ## Parameters:
  - `nodeId:NodeId`: Id of the node to set markup for.
    - `outerHTML:string`: Outer HTML markup to set.
  """
  def set_outer_html(node_id, outer_html) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Undoes the last performed action.
  """
  def undo() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns iframe node that owns iframe with the given domain.
  ## Parameters:
  - `frameId:Page.FrameId`: description not provided :(
  """
  def get_frame_owner(frame_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the query container of the given node based on container query
  conditions: containerName, physical, and logical axes. If no axes are
  provided, the style container is returned, which is the direct parent or the
  closest element with a matching container-name.
  ## Parameters:
  - `nodeId:NodeId`: description not provided :(
    - `containerName:string`: (Optional) description not provided :(
    - `physicalAxes:PhysicalAxes`: (Optional) description not provided :(
    - `logicalAxes:LogicalAxes`: (Optional) description not provided :(
  """
  def get_container_for_node(
        node_id,
        container_name \\ nil,
        physical_axes \\ nil,
        logical_axes \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the descendants of a container query container that have
  container queries against this container.
  ## Parameters:
  - `nodeId:NodeId`: Id of the container node to find querying descendants from.
  """
  def get_querying_descendants_for_container(node_id) do
    execute(session, :navigate, %{"url" => url})
  end
end
