defmodule CDPotion.Domain.HeapProfiler do
  use CDPotion.Utils
  @doc "Heap snapshot object id."
  @type HeapSnapshotObjectId :: String.t()

  @doc "Sampling profile."
  @type SamplingHeapProfile :: %{
          head: HeapProfiler.SamplingHeapProfileNode,
          samples: list(HeapProfiler.SamplingHeapProfileSample)
        }

  @doc "Sampling Heap Profile node. Holds callsite information, allocation statistics and child nodes."
  @type SamplingHeapProfileNode :: %{
          callFrame: Runtime.CallFrame,
          children: list(HeapProfiler.SamplingHeapProfileNode),
          id: integer(),
          selfSize: number()
        }

  @doc "A single sample from a sampling profile."
  @type SamplingHeapProfileSample :: %{
          nodeId: integer(),
          ordinal: number(),
          size: number()
        }

  @doc """
  Enables console to refer to the node with given id via $x (see Command Line API for more details
  $x functions).
  ## Parameters:
    - `heapObjectId:HeapSnapshotObjectId`: Heap snapshot object id to be accessible by means of $x command line API.
  """
  def add_inspected_heap_object(heap_object_id) do
    params = as_query([{"heapObjectId", heap_object_id}])
    {"HeapProfiler.addInspectedHeapObject", params}
  end

  @doc """
  """
  def collect_garbage() do
    {"HeapProfiler.collectGarbage", %{}}
  end

  @doc """
  """
  def disable() do
    {"HeapProfiler.disable", %{}}
  end

  @doc """
  """
  def enable() do
    {"HeapProfiler.enable", %{}}
  end

  @doc """
  ## Parameters:
    - `objectId:Runtime.RemoteObjectId`: Identifier of the object to get heap object id for.
  """
  def get_heap_object_id(object_id) do
    params = as_query([{"objectId", object_id}])
    {"HeapProfiler.getHeapObjectId", params}
  end

  @doc """
  ## Parameters:
    - `objectId:HeapSnapshotObjectId`: description not provided :(
    - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects.
  """
  def get_object_by_heap_object_id(object_id, object_group \\ nil) do
    params = as_query([{"objectId", object_id}, {"objectGroup", object_group}])
    {"HeapProfiler.getObjectByHeapObjectId", params}
  end

  @doc """
  """
  def get_sampling_profile() do
    {"HeapProfiler.getSamplingProfile", %{}}
  end

  @doc """
  ## Parameters:
    - `samplingInterval:number`: (Optional) Average sample interval in bytes. Poisson distribution is used for the intervals. The
  default value is 32768 bytes.
    - `includeObjectsCollectedByMajorGC:boolean`: (Optional) By default, the sampling heap profiler reports only objects which are
  still alive when the profile is returned via getSamplingProfile or
  stopSampling, which is useful for determining what functions contribute
  the most to steady-state memory usage. This flag instructs the sampling
  heap profiler to also include information about objects discarded by
  major GC, which will show which functions cause large temporary memory
  usage or long GC pauses.
    - `includeObjectsCollectedByMinorGC:boolean`: (Optional) By default, the sampling heap profiler reports only objects which are
  still alive when the profile is returned via getSamplingProfile or
  stopSampling, which is useful for determining what functions contribute
  the most to steady-state memory usage. This flag instructs the sampling
  heap profiler to also include information about objects discarded by
  minor GC, which is useful when tuning a latency-sensitive application
  for minimal GC activity.
  """
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
    - `trackAllocations:boolean`: (Optional) description not provided :(
  """
  def start_tracking_heap_objects(track_allocations \\ nil) do
    params = as_query([{"trackAllocations", track_allocations}])
    {"HeapProfiler.startTrackingHeapObjects", params}
  end

  @doc """
  """
  def stop_sampling() do
    {"HeapProfiler.stopSampling", %{}}
  end

  @doc """
  ## Parameters:
    - `reportProgress:boolean`: (Optional) If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken
  when the tracking is stopped.
    - `treatGlobalObjectsAsRoots:boolean`: (Optional) Deprecated in favor of `exposeInternals`.
    - `captureNumericValue:boolean`: (Optional) If true, numerical values are included in the snapshot
    - `exposeInternals:boolean`: (Optional) If true, exposes internals of the snapshot.
  """
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
    - `reportProgress:boolean`: (Optional) If true 'reportHeapSnapshotProgress' events will be generated while snapshot is being taken.
    - `treatGlobalObjectsAsRoots:boolean`: (Optional) If true, a raw snapshot without artificial roots will be generated.
  Deprecated in favor of `exposeInternals`.
    - `captureNumericValue:boolean`: (Optional) If true, numerical values are included in the snapshot
    - `exposeInternals:boolean`: (Optional) If true, exposes internals of the snapshot.
  """
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
