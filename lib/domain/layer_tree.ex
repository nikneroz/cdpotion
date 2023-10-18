defmodule CDPotion.Domain.LayerTree do
  @doc """
  Provides the reasons why the given layer was composited.
  ## Parameters:
    - `layerId:LayerId`: The id of the layer for which we want to get the reasons it was composited.
  """
  def compositing_reasons(layer_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Disables compositing tree inspection.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables compositing tree inspection.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the snapshot identifier.
  ## Parameters:
    - `tiles:array`: An array of tiles composing the snapshot.
  """
  def load_snapshot(tiles) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the layer snapshot identifier.
  ## Parameters:
    - `layerId:LayerId`: The id of the layer.
  """
  def make_snapshot(layer_id) do
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Releases layer snapshot captured by the back-end.
  ## Parameters:
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
  """
  def release_snapshot(snapshot_id) do
    execute(session, :navigate, %{"url" => url})
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
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Replays the layer snapshot and returns canvas log.
  ## Parameters:
    - `snapshotId:SnapshotId`: The id of the layer snapshot.
  """
  def snapshot_command_log(snapshot_id) do
    execute(session, :navigate, %{"url" => url})
  end
end
