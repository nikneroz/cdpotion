defmodule CDPotion.Domain.SystemInfo do
  use CDPotion.Utils
  @typedoc "Describes a single graphics processor (GPU)."
  @type gpu_device :: %{
          deviceId: number(),
          deviceString: String.t(),
          driverVendor: String.t(),
          driverVersion: String.t(),
          revision: number() | nil,
          subSysId: number() | nil,
          vendorId: number(),
          vendorString: String.t()
        }

  @typedoc "Provides information about the GPU(s) on the system."
  @type gpu_info :: %{
          auxAttributes: map() | nil,
          devices: list(CDPotion.Domain.SystemInfo.gpu_device()),
          driverBugWorkarounds: list(String.t()),
          featureStatus: map() | nil,
          imageDecoding: list(CDPotion.Domain.SystemInfo.image_decode_accelerator_capability()),
          videoDecoding: list(CDPotion.Domain.SystemInfo.video_decode_accelerator_capability()),
          videoEncoding: list(CDPotion.Domain.SystemInfo.video_encode_accelerator_capability())
        }

  @typedoc "Describes a supported image decoding profile with its associated minimum and
maximum resolutions and subsampling."
  @type image_decode_accelerator_capability :: %{
          imageType: CDPotion.Domain.SystemInfo.image_type(),
          maxDimensions: CDPotion.Domain.SystemInfo.size(),
          minDimensions: CDPotion.Domain.SystemInfo.size(),
          subsamplings: list(CDPotion.Domain.SystemInfo.subsampling_format())
        }

  @typedoc "Image format of a given image."
  @type image_type :: :jpeg | :webp | :unknown

  @typedoc "Represents process info."
  @type process_info :: %{
          cpuTime: number(),
          id: integer(),
          type: String.t()
        }

  @typedoc "Describes the width and height dimensions of an entity."
  @type size :: %{
          height: integer(),
          width: integer()
        }

  @typedoc "YUV subsampling type of the pixels of a given image."
  @type subsampling_format :: :yuv420 | :yuv422 | :yuv444

  @typedoc "Describes a supported video decoding profile with its associated minimum and
maximum resolutions."
  @type video_decode_accelerator_capability :: %{
          maxResolution: CDPotion.Domain.SystemInfo.size(),
          minResolution: CDPotion.Domain.SystemInfo.size(),
          profile: String.t()
        }

  @typedoc "Describes a supported video encoding profile with its associated maximum
resolution and maximum framerate."
  @type video_encode_accelerator_capability :: %{
          maxFramerateDenominator: integer(),
          maxFramerateNumerator: integer(),
          maxResolution: CDPotion.Domain.SystemInfo.size(),
          profile: String.t()
        }

  @doc """
  Returns information about the system.
  """
  @spec get_info() :: {String.t(), map()}
  def get_info() do
    {"SystemInfo.getInfo", %{}}
  end

  @doc """
  Returns information about the feature state.
  ## Parameters:
    - `feature_state`:description not provided :(
  """
  @spec get_feature_state(String.t()) :: {String.t(), map()}
  def get_feature_state(feature_state) do
    params = as_query([{"featureState", feature_state}])
    {"SystemInfo.getFeatureState", params}
  end

  @doc """
  Returns information about all running processes.
  """
  @spec get_process_info() :: {String.t(), map()}
  def get_process_info() do
    {"SystemInfo.getProcessInfo", %{}}
  end
end
