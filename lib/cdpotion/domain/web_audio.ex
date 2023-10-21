defmodule CDPotion.Domain.WebAudio do
  use CDPotion.Utils
  @doc "Protocol object for AudioListener"
  @type AudioListener :: %{
          contextId: WebAudio.GraphObjectId,
          listenerId: WebAudio.GraphObjectId
        }

  @doc "Protocol object for AudioNode"
  @type AudioNode :: %{
          channelCount: number(),
          channelCountMode: WebAudio.ChannelCountMode,
          channelInterpretation: WebAudio.ChannelInterpretation,
          contextId: WebAudio.GraphObjectId,
          nodeId: WebAudio.GraphObjectId,
          nodeType: WebAudio.NodeType,
          numberOfInputs: number(),
          numberOfOutputs: number()
        }

  @doc "Protocol object for AudioParam"
  @type AudioParam :: %{
          contextId: WebAudio.GraphObjectId,
          defaultValue: number(),
          maxValue: number(),
          minValue: number(),
          nodeId: WebAudio.GraphObjectId,
          paramId: WebAudio.GraphObjectId,
          paramType: WebAudio.ParamType,
          rate: WebAudio.AutomationRate
        }

  @doc "Enum of AudioParam::AutomationRate from the spec"
  @type AutomationRate :: :"a-rate" | :"k-rate"

  @doc "Protocol object for BaseAudioContext"
  @type BaseAudioContext :: %{
          callbackBufferSize: number(),
          contextId: WebAudio.GraphObjectId,
          contextState: WebAudio.ContextState,
          contextType: WebAudio.ContextType,
          maxOutputChannelCount: number(),
          realtimeData: WebAudio.ContextRealtimeData | nil,
          sampleRate: number()
        }

  @doc "Enum of AudioNode::ChannelCountMode from the spec"
  @type ChannelCountMode :: :"clamped-max" | :explicit | :max

  @doc "Enum of AudioNode::ChannelInterpretation from the spec"
  @type ChannelInterpretation :: :discrete | :speakers

  @doc "Fields in AudioContext that change in real-time."
  @type ContextRealtimeData :: %{
          callbackIntervalMean: number(),
          callbackIntervalVariance: number(),
          currentTime: number(),
          renderCapacity: number()
        }

  @doc "Enum of AudioContextState from the spec"
  @type ContextState :: :suspended | :running | :closed

  @doc "Enum of BaseAudioContext types"
  @type ContextType :: :realtime | :offline

  @doc "An unique ID for a graph object (AudioContext, AudioNode, AudioParam) in Web Audio API"
  @type GraphObjectId :: String.t()

  @doc "Enum of AudioNode types"
  @type NodeType :: String.t()

  @doc "Enum of AudioParam types"
  @type ParamType :: String.t()

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
