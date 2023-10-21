defmodule CDPotion.Domain.WebAudio do
  use CDPotion.Utils
  @typedoc "Protocol object for AudioListener"
  @type audio_listener :: %{
          contextId: CDPotion.Domain.WebAudio.graph_object_id(),
          listenerId: CDPotion.Domain.WebAudio.graph_object_id()
        }

  @typedoc "Protocol object for AudioNode"
  @type audio_node :: %{
          channelCount: number(),
          channelCountMode: CDPotion.Domain.WebAudio.channel_count_mode(),
          channelInterpretation: CDPotion.Domain.WebAudio.channel_interpretation(),
          contextId: CDPotion.Domain.WebAudio.graph_object_id(),
          nodeId: CDPotion.Domain.WebAudio.graph_object_id(),
          nodeType: CDPotion.Domain.WebAudio.node_type(),
          numberOfInputs: number(),
          numberOfOutputs: number()
        }

  @typedoc "Protocol object for AudioParam"
  @type audio_param :: %{
          contextId: CDPotion.Domain.WebAudio.graph_object_id(),
          defaultValue: number(),
          maxValue: number(),
          minValue: number(),
          nodeId: CDPotion.Domain.WebAudio.graph_object_id(),
          paramId: CDPotion.Domain.WebAudio.graph_object_id(),
          paramType: CDPotion.Domain.WebAudio.param_type(),
          rate: CDPotion.Domain.WebAudio.automation_rate()
        }

  @typedoc "Enum of AudioParam::AutomationRate from the spec"
  @type automation_rate :: :"a-rate" | :"k-rate"

  @typedoc "Protocol object for BaseAudioContext"
  @type base_audio_context :: %{
          callbackBufferSize: number(),
          contextId: CDPotion.Domain.WebAudio.graph_object_id(),
          contextState: CDPotion.Domain.WebAudio.context_state(),
          contextType: CDPotion.Domain.WebAudio.context_type(),
          maxOutputChannelCount: number(),
          realtimeData: CDPotion.Domain.WebAudio.context_realtime_data() | nil,
          sampleRate: number()
        }

  @typedoc "Enum of AudioNode::ChannelCountMode from the spec"
  @type channel_count_mode :: :"clamped-max" | :explicit | :max

  @typedoc "Enum of AudioNode::ChannelInterpretation from the spec"
  @type channel_interpretation :: :discrete | :speakers

  @typedoc "Fields in AudioContext that change in real-time."
  @type context_realtime_data :: %{
          callbackIntervalMean: number(),
          callbackIntervalVariance: number(),
          currentTime: number(),
          renderCapacity: number()
        }

  @typedoc "Enum of AudioContextState from the spec"
  @type context_state :: :suspended | :running | :closed

  @typedoc "Enum of BaseAudioContext types"
  @type context_type :: :realtime | :offline

  @typedoc "An unique ID for a graph object (AudioContext, AudioNode, AudioParam) in Web Audio API"
  @type graph_object_id :: String.t()

  @typedoc "Enum of AudioNode types"
  @type node_type :: String.t()

  @typedoc "Enum of AudioParam types"
  @type param_type :: String.t()

  @doc """
  Enables the WebAudio domain and starts sending context lifetime events.
  """
  def enable() do
    {"WebAudio.enable", %{}}
  end

  @doc """
  Disables the WebAudio domain.
  """
  def disable() do
    {"WebAudio.disable", %{}}
  end

  @doc """
  Fetch the realtime data from the registered contexts.
  ## Parameters:
    - `contextId:GraphObjectId`: description not provided :(
  """
  def get_realtime_data(context_id) do
    params = as_query([{"contextId", context_id}])
    {"WebAudio.getRealtimeData", params}
  end
end
