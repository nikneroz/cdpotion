defmodule CDPotion.Domain.Animation do
  use CDPotion.Utils
  @typedoc "Animation instance."
  @type animation :: %{
          cssId: String.t() | nil,
          currentTime: number(),
          id: String.t(),
          name: String.t(),
          pausedState: boolean(),
          playState: String.t(),
          playbackRate: number(),
          source: CDPotion.Domain.Animation.animation_effect() | nil,
          startTime: number(),
          type: :CSSTransition | :CSSAnimation | :WebAnimation
        }

  @typedoc "AnimationEffect instance"
  @type animation_effect :: %{
          backendNodeId: CDPotion.Domain.DOM.backend_node_id() | nil,
          delay: number(),
          direction: String.t(),
          duration: number(),
          easing: String.t(),
          endDelay: number(),
          fill: String.t(),
          iterationStart: number(),
          iterations: number(),
          keyframesRule: CDPotion.Domain.Animation.keyframes_rule() | nil
        }

  @typedoc "Keyframe Style"
  @type keyframe_style :: %{
          easing: String.t(),
          offset: String.t()
        }

  @typedoc "Keyframes Rule"
  @type keyframes_rule :: %{
          keyframes: list(CDPotion.Domain.Animation.keyframe_style()),
          name: String.t() | nil
        }

  @doc """
  Disables animation domain notifications.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Animation.disable", %{}}
  end

  @doc """
  Enables animation domain notifications.
  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"Animation.enable", %{}}
  end

  @doc """
  Returns the current time of the an animation.
  ## Parameters:
    - `id`:Id of animation.
  """
  @spec get_current_time(String.t()) :: {String.t(), map()}
  def get_current_time(id) do
    params = as_query([{"id", id}])
    {"Animation.getCurrentTime", params}
  end

  @doc """
  Gets the playback rate of the document timeline.
  """
  @spec get_playback_rate() :: {String.t(), map()}
  def get_playback_rate() do
    {"Animation.getPlaybackRate", %{}}
  end

  @doc """
  Releases a set of animations to no longer be manipulated.
  ## Parameters:
    - `animations`:List of animation ids to seek.
  """
  @spec release_animations(list(String.t())) :: {String.t(), map()}
  def release_animations(animations) do
    params = as_query([{"animations", animations}])
    {"Animation.releaseAnimations", params}
  end

  @doc """
  Gets the remote object of the Animation.
  ## Parameters:
    - `animation_id`:Animation id.
  """
  @spec resolve_animation(String.t()) :: {String.t(), map()}
  def resolve_animation(animation_id) do
    params = as_query([{"animationId", animation_id}])
    {"Animation.resolveAnimation", params}
  end

  @doc """
  Seek a set of animations to a particular time within each animation.
  ## Parameters:
    - `animations`:List of animation ids to seek.
  - `current_time`:Set the current time of each animation.
  """
  @spec seek_animations(list(String.t()), number()) :: {String.t(), map()}
  def seek_animations(animations, current_time) do
    params = as_query([{"animations", animations}, {"currentTime", current_time}])
    {"Animation.seekAnimations", params}
  end

  @doc """
  Sets the paused state of a set of animations.
  ## Parameters:
    - `animations`:Animations to set the pause state of.
  - `paused`:Paused state to set to.
  """
  @spec set_paused(list(String.t()), boolean()) :: {String.t(), map()}
  def set_paused(animations, paused) do
    params = as_query([{"animations", animations}, {"paused", paused}])
    {"Animation.setPaused", params}
  end

  @doc """
  Sets the playback rate of the document timeline.
  ## Parameters:
    - `playback_rate`:Playback rate for animations on page
  """
  @spec set_playback_rate(number()) :: {String.t(), map()}
  def set_playback_rate(playback_rate) do
    params = as_query([{"playbackRate", playback_rate}])
    {"Animation.setPlaybackRate", params}
  end

  @doc """
  Sets the timing of an animation node.
  ## Parameters:
    - `animation_id`:Animation id.
  - `duration`:Duration of the animation.
  - `delay`:Delay of the animation.
  """
  @spec set_timing(String.t(), number(), number()) :: {String.t(), map()}
  def set_timing(animation_id, duration, delay) do
    params = as_query([{"animationId", animation_id}, {"duration", duration}, {"delay", delay}])
    {"Animation.setTiming", params}
  end
end
