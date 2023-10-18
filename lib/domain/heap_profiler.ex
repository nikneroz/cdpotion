defmodule CDPotion.Domain.HeapProfiler do

@doc """
Enables console to refer to the node with given id via $x (see Command Line API for more details
$x functions).
## Parameters:
- `heapObjectId:HeapSnapshotObjectId`: Heap snapshot object id to be accessible by means of $x command line API.
"""
def add_inspected_heap_object(heap_object_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def collect_garbage() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def enable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `objectId:Runtime.RemoteObjectId`: Identifier of the object to get heap object id for.
"""
def get_heap_object_id(object_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `objectId:HeapSnapshotObjectId`: description not provided :(
  - `objectGroup:string`: (Optional) Symbolic group name that can be used to release multiple objects.
"""
def get_object_by_heap_object_id(object_id, object_group \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def get_sampling_profile() do
  execute(session, :navigate, %{"url" => url})
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
      include_objects_collected_by_major_g_c \\ nil,
      include_objects_collected_by_minor_g_c \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
- `trackAllocations:boolean`: (Optional) description not provided :(
"""
def start_tracking_heap_objects(track_allocations \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
"""
def stop_sampling() do
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
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
  execute(session, :navigate, %{"url" => url})
end
end