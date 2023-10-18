defmodule CDPotion.Domain.Tracing do
  use CDPotion.Utils

  @doc """
  Stop trace events collection.
  """
  def end!() do
    {"Tracing.end", %{}}
  end

  @doc """
  Gets supported tracing categories.
  """
  def get_categories() do
    {"Tracing.getCategories", %{}}
  end

  @doc """
  Record a clock sync marker in the trace.
  ## Parameters:
    - `syncId:string`: The ID of this clock sync marker
  """
  def record_clock_sync_marker(sync_id) do
    params = as_query([{"syncId", sync_id}])
    {"Tracing.recordClockSyncMarker", params}
  end

  @doc """
  Request a global memory dump.
  ## Parameters:
    - `deterministic:boolean`: (Optional) Enables more deterministic results by forcing garbage collection
    - `levelOfDetail:MemoryDumpLevelOfDetail`: (Optional) Specifies level of details in memory dump. Defaults to "detailed".
  """
  def request_memory_dump(deterministic \\ nil, level_of_detail \\ nil) do
    params = as_query([{"deterministic", deterministic}, {"levelOfDetail", level_of_detail}])
    {"Tracing.requestMemoryDump", params}
  end

  @doc """
  Start trace events collection.
  ## Parameters:
    - `categories:string`: (Optional) Category/tag filter
    - `options:string`: (Optional) Tracing options
    - `bufferUsageReportingInterval:number`: (Optional) If set, the agent will issue bufferUsage events at this interval, specified in milliseconds
    - `transferMode:string`: (Optional) Whether to report trace events as series of dataCollected events or to save trace to a
  stream (defaults to `ReportEvents`).
    - `streamFormat:StreamFormat`: (Optional) Trace data format to use. This only applies when using `ReturnAsStream`
  transfer mode (defaults to `json`).
    - `streamCompression:StreamCompression`: (Optional) Compression format to use. This only applies when using `ReturnAsStream`
  transfer mode (defaults to `none`)
    - `traceConfig:TraceConfig`: (Optional) description not provided :(
    - `perfettoConfig:string`: (Optional) Base64-encoded serialized perfetto.protos.TraceConfig protobuf message
  When specified, the parameters `categories`, `options`, `traceConfig`
  are ignored. (Encoded as a base64 string when passed over JSON)
    - `tracingBackend:TracingBackend`: (Optional) Backend type (defaults to `auto`)
  """
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
