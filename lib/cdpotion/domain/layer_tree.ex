defmodule CDPotion.Domain.LayerTree do
  use CDPotion.Utils
  @doc "Information about a compositing layer."
  @type Layer :: %{
          anchorX: number() | nil,
          anchorY: number() | nil,
          anchorZ: number() | nil,
          backendNodeId: DOM.BackendNodeId | nil,
          drawsContent: boolean(),
          height: number(),
          invisible: boolean() | nil,
          layerId: LayerTree.LayerId,
          offsetX: number(),
          offsetY: number(),
          paintCount: integer(),
          parentLayerId: LayerTree.LayerId | nil,
          scrollRects: list(LayerTree.ScrollRect) | nil,
          stickyPositionConstraint: LayerTree.StickyPositionConstraint | nil,
          transform: list(number()) | nil,
          width: number()
        }

  @doc "Unique Layer identifier."
  @type LayerId :: String.t()

  @doc "Array of timings, one per paint step."
  @type PaintProfile :: list(number())

  @doc "Serialized fragment of layer picture along with its offset within the layer."
  @type PictureTile :: %{
          picture: String.t(),
          x: number(),
          y: number()
        }

  @doc "Rectangle where scrolling happens on the main thread."
  @type ScrollRect :: %{
          rect: DOM.Rect,
          type: :RepaintsOnScroll | :TouchEventHandler | :WheelEventHandler
        }

  @doc "Unique snapshot identifier."
  @type SnapshotId :: String.t()

  @doc "Sticky position constraints."
  @type StickyPositionConstraint :: %{
          containingBlockRect: DOM.Rect,
          nearestLayerShiftingContainingBlock: LayerTree.LayerId | nil,
          nearestLayerShiftingStickyBox: LayerTree.LayerId | nil,
          stickyBoxRect: DOM.Rect
        }

  @doc """
  Provides the reasons why the given layer was composited.
  ## Parameters:
    - `layerId:LayerId`: The id of the layer for which we want to get the reasons it was composited.
  """
  def compositing_reasons(layer_id) do
    params = as_query([{"layerId", layer_id}])
    {"LayerTree.compositingReasons", params}
  end

  @doc """
  Disables compositing tree inspection.
  """
  def disable() do
    {"LayerTree.disable", %{}}
  end

  @doc """
  Enables compositing tree inspection.
  """
  def enable() do
    {"LayerTree.enable", %{}}
  end

  @doc """
  Returns the snapshot identifier.
  ## Parameters:
    - `tiles:array`: An array of tiles composing the snapshot.
  """
  def load_snapshot(tiles) do
    params = as_query([{"tiles", tiles}])
    {"LayerTree.loadSnapshot", params}
  end

  @doc """
  Returns the layer snapshot identifier.
  ## Parameters:
    - `layerId:LayerId`: The id of the layer.
  """
  def make_snapshot(layer_id) do
    params = as_query([{"layerId", layer_id}])
    {"LayerTree.makeSnapshot", params}
  end

  @doc """
  ## Parameters:
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
    - `minRepeatCount:integer`: (Optional) The maximum number of times to replay the snapshot (1, if not specified).
    - `minDuration:number`: (Optional) The minimum duration (in seconds) to replay the snapshot.
    - `clipRect:DOM.Rect`: (Optional) The clip rectangle to apply when replaying the snapshot.
  """
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
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
  """
  def release_snapshot(snapshot_id) do
    params = as_query([{"snapshotId", snapshot_id}])
    {"LayerTree.releaseSnapshot", params}
  end

  @doc """
  Replays the layer snapshot and returns the resulting bitmap.
  ## Parameters:
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
    - `fromStep:integer`: (Optional) The first step to replay from (replay from the very start if not specified).
    - `toStep:integer`: (Optional) The last step to replay to (replay till the end if not specified).
    - `scale:number`: (Optional) The scale to apply while replaying (defaults to 1).
  """
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
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
  """
  def snapshot_command_log(snapshot_id) do
    params = as_query([{"snapshotId", snapshot_id}])
    {"LayerTree.snapshotCommandLog", params}
  end
end
