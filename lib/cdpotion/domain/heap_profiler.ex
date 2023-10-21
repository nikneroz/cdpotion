defmodule CDPotion.Domain.HeapProfiler do
  use CDPotion.Utils
  @typedoc "Heap snapshot object id."
  @type heap_snapshot_object_id :: String.t()

  @typedoc "Sampling profile."
  @type sampling_heap_profile :: %{
          head: CDPotion.Domain.HeapProfiler.sampling_heap_profile_node(),
          samples: list(CDPotion.Domain.HeapProfiler.sampling_heap_profile_sample())
        }

  @typedoc "Sampling Heap Profile node. Holds callsite information, allocation statistics and child nodes."
  @type sampling_heap_profile_node :: %{
          callFrame: CDPotion.Domain.Runtime.call_frame(),
          children: list(CDPotion.Domain.HeapProfiler.sampling_heap_profile_node()),
          id: integer(),
          selfSize: number()
        }

  @typedoc "A single sample from a sampling profile."
  @type sampling_heap_profile_sample :: %{
          nodeId: integer(),
          ordinal: number(),
          size: number()
        }

  @doc """
  Enables console to refer to the node with given id via $x (see Command Line API for more details
  $x functions).
  ## Parameters:
    - (Required) `heap_object_id`: Heap snapshot object id to be accessible by means of $x command line API.
  """
  @spec add_inspected_heap_object(CDPotion.Domain.HeapProfiler.HeapSnapshotObjectId) ::
          {String.t(), map()}
  def add_inspected_heap_object(heap_object_id) do
    params = as_query([{"heapObjectId", heap_object_id}])
    {"HeapProfiler.addInspectedHeapObject", params}
  end

  @doc """

  """
  @spec collect_garbage() :: {String.t(), map()}
  def collect_garbage() do
    {"HeapProfiler.collectGarbage", %{}}
  end

  @doc """

  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"HeapProfiler.disable", %{}}
  end

  @doc """

  """
  @spec enable() :: {String.t(), map()}
  def enable() do
    {"HeapProfiler.enable", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `object_id`: Identifier of the object to get heap object id for.
  """
  @spec get_heap_object_id(CDPotion.Domain.Runtime.RemoteObjectId) :: {String.t(), map()}
  def get_heap_object_id(object_id) do
    params = as_query([{"objectId", object_id}])
    {"HeapProfiler.getHeapObjectId", params}
  end

  @doc """

  ## Parameters:
    - (Required) `object_id`: description not provided :(
  - (Optional) `object_group`: Symbolic group name that can be used to release multiple objects.
  """
  @spec get_object_by_heap_object_id(
          CDPotion.Domain.HeapProfiler.HeapSnapshotObjectId,
          String.t()
        ) :: {String.t(), map()}
  def get_object_by_heap_object_id(object_id, object_group \\ nil) do
    params = as_query([{"objectId", object_id}, {"objectGroup", object_group}])
    {"HeapProfiler.getObjectByHeapObjectId", params}
  end

  @doc """

  """
  @spec get_sampling_profile() :: {String.t(), map()}
  def get_sampling_profile() do
    {"HeapProfiler.getSamplingProfile", %{}}
  end

  @doc """

  ## Parameters:
    - (Optional) `sampling_interval`: Average sample interval in bytes. Poisson distribution is used for the intervals. The
  default value is 32768 bytes.
  - (Optional) `include_objects_collected_by_major_gc`: By default, the sampling heap profiler reports only objects which are
  still alive when the profile is returned via getSamplingProfile or
  stopSampling, which is useful for determining what functions contribute
  the most to steady-state memory usage. This flag instructs the sampling
  heap profiler to also include information about objects discarded by
  major GC, which will show which functions cause large temporary memory
  usage or long GC pauses.
  - (Optional) `include_objects_collected_by_minor_gc`: By default, the sampling heap profiler reports only objects which are
  still alive when the profile is returned via getSamplingProfile or
  stopSampling, which is useful for determining what functions contribute
  the most to steady-state memory usage. This flag instructs the sampling
  heap profiler to also include information about objects discarded by
  minor GC, which is useful when tuning a latency-sensitive application
  for minimal GC activity.
  """
  @spec start_sampling(number(), boolean(), boolean()) :: {String.t(), map()}
  def start_sampling(
        sampling_interval \\ nil,
        include_objects_collected_by_major_gc \\ nil,
        include_objects_collected_by_minor_gc \\ nil
      ) do
    params =
      as_query([
        {"samplingInterval", sampling_interval},
        {"includeObjectsCollectedByMajorGC", include_objects_collected_by_major_gc},
        {"includeObjectsCollectedByMinorGC", include_objects_collected_by_minor_gc}
      ])

    {"HeapProfiler.startSampling", params}
  end

  @doc """

  ## Parameters:
    - (Optional) `track_allocations`: description not provided :(
  """
  @spec start_tracking_heap_objects(boolean()) :: {String.t(), map()}
  def start_tracking_heap_objects(track_allocations \\ nil) do
    params = as_query([{"trackAllocations", track_allocations}])
    {"HeapProfiler.startTrackingHeapObjects", params}
  end

  @doc """

  """
  @spec stop_sampling() :: {String.t(), map()}
  def stop_sampling() do
    {"HeapProfiler.stopSampling", %{}}
  end

  @doc """

  ## Parameters:
    - (Optional) `report_progress`: If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken
  when the tracking is stopped.
  - (Optional) `treat_global_objects_as_roots`: Deprecated in favor of `exposeInternals`.
  - (Optional) `capture_numeric_value`: If true, numerical values are included in the snapshot
  - (Optional) `expose_internals`: If true, exposes internals of the snapshot.
  """
  @spec stop_tracking_heap_objects(boolean(), boolean(), boolean(), boolean()) ::
          {String.t(), map()}
  def stop_tracking_heap_objects(
        report_progress \\ nil,
        treat_global_objects_as_roots \\ nil,
        capture_numeric_value \\ nil,
        expose_internals \\ nil
      ) do
    params =
      as_query([
        {"reportProgress", report_progress},
        {"treatGlobalObjectsAsRoots", treat_global_objects_as_roots},
        {"captureNumericValue", capture_numeric_value},
        {"exposeInternals", expose_internals}
      ])

    {"HeapProfiler.stopTrackingHeapObjects", params}
  end

  @doc """

  ## Parameters:
    - (Optional) `report_progress`: If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken.
  - (Optional) `treat_global_objects_as_roots`: If true, a raw snapshot without artificial roots will be generated.
  Deprecated in favor of `exposeInternals`.
  - (Optional) `capture_numeric_value`: If true, numerical values are included in the snapshot
  - (Optional) `expose_internals`: If true, exposes internals of the snapshot.
  """
  @spec take_heap_snapshot(boolean(), boolean(), boolean(), boolean()) :: {String.t(), map()}
  def take_heap_snapshot(
        report_progress \\ nil,
        treat_global_objects_as_roots \\ nil,
        capture_numeric_value \\ nil,
        expose_internals \\ nil
      ) do
    params =
      as_query([
        {"reportProgress", report_progress},
        {"treatGlobalObjectsAsRoots", treat_global_objects_as_roots},
        {"captureNumericValue", capture_numeric_value},
        {"exposeInternals", expose_internals}
      ])

    {"HeapProfiler.takeHeapSnapshot", params}
  end
end
