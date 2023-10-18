defmodule CDPotion.Domain.Accessibility do
  @doc """
  Disables the accessibility domain.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables the accessibility domain which causes `AXNodeId`s to remain consistent between method calls.
  This turns on accessibility for the page, which can impact performance until accessibility is disabled.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Fetches the accessibility node and partial accessibility tree for this DOM node, if it exists.
  ## Parameters:
    - `nodeId:DOM.NodeId`: (Optional) Identifier of the node to get the partial accessibility tree for.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Identifier of the backend node to get the partial accessibility tree for.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper to get the partial accessibility tree for.
    - `fetchRelatives:boolean`: (Optional) Whether to fetch this node's ancestors, siblings and children. Defaults to true.
  """
  def get_partial_ax_tree(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        fetch_relatives \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Fetches the entire accessibility tree for the root Document
  ## Parameters:
    - `depth:integer`: (Optional) The maximum depth at which descendants of the root node should be retrieved.
  If omitted, the full tree is returned.
    - `frameId:Page.FrameId`: (Optional) The frame for whose document the AX tree should be retrieved.
  If omited, the root frame is used.
  """
  def get_full_ax_tree(depth \\ nil, frame_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Fetches the root node.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `frameId:Page.FrameId`: (Optional) The frame in whose document the node resides.
  If omitted, the root frame is used.
  """
  def get_root_ax_node(frame_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Fetches a node and all ancestors up to and including the root.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `nodeId:DOM.NodeId`: (Optional) Identifier of the node to get.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Identifier of the backend node to get.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper to get.
  """
  def get_ax_node_and_ancestors(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Fetches a particular accessibility node by AXNodeId.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `id:AXNodeId`: description not provided :(
    - `frameId:Page.FrameId`: (Optional) The frame in whose document the node resides.
  If omitted, the root frame is used.
  """
  def get_child_ax_nodes(id, frame_id \\ nil) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Query a DOM node's accessibility subtree for accessible name and role.
  This command computes the name and role for all nodes in the subtree, including those that are
  ignored for accessibility, and returns those that mactch the specified name and role. If no DOM
  node is specified, or the DOM node does not exist, the command returns an error. If neither
  `accessibleName` or `role` is specified, it returns all the accessibility nodes in the subtree.
  ## Parameters:
    - `nodeId:DOM.NodeId`: (Optional) Identifier of the node for the root to query.
    - `backendNodeId:DOM.BackendNodeId`: (Optional) Identifier of the backend node for the root to query.
    - `objectId:Runtime.RemoteObjectId`: (Optional) JavaScript object id of the node wrapper for the root to query.
    - `accessibleName:string`: (Optional) Find nodes with this computed name.
    - `role:string`: (Optional) Find nodes with this computed role.
  """
  def query_ax_tree(
        node_id \\ nil,
        backend_node_id \\ nil,
        object_id \\ nil,
        accessible_name \\ nil,
        role \\ nil
      ) do
    execute(session, :navigate, %{"url" => url})
  end
end
