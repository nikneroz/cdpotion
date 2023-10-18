defmodule CDPotion.Domain.Animation do
  @doc """
  Disables animation domain notifications.
  """
  def disable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Enables animation domain notifications.
  """
  def enable() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Returns the current time of the an animation.
  ## Parameters:
    - `id:string`: Id of animation.
  """
  def get_current_time(id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets the playback rate of the document timeline.
  """
  def get_playback_rate() do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Releases a set of animations to no longer be manipulated.
  ## Parameters:
    - `animations:array`: List of animation ids to seek.
  """
  def release_animations(animations) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Gets the remote object of the Animation.
  ## Parameters:
    - `animationId:string`: Animation id.
  """
  def resolve_animation(animation_id) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Seek a set of animations to a particular time within each animation.
  ## Parameters:
    - `animations:array`: List of animation ids to seek.
    - `currentTime:number`: Set the current time of each animation.
  """
  def seek_animations(animations, current_time) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets the paused state of a set of animations.
  ## Parameters:
    - `animations:array`: Animations to set the pause state of.
    - `paused:boolean`: Paused state to set to.
  """
  def set_paused(animations, paused) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets the playback rate of the document timeline.
  ## Parameters:
    - `playbackRate:number`: Playback rate for animations on page
  """
  def set_playback_rate(playback_rate) do
    execute(session, :navigate, %{"url" => url})
  end

  @doc """
  Sets the timing of an animation node.
  ## Parameters:
    - `animationId:string`: Animation id.
    - `duration:number`: Duration of the animation.
    - `delay:number`: Delay of the animation.
  """
  def set_timing(animation_id, duration, delay) do
    execute(session, :navigate, %{"url" => url})
  end
end
