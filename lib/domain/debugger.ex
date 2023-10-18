defmodule CDPotion.Domain.Debugger do

@doc """
Continues execution until specific location is reached.
## Parameters:
  - `location:Location`: Location to continue to.
  - `targetCallFrames:string`: (Optional) description not provided :(
"""
def continue_to_location(location, target_call_frames \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disables debugger for given page.
"""
def disable() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables debugger for the given page. Clients should not assume that the debugging has been
enabled until the result for this command is received.
## Parameters:
  - `maxScriptsCacheSize:number`: (Optional) The maximum size in bytes of collected scripts (not referenced by other heap objects)
the debugger can hold. Puts no limit if parameter is omitted.
"""
def enable(max_scripts_cache_size \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Evaluates expression on a given call frame.
## Parameters:
  - `callFrameId:CallFrameId`: Call frame identifier to evaluate on.
  - `expression:string`: Expression to evaluate.
  - `objectGroup:string`: (Optional) String object group name to put result into (allows rapid releasing resulting object handles
using `releaseObjectGroup`).
  - `includeCommandLineAPI:boolean`: (Optional) Specifies whether command line API should be available to the evaluated expression, defaults
to false.
  - `silent:boolean`: (Optional) In silent mode exceptions thrown during evaluation are not reported and do not pause
execution. Overrides `setPauseOnException` state.
  - `returnByValue:boolean`: (Optional) Whether the result is expected to be a JSON object that should be sent by value.
  - `generatePreview:boolean`: (Optional) Whether preview should be generated for the result.
  - `throwOnSideEffect:boolean`: (Optional) Whether to throw an exception if side effect cannot be ruled out during evaluation.
  - `timeout:Runtime.TimeDelta`: (Optional) Terminate execution after timing out (number of milliseconds).
"""
def evaluate_on_call_frame(
      call_frame_id,
      expression,
      object_group \\ nil,
      include_command_line_ap_i \\ nil,
      silent \\ nil,
      return_by_value \\ nil,
      generate_preview \\ nil,
      throw_on_side_effect \\ nil,
      timeout \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns possible locations for breakpoint. scriptId in start and end range locations should be
the same.
## Parameters:
  - `start:Location`: Start of range to search possible breakpoint locations in.
  - `end:Location`: (Optional) End of range to search possible breakpoint locations in (excluding). When not specified, end
of scripts is used as end of range.
  - `restrictToFunction:boolean`: (Optional) Only consider locations which are in the same (non-nested) function as start.
"""
def get_possible_breakpoints(start, end! \\ nil, restrict_to_function \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns source for the script with given id.
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the script to get source for.
"""
def get_script_source(script_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the script to disassemble
"""
def disassemble_wasm_module(script_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Disassemble the next chunk of lines for the module corresponding to the
stream. If disassembly is complete, this API will invalidate the streamId
and return an empty chunk. Any subsequent calls for the now invalid stream
will return errors.
## Parameters:
  - `streamId:string`: description not provided :(
"""
def next_wasm_disassembly_chunk(stream_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
This command is deprecated. Use getScriptSource instead.
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the Wasm script to get source for.
"""
def get_wasm_bytecode(script_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Returns stack trace with given `stackTraceId`.
## Parameters:
  - `stackTraceId:Runtime.StackTraceId`: description not provided :(
"""
def get_stack_trace(stack_trace_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Stops on the next JavaScript statement.
"""
def pause() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
## Parameters:
  - `parentStackTraceId:Runtime.StackTraceId`: Debugger will pause when async call with given stack trace is started.
"""
def pause_on_async_call(parent_stack_trace_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Removes JavaScript breakpoint.
## Parameters:
  - `breakpointId:BreakpointId`: description not provided :(
"""
def remove_breakpoint(breakpoint_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Restarts particular call frame from the beginning. The old, deprecated
behavior of `restartFrame` is to stay paused and allow further CDP commands
after a restart was scheduled. This can cause problems with restarting, so
we now continue execution immediatly after it has been scheduled until we
reach the beginning of the restarted frame.
To stay back-wards compatible, `restartFrame` now expects a `mode`
parameter to be present. If the `mode` parameter is missing, `restartFrame`
errors out.
The various return values are deprecated and `callFrames` is always empty.
Use the call frames from the `Debugger#paused` events instead, that fires
once V8 pauses at the beginning of the restarted function.
## Parameters:
  - `callFrameId:CallFrameId`: Call frame identifier to evaluate on.
  - `mode:string`: (Optional) The `mode` parameter must be present and set to 'StepInto', otherwise
`restartFrame` will error out.
"""
def restart_frame(call_frame_id, mode \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Resumes JavaScript execution.
## Parameters:
  - `terminateOnResume:boolean`: (Optional) Set to true to terminate execution upon resuming execution. In contrast
to Runtime.terminateExecution, this will allows to execute further
JavaScript (i.e. via evaluation) until execution of the paused code
is actually resumed, at which point termination is triggered.
If execution is currently not paused, this parameter has no effect.
"""
def resume(terminate_on_resume \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Searches for given string in script content.
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the script to search in.
  - `query:string`: String to search for.
  - `caseSensitive:boolean`: (Optional) If true, search is case sensitive.
  - `isRegex:boolean`: (Optional) If true, treats string parameter as regex.
"""
def search_in_content(script_id, query, case_sensitive \\ nil, is_regex \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Enables or disables async call stacks tracking.
## Parameters:
  - `maxDepth:integer`: Maximum depth of async call stacks. Setting to `0` will effectively disable collecting async
call stacks (default).
"""
def set_async_call_stack_depth(max_depth) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Replace previous blackbox patterns with passed ones. Forces backend to skip stepping/pausing in
scripts with url matching one of the patterns. VM will try to leave blackboxed script by
performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
## Parameters:
  - `patterns:array`: Array of regexps that will be used to check script url for blackbox state.
"""
def set_blackbox_patterns(patterns) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Makes backend skip steps in the script in blackboxed ranges. VM will try leave blacklisted
scripts by performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
Positions array contains positions where blackbox state is changed. First interval isn't
blackboxed. Array should be sorted.
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the script.
  - `positions:array`: description not provided :(
"""
def set_blackboxed_ranges(script_id, positions) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Sets JavaScript breakpoint at a given location.
## Parameters:
  - `location:Location`: Location to set breakpoint in.
  - `condition:string`: (Optional) Expression to use as a breakpoint condition. When specified, debugger will only stop on the
breakpoint if this expression evaluates to true.
"""
def set_breakpoint(location, condition \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Sets instrumentation breakpoint.
## Parameters:
  - `instrumentation:string`: Instrumentation name.
"""
def set_instrumentation_breakpoint(instrumentation) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Sets JavaScript breakpoint at given location specified either by URL or URL regex. Once this
command is issued, all existing parsed scripts will have breakpoints resolved and returned in
`locations` property. Further matching script parsing will result in subsequent
`breakpointResolved` events issued. This logical breakpoint will survive page reloads.
## Parameters:
  - `lineNumber:integer`: Line number to set breakpoint at.
  - `url:string`: (Optional) URL of the resources to set breakpoint on.
  - `urlRegex:string`: (Optional) Regex pattern for the URLs of the resources to set breakpoints on. Either `url` or
`urlRegex` must be specified.
  - `scriptHash:string`: (Optional) Script hash of the resources to set breakpoint on.
  - `columnNumber:integer`: (Optional) Offset in the line to set breakpoint at.
  - `condition:string`: (Optional) Expression to use as a breakpoint condition. When specified, debugger will only stop on the
breakpoint if this expression evaluates to true.
"""
def set_breakpoint_by_url(
      line_number,
      url \\ nil,
      url_regex \\ nil,
      script_hash \\ nil,
      column_number \\ nil,
      condition \\ nil
    ) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Sets JavaScript breakpoint before each call to the given function.
If another function was created from the same source as a given one,
calling it will also trigger the breakpoint.
## Parameters:
  - `objectId:Runtime.RemoteObjectId`: Function object id.
  - `condition:string`: (Optional) Expression to use as a breakpoint condition. When specified, debugger will
stop on the breakpoint if this expression evaluates to true.
"""
def set_breakpoint_on_function_call(object_id, condition \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Activates / deactivates all breakpoints on the page.
## Parameters:
  - `active:boolean`: New value for breakpoints active state.
"""
def set_breakpoints_active(active) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Defines pause on exceptions state. Can be set to stop on all exceptions, uncaught exceptions,
or caught exceptions, no exceptions. Initial pause on exceptions state is `none`.
## Parameters:
  - `state:string`: Pause on exceptions mode.
"""
def set_pause_on_exceptions(state) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Changes return value in top frame. Available only at return break position.
## Parameters:
  - `newValue:Runtime.CallArgument`: New return value.
"""
def set_return_value(new_value) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Edits JavaScript source live.
In general, functions that are currently on the stack can not be edited with
a single exception: If the edited function is the top-most stack frame and
that is the only activation of that function on the stack. In this case
the live edit will be successful and a `Debugger.restartFrame` for the
top-most function is automatically triggered.
## Parameters:
  - `scriptId:Runtime.ScriptId`: Id of the script to edit.
  - `scriptSource:string`: New content of the script.
  - `dryRun:boolean`: (Optional) If true the change will not actually be applied. Dry run may be used to get result
description without actually modifying the code.
  - `allowTopFrameEditing:boolean`: (Optional) If true, then `scriptSource` is allowed to change the function on top of the stack
as long as the top-most stack frame is the only activation of that function.
"""
def set_script_source(script_id, script_source, dry_run \\ nil, allow_top_frame_editing \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Makes page not interrupt on any pauses (breakpoint, exception, dom exception etc).
## Parameters:
  - `skip:boolean`: New value for skip pauses state.
"""
def set_skip_all_pauses(skip) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Changes value of variable in a callframe. Object-based scopes are not supported and must be
mutated manually.
## Parameters:
  - `scopeNumber:integer`: 0-based number of scope as was listed in scope chain. Only 'local', 'closure' and 'catch'
scope types are allowed. Other scopes could be manipulated manually.
  - `variableName:string`: Variable name.
  - `newValue:Runtime.CallArgument`: New variable value.
  - `callFrameId:CallFrameId`: Id of callframe that holds variable.
"""
def set_variable_value(scope_number, variable_name, new_value, call_frame_id) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Steps into the function call.
## Parameters:
  - `breakOnAsyncCall:boolean`: (Optional) Debugger will pause on the execution of the first async task which was scheduled
before next pause.
  - `skipList:array`: (Optional) The skipList specifies location ranges that should be skipped on step into.
"""
def step_into(break_on_async_call \\ nil, skip_list \\ nil) do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Steps out of the function call.
"""
def step_out() do
  execute(session, :navigate, %{"url" => url})
end

@doc """
Steps over the statement.
## Parameters:
  - `skipList:array`: (Optional) The skipList specifies location ranges that should be skipped on step over.
"""
def step_over(skip_list \\ nil) do
  execute(session, :navigate, %{"url" => url})
end
end