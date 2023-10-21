defmodule CDPotion.Domain.Tracing do
  use CDPotion.Utils
  @typedoc "Configuration for memory dump. Used only when 'memory-infra' category is enabled."
  @type memory_dump_config :: map()

  @typedoc "Details exposed when memory request explicitly declared.
Keep consistent with memory_dump_request_args.h and
memory_instrumentation.mojom"
  @type memory_dump_level_of_detail :: :background | :light | :detailed

  @typedoc "Compression type to use for traces returned via streams."
  @type stream_compression :: :none | :gzip

  @typedoc "Data format of a trace. Can be either the legacy JSON format or the
protocol buffer format. Note that the JSON format will be deprecated soon."
  @type stream_format :: :json | :proto

  @typedoc "description not provided :("
  @type trace_config :: %{
          enableArgumentFilter: boolean() | nil,
          enableSampling: boolean() | nil,
          enableSystrace: boolean() | nil,
          excludedCategories: list(String.t()) | nil,
          includedCategories: list(String.t()) | nil,
          memoryDumpConfig: CDPotion.Domain.Tracing.memory_dump_config() | nil,
          recordMode:
            :recordUntilFull
            | :recordContinuously
            | :recordAsMuchAsPossible
            | :echoToConsole
            | nil,
          syntheticDelays: list(String.t()) | nil,
          traceBufferSizeInKb: number() | nil
        }

  @typedoc "Backend type to use for tracing. `chrome` uses the Chrome-integrated
tracing service and is supported on all platforms. `system` is only
supported on Chrome OS and uses the Perfetto system tracing service.
`auto` chooses `system` when the perfettoConfig provided to Tracing.start
specifies at least one non-Chrome data source; otherwise uses `chrome`."
  @type tracing_backend :: :auto | :chrome | :system

  @doc """
  Stop trace events collection.
  """
  @spec end!() :: {String.t(), map()}
  def end!() do
    {"Tracing.end", %{}}
  end

  @doc """
  Gets supported tracing categories.
  """
  @spec get_categories() :: {String.t(), map()}
  def get_categories() do
    {"Tracing.getCategories", %{}}
  end

  @doc """
  Record a clock sync marker in the trace.
  ## Parameters:
    - `sync_id`:The ID of this clock sync marker
  """
  @spec record_clock_sync_marker(String.t()) :: {String.t(), map()}
  def record_clock_sync_marker(sync_id) do
    params = as_query([{"syncId", sync_id}])
    {"Tracing.recordClockSyncMarker", params}
  end

  @doc """
  Request a global memory dump.
  ## Parameters:
    - `deterministic`:(Optional) Enables more deterministic results by forcing garbage collection
  - `level_of_detail`:(Optional) Specifies level of details in memory dump. Defaults to "detailed".
  """
  @spec request_memory_dump(boolean(), CDPotion.Domain.Tracing.MemoryDumpLevelOfDetail) ::
          {String.t(), map()}
  def request_memory_dump(deterministic \\ nil, level_of_detail \\ nil) do
    params = as_query([{"deterministic", deterministic}, {"levelOfDetail", level_of_detail}])
    {"Tracing.requestMemoryDump", params}
  end

  @doc """
  Start trace events collection.
  ## Parameters:
    - `categories`:(Optional) Category/tag filter
  - `options`:(Optional) Tracing options
  - `buffer_usage_reporting_interval`:(Optional) If set, the agent will issue bufferUsage events at this interval, specified in milliseconds
  - `transfer_mode`:(Optional) Whether to report trace events as series of dataCollected events or to save trace to a
  stream (defaults to `ReportEvents`).
  - `stream_format`:(Optional) Trace data format to use. This only applies when using `ReturnAsStream`
  transfer mode (defaults to `json`).
  - `stream_compression`:(Optional) Compression format to use. This only applies when using `ReturnAsStream`
  transfer mode (defaults to `none`)
  - `trace_config`:(Optional) description not provided :(
  - `perfetto_config`:(Optional) Base64-encoded serialized perfetto.protos.TraceConfig protobuf message
  When specified, the parameters `categories`, `options`, `traceConfig`
  are ignored. (Encoded as a base64 string when passed over JSON)
  - `tracing_backend`:(Optional) Backend type (defaults to `auto`)
  """
  @spec start(
          String.t(),
          String.t(),
          number(),
          String.t(),
          CDPotion.Domain.Tracing.StreamFormat,
          CDPotion.Domain.Tracing.StreamCompression,
          CDPotion.Domain.Tracing.TraceConfig,
          String.t(),
          CDPotion.Domain.Tracing.TracingBackend
        ) :: {String.t(), map()}
  def start(
        categories \\ nil,
        options \\ nil,
        buffer_usage_reporting_interval \\ nil,
        transfer_mode \\ nil,
        stream_format \\ nil,
        stream_compression \\ nil,
        trace_config \\ nil,
        perfetto_config \\ nil,
        tracing_backend \\ nil
      ) do
    params =
      as_query([
        {"categories", categories},
        {"options", options},
        {"bufferUsageReportingInterval", buffer_usage_reporting_interval},
        {"transferMode", transfer_mode},
        {"streamFormat", stream_format},
        {"streamCompression", stream_compression},
        {"traceConfig", trace_config},
        {"perfettoConfig", perfetto_config},
        {"tracingBackend", tracing_backend}
      ])

    {"Tracing.start", params}
  end
end
