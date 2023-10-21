defmodule CDPotion.Domain.SystemInfo do
  use CDPotion.Utils
  @doc "Describes a single graphics processor (GPU)."
  @type GPUDevice :: %{
          deviceId: number(),
          deviceString: String.t(),
          driverVendor: String.t(),
          driverVersion: String.t(),
          revision: number() | nil,
          subSysId: number() | nil,
          vendorId: number(),
          vendorString: String.t()
        }

  @doc "Provides information about the GPU(s) on the system."
  @type GPUInfo :: %{
          auxAttributes: map() | nil,
          devices: list(SystemInfo.GPUDevice),
          driverBugWorkarounds: list(String.t()),
          featureStatus: map() | nil,
          imageDecoding: list(SystemInfo.ImageDecodeAcceleratorCapability),
          videoDecoding: list(SystemInfo.VideoDecodeAcceleratorCapability),
          videoEncoding: list(SystemInfo.VideoEncodeAcceleratorCapability)
        }

  @doc "Describes a supported image decoding profile with its associated minimum and
maximum resolutions and subsampling."
  @type ImageDecodeAcceleratorCapability :: %{
          imageType: SystemInfo.ImageType,
          maxDimensions: SystemInfo.Size,
          minDimensions: SystemInfo.Size,
          subsamplings: list(SystemInfo.SubsamplingFormat)
        }

  @doc "Image format of a given image."
  @type ImageType :: :jpeg | :webp | :unknown

  @doc "Represents process info."
  @type ProcessInfo :: %{
          cpuTime: number(),
          id: integer(),
          type: String.t()
        }

  @doc "Describes the width and height dimensions of an entity."
  @type Size :: %{
          height: integer(),
          width: integer()
        }

  @doc "YUV subsampling type of the pixels of a given image."
  @type SubsamplingFormat :: :yuv420 | :yuv422 | :yuv444

  @doc "Describes a supported video decoding profile with its associated minimum and
maximum resolutions."
  @type VideoDecodeAcceleratorCapability :: %{
          maxResolution: SystemInfo.Size,
          minResolution: SystemInfo.Size,
          profile: String.t()
        }

  @doc "Describes a supported video encoding profile with its associated maximum
resolution and maximum framerate."
  @type VideoEncodeAcceleratorCapability :: %{
          maxFramerateDenominator: integer(),
          maxFramerateNumerator: integer(),
          maxResolution: SystemInfo.Size,
          profile: String.t()
        }

  @doc """
  Returns information about the system.
  """
  def get_info() do
    {"SystemInfo.getInfo", %{}}
  end

  @doc """
  Returns information about the feature state.
  ## Parameters:
    - `featureState:string`: description not provided :(
  """
  def get_feature_state(feature_state) do
    params = as_query([{"featureState", feature_state}])
    {"SystemInfo.getFeatureState", params}
  end

  @doc """
  Returns information about all running processes.
  """
  def get_process_info() do
    {"SystemInfo.getProcessInfo", %{}}
  end
end
