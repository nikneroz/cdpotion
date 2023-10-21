defmodule CDPotion.Domain.Accessibility do
  use CDPotion.Utils
  @doc "A node in the accessibility tree."
  @type AXNode :: %{
          backendDOMNodeId: DOM.BackendNodeId | nil,
          childIds: list(Accessibility.AXNodeId) | nil,
          chromeRole: Accessibility.AXValue | nil,
          description: Accessibility.AXValue | nil,
          frameId: Page.FrameId | nil,
          ignored: boolean(),
          ignoredReasons: list(Accessibility.AXProperty) | nil,
          name: Accessibility.AXValue | nil,
          nodeId: Accessibility.AXNodeId,
          parentId: Accessibility.AXNodeId | nil,
          properties: list(Accessibility.AXProperty) | nil,
          role: Accessibility.AXValue | nil,
          value: Accessibility.AXValue | nil
        }

  @doc "Unique accessibility node identifier."
  @type AXNodeId :: String.t()

  @doc "description not provided :("
  @type AXProperty :: %{
          name: Accessibility.AXPropertyName,
          value: Accessibility.AXValue
        }

  @doc "Values of AXProperty name:
- from 'busy' to 'roledescription': states which apply to every AX node
- from 'live' to 'root': attributes which apply to nodes in live regions
- from 'autocomplete' to 'valuetext': attributes which apply to widgets
- from 'checked' to 'selected': states which apply to widgets
- from 'activedescendant' to 'owns' - relationships between elements other than parent/child/sibling."
  @type AXPropertyName ::
          :busy
          | :disabled
          | :editable
          | :focusable
          | :focused
          | :hidden
          | :hiddenRoot
          | :invalid
          | :keyshortcuts
          | :settable
          | :roledescription
          | :live
          | :atomic
          | :relevant
          | :root
          | :autocomplete
          | :hasPopup
          | :level
          | :multiselectable
          | :orientation
          | :multiline
          | :readonly
          | :required
          | :valuemin
          | :valuemax
          | :valuetext
          | :checked
          | :expanded
          | :modal
          | :pressed
          | :selected
          | :activedescendant
          | :controls
          | :describedby
          | :details
          | :errormessage
          | :flowto
          | :labelledby
          | :owns

  @doc "description not provided :("
  @type AXRelatedNode :: %{
          backendDOMNodeId: DOM.BackendNodeId,
          idref: String.t() | nil,
          text: String.t() | nil
        }

  @doc "A single computed AX property."
  @type AXValue :: %{
          relatedNodes: list(Accessibility.AXRelatedNode) | nil,
          sources: list(Accessibility.AXValueSource) | nil,
          type: Accessibility.AXValueType,
          value: any() | nil
        }

  @doc "Enum of possible native property sources (as a subtype of a particular AXValueSourceType)."
  @type AXValueNativeSourceType ::
          :description
          | :figcaption
          | :label
          | :labelfor
          | :labelwrapped
          | :legend
          | :rubyannotation
          | :tablecaption
          | :title
          | :other

  @doc "A single source for a computed AX property."
  @type AXValueSource :: %{
          attribute: String.t() | nil,
          attributeValue: Accessibility.AXValue | nil,
          invalid: boolean() | nil,
          invalidReason: String.t() | nil,
          nativeSource: Accessibility.AXValueNativeSourceType | nil,
          nativeSourceValue: Accessibility.AXValue | nil,
          superseded: boolean() | nil,
          type: Accessibility.AXValueSourceType,
          value: Accessibility.AXValue | nil
        }

  @doc "Enum of possible property sources."
  @type AXValueSourceType ::
          :attribute | :implicit | :style | :contents | :placeholder | :relatedElement

  @doc "Enum of possible property types."
  @type AXValueType ::
          :boolean
          | :tristate
          | :booleanOrUndefined
          | :idref
          | :idrefList
          | :integer
          | :node
          | :nodeList
          | :number
          | :string
          | :computedString
          | :token
          | :tokenList
          | :domRelation
          | :role
          | :internalRole
          | :valueUndefined

  @doc """
  Disables the accessibility domain.
  """
  def disable() do
    {"Accessibility.disable", %{}}
  end

  @doc """
  Enables the accessibility domain which causes `AXNodeId`s to remain consistent between method calls.
  This turns on accessibility for the page, which can impact performance until accessibility is disabled.
  """
  def enable() do
    {"Accessibility.enable", %{}}
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
    params =
      as_query([
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id},
        {"fetchRelatives", fetch_relatives}
      ])

    {"Accessibility.getPartialAXTree", params}
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
    params = as_query([{"depth", depth}, {"frameId", frame_id}])
    {"Accessibility.getFullAXTree", params}
  end

  @doc """
  Fetches the root node.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `frameId:Page.FrameId`: (Optional) The frame in whose document the node resides.
  If omitted, the root frame is used.
  """
  def get_root_ax_node(frame_id \\ nil) do
    params = as_query([{"frameId", frame_id}])
    {"Accessibility.getRootAXNode", params}
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
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"Accessibility.getAXNodeAndAncestors", params}
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
    params = as_query([{"id", id}, {"frameId", frame_id}])
    {"Accessibility.getChildAXNodes", params}
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
    params =
      as_query([
        {"nodeId", node_id},
        {"backendNodeId", backend_node_id},
        {"objectId", object_id},
        {"accessibleName", accessible_name},
        {"role", role}
      ])

    {"Accessibility.queryAXTree", params}
  end
end
