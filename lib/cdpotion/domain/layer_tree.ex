defmodule CDPotion.Domain.LayerTree do
  use CDPotion.Utils
  @typedoc "Information about a compositing layer."
  @type layer :: %{
          anchorX: number() | nil,
          anchorY: number() | nil,
          anchorZ: number() | nil,
          backendNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          drawsContent: boolean(),
          height: number(),
          invisible: boolean() | nil,
          layerId: CDPotion.Domain.LayerTree.layer_id(),
          offsetX: number(),
          offsetY: number(),
          paintCount: integer(),
          parentLayerId: CDPotion.Domain.LayerTree.layer_id() | nil,
          scrollRects: list(CDPotion.Domain.LayerTree.scroll_rect()) | nil,
          stickyPositionConstraint: CDPotion.Domain.LayerTree.sticky_position_constraint() | nil,
          transform: list(number()) | nil,
          width: number()
        }

  @typedoc "Unique Layer identifier."
  @type layer_id :: String.t()

  @typedoc "Array of timings, one per paint step."
  @type paint_profile :: list(number())

  @typedoc "Serialized fragment of layer picture along with its offset within the layer."
  @type picture_tile :: %{
          picture: String.t(),
          x: number(),
          y: number()
        }

  @typedoc "Rectangle where scrolling happens on the main thread."
  @type scroll_rect :: %{
          rect: CDPotion.Domain.DOM.rect(),
          type: :RepaintsOnScroll | :TouchEventHandler | :WheelEventHandler
        }

  @typedoc "Unique snapshot identifier."
  @type snapshot_id :: String.t()

  @typedoc "Sticky position constraints."
  @type sticky_position_constraint :: %{
          containingBlockRect: CDPotion.Domain.DOM.rect(),
          nearestLayerShiftingContainingBlock: CDPotion.Domain.LayerTree.layer_id() | nil,
          nearestLayerShiftingStickyBox: CDPotion.Domain.LayerTree.layer_id() | nil,
          stickyBoxRect: CDPotion.Domain.DOM.rect()
        }

  @doc """
  Provides the reasons why the given layer was composited.
  ## Parameters:
    - (Required) `layer_id`: The id of the layer for which we want to get the reasons it was composited.
  """
  @spec compositing_reasons(CDPotion.Domain.LayerTree.layer_id()) :: {String.t(), map()}
  def compositing_reasons(layer_id) do
    params = as_query([{"layerId", layer_id}])
    {"LayerTree.compositingReasons", params}
  end

  @doc """
  Disables compositing tree inspection.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"LayerTree.disable", %{}}
  end

  @doc """
  Enables compositing tree inspection.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"LayerTree.enable", %{}}
  end

  @doc """
  Returns the snapshot identifier.
  ## Parameters:
    - (Required) `tiles`: An array of tiles composing the snapshot.
  """
  @spec load_snapshot(list(CDPotion.Domain.LayerTree.picture_tile())) :: {String.t(), map()}
  def load_snapshot(tiles) do
    params = as_query([{"tiles", tiles}])
    {"LayerTree.loadSnapshot", params}
  end

  @doc """
  Returns the layer snapshot identifier.
  ## Parameters:
    - (Required) `layer_id`: The id of the layer.
  """
  @spec make_snapshot(CDPotion.Domain.LayerTree.layer_id()) :: {String.t(), map()}
  def make_snapshot(layer_id) do
    params = as_query([{"layerId", layer_id}])
    {"LayerTree.makeSnapshot", params}
  end

  @doc """

  ## Parameters:
    - (Required) `snapshot_id`: The id of the layer snapshot.
  - (Optional) `min_repeat_count`: The maximum number of times to replay the snapshot (1, if not specified).
  - (Optional) `min_duration`: The minimum duration (in seconds) to replay the snapshot.
  - (Optional) `clip_rect`: The clip rectangle to apply when replaying the snapshot.
  """
  @spec profile_snapshot(
          CDPotion.Domain.LayerTree.snapshot_id(),
          integer(),
          number(),
          CDPotion.Domain.DOM.rect()
        ) :: {String.t(), map()}
  def profile_snapshot(
        snapshot_id,
        min_repeat_count \\ nil,
        min_duration \\ nil,
        clip_rect \\ nil
      ) do
    params =
      as_query([
        {"snapshotId", snapshot_id},
        {"minRepeatCount", min_repeat_count},
        {"minDuration", min_duration},
        {"clipRect", clip_rect}
      ])

    {"LayerTree.profileSnapshot", params}
  end

  @doc """
  Releases layer snapshot captured by the back-end.
  ## Parameters:
    - (Required) `snapshot_id`: The id of the layer snapshot.
  """
  @spec release_snapshot(CDPotion.Domain.LayerTree.snapshot_id()) :: {String.t(), map()}
  def release_snapshot(snapshot_id) do
    params = as_query([{"snapshotId", snapshot_id}])
    {"LayerTree.releaseSnapshot", params}
  end

  @doc """
  Replays the layer snapshot and returns the resulting bitmap.
  ## Parameters:
    - (Required) `snapshot_id`: The id of the layer snapshot.
  - (Optional) `from_step`: The first step to replay from (replay from the very start if not specified).
  - (Optional) `to_step`: The last step to replay to (replay till the end if not specified).
  - (Optional) `scale`: The scale to apply while replaying (defaults to 1).
  """
  @spec replay_snapshot(CDPotion.Domain.LayerTree.snapshot_id(), integer(), integer(), number()) ::
          {String.t(), map()}
  def replay_snapshot(snapshot_id, from_step \\ nil, to_step \\ nil, scale \\ nil) do
    params =
      as_query([
        {"snapshotId", snapshot_id},
        {"fromStep", from_step},
        {"toStep", to_step},
        {"scale", scale}
      ])

    {"LayerTree.replaySnapshot", params}
  end

  @doc """
  Replays the layer snapshot and returns canvas log.
  ## Parameters:
    - (Required) `snapshot_id`: The id of the layer snapshot.
  """
  @spec snapshot_command_log(CDPotion.Domain.LayerTree.snapshot_id()) :: {String.t(), map()}
  def snapshot_command_log(snapshot_id) do
    params = as_query([{"snapshotId", snapshot_id}])
    {"LayerTree.snapshotCommandLog", params}
  end
end
