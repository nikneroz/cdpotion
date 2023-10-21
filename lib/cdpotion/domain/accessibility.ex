defmodule CDPotion.Domain.Accessibility do
  use CDPotion.Utils
  @typedoc "A node in the accessibility tree."
  @type ax_node :: %{
          backendDOMNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          childIds: list(CDPotion.Domain.Accessibility.ax_node_id()) | nil,
          chromeRole: CDPotion.Domain.Accessibility.ax_value() | nil,
          description: CDPotion.Domain.Accessibility.ax_value() | nil,
          frameId: CDPotion.Domain.Page.frame_id() | nil,
          ignored: boolean(),
          ignoredReasons: list(CDPotion.Domain.Accessibility.ax_property()) | nil,
          name: CDPotion.Domain.Accessibility.ax_value() | nil,
          nodeId: CDPotion.Domain.Accessibility.ax_node_id(),
          parentId: CDPotion.Domain.Accessibility.ax_node_id() | nil,
          properties: list(CDPotion.Domain.Accessibility.ax_property()) | nil,
          role: CDPotion.Domain.Accessibility.ax_value() | nil,
          value: CDPotion.Domain.Accessibility.ax_value() | nil
        }

  @typedoc "Unique accessibility node identifier."
  @type ax_node_id :: String.t()

  @typedoc "description not provided :("
  @type ax_property :: %{
          name: CDPotion.Domain.Accessibility.ax_property_name(),
          value: CDPotion.Domain.Accessibility.ax_value()
        }

  @typedoc "Values of AXProperty name:
- from 'busy' to 'roledescription': states which apply to every AX node
- from 'live' to 'root': attributes which apply to nodes in live regions
- from 'autocomplete' to 'valuetext': attributes which apply to widgets
- from 'checked' to 'selected': states which apply to widgets
- from 'activedescendant' to 'owns' - relationships between elements other than parent/child/sibling."
  @type ax_property_name ::
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

  @typedoc "description not provided :("
  @type ax_related_node :: %{
          backendDOMNodeId: CDPotion.Domain.DOM.backend_node_id(),
          idref: String.t() | nil,
          text: String.t() | nil
        }

  @typedoc "A single computed AX property."
  @type ax_value :: %{
          relatedNodes: list(CDPotion.Domain.Accessibility.ax_related_node()) | nil,
          sources: list(CDPotion.Domain.Accessibility.ax_value_source()) | nil,
          type: CDPotion.Domain.Accessibility.ax_value_type(),
          value: any() | nil
        }

  @typedoc "Enum of possible native property sources (as a subtype of a particular AXValueSourceType)."
  @type ax_value_native_source_type ::
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

  @typedoc "A single source for a computed AX property."
  @type ax_value_source :: %{
          attribute: String.t() | nil,
          attributeValue: CDPotion.Domain.Accessibility.ax_value() | nil,
          invalid: boolean() | nil,
          invalidReason: String.t() | nil,
          nativeSource: CDPotion.Domain.Accessibility.ax_value_native_source_type() | nil,
          nativeSourceValue: CDPotion.Domain.Accessibility.ax_value() | nil,
          superseded: boolean() | nil,
          type: CDPotion.Domain.Accessibility.ax_value_source_type(),
          value: CDPotion.Domain.Accessibility.ax_value() | nil
        }

  @typedoc "Enum of possible property sources."
  @type ax_value_source_type ::
          :attribute | :implicit | :style | :contents | :placeholder | :relatedElement

  @typedoc "Enum of possible property types."
  @type ax_value_type ::
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
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Accessibility.disable", %{}}
  end

  @doc """
  Enables the accessibility domain which causes `AXNodeId`s to remain consistent between method calls.
  This turns on accessibility for the page, which can impact performance until accessibility is disabled.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Accessibility.enable", %{}}
  end

  @doc """
  Fetches the accessibility node and partial accessibility tree for this DOM node, if it exists.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node to get the partial accessibility tree for.
  - `backend_node_id`:(Optional) Identifier of the backend node to get the partial accessibility tree for.
  - `object_id`:(Optional) JavaScript object id of the node wrapper to get the partial accessibility tree for.
  - `fetch_relatives`:(Optional) Whether to fetch this node's ancestors, siblings and children. Defaults to true.
  """
  @spec get_partial_ax_tree(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId,
          boolean()
        ) :: {String.t(), map()}
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
    - `depth`:(Optional) The maximum depth at which descendants of the root node should be retrieved.
  If omitted, the full tree is returned.
  - `frame_id`:(Optional) The frame for whose document the AX tree should be retrieved.
  If omited, the root frame is used.
  """
  @spec get_full_ax_tree(integer(), CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_full_ax_tree(depth \\ nil, frame_id \\ nil) do
    params = as_query([{"depth", depth}, {"frameId", frame_id}])
    {"Accessibility.getFullAXTree", params}
  end

  @doc """
  Fetches the root node.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `frame_id`:(Optional) The frame in whose document the node resides.
  If omitted, the root frame is used.
  """
  @spec get_root_ax_node(CDPotion.Domain.Page.FrameId) :: {String.t(), map()}
  def get_root_ax_node(frame_id \\ nil) do
    params = as_query([{"frameId", frame_id}])
    {"Accessibility.getRootAXNode", params}
  end

  @doc """
  Fetches a node and all ancestors up to and including the root.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `node_id`:(Optional) Identifier of the node to get.
  - `backend_node_id`:(Optional) Identifier of the backend node to get.
  - `object_id`:(Optional) JavaScript object id of the node wrapper to get.
  """
  @spec get_ax_node_and_ancestors(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId
        ) :: {String.t(), map()}
  def get_ax_node_and_ancestors(node_id \\ nil, backend_node_id \\ nil, object_id \\ nil) do
    params =
      as_query([{"nodeId", node_id}, {"backendNodeId", backend_node_id}, {"objectId", object_id}])

    {"Accessibility.getAXNodeAndAncestors", params}
  end

  @doc """
  Fetches a particular accessibility node by AXNodeId.
  Requires `enable()` to have been called previously.
  ## Parameters:
    - `id`:description not provided :(
  - `frame_id`:(Optional) The frame in whose document the node resides.
  If omitted, the root frame is used.
  """
  @spec get_child_ax_nodes(CDPotion.Domain.Accessibility.AXNodeId, CDPotion.Domain.Page.FrameId) ::
          {String.t(), map()}
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
    - `node_id`:(Optional) Identifier of the node for the root to query.
  - `backend_node_id`:(Optional) Identifier of the backend node for the root to query.
  - `object_id`:(Optional) JavaScript object id of the node wrapper for the root to query.
  - `accessible_name`:(Optional) Find nodes with this computed name.
  - `role`:(Optional) Find nodes with this computed role.
  """
  @spec query_ax_tree(
          CDPotion.Domain.DOM.NodeId,
          CDPotion.Domain.DOM.BackendNodeId,
          CDPotion.Domain.Runtime.RemoteObjectId,
          String.t(),
          String.t()
        ) :: {String.t(), map()}
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
