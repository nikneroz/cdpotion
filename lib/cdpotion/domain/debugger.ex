defmodule CDPotion.Domain.Debugger do
  use CDPotion.Utils
  @typedoc "description not provided :("
  @type break_location :: %{
          columnNumber: integer() | nil,
          lineNumber: integer(),
          scriptId: CDPotion.Domain.Runtime.script_id(),
          type: :debuggerStatement | :call | :return | nil
        }

  @typedoc "Breakpoint identifier."
  @type breakpoint_id :: String.t()

  @typedoc "JavaScript call frame. Array of call frames form the call stack."
  @type call_frame :: %{
          callFrameId: CDPotion.Domain.Debugger.call_frame_id(),
          canBeRestarted: boolean() | nil,
          functionLocation: CDPotion.Domain.Debugger.location() | nil,
          functionName: String.t(),
          location: CDPotion.Domain.Debugger.location(),
          returnValue: CDPotion.Domain.Runtime.remote_object() | nil,
          scopeChain: list(CDPotion.Domain.Debugger.scope()),
          this: CDPotion.Domain.Runtime.remote_object(),
          url: String.t()
        }

  @typedoc "Call frame identifier."
  @type call_frame_id :: String.t()

  @typedoc "Debug symbols available for a wasm script."
  @type debug_symbols :: %{
          externalURL: String.t() | nil,
          type: :None | :SourceMap | :EmbeddedDWARF | :ExternalDWARF
        }

  @typedoc "Location in the source code."
  @type location :: %{
          columnNumber: integer() | nil,
          lineNumber: integer(),
          scriptId: CDPotion.Domain.Runtime.script_id()
        }

  @typedoc "Location range within one script."
  @type location_range :: %{
          end: CDPotion.Domain.Debugger.script_position(),
          scriptId: CDPotion.Domain.Runtime.script_id(),
          start: CDPotion.Domain.Debugger.script_position()
        }

  @typedoc "Scope description."
  @type scope :: %{
          endLocation: CDPotion.Domain.Debugger.location() | nil,
          name: String.t() | nil,
          object: CDPotion.Domain.Runtime.remote_object(),
          startLocation: CDPotion.Domain.Debugger.location() | nil,
          type:
            :global
            | :local
            | :with
            | :closure
            | :catch
            | :block
            | :script
            | :eval
            | :module
            | :"wasm-expression-stack"
        }

  @typedoc "Enum of possible script languages."
  @type script_language :: :JavaScript | :WebAssembly

  @typedoc "Location in the source code."
  @type script_position :: %{
          columnNumber: integer(),
          lineNumber: integer()
        }

  @typedoc "Search match for resource."
  @type search_match :: %{
          lineContent: String.t(),
          lineNumber: number()
        }

  @typedoc "description not provided :("
  @type wasm_disassembly_chunk :: %{
          bytecodeOffsets: list(integer()),
          lines: list(String.t())
        }

  @doc """
  Continues execution until specific location is reached.
  ## Parameters:
    - (Required) `location`: Location to continue to.
  - (Optional) `target_call_frames`: description not provided :(
  """
  @spec continue_to_location(CDPotion.Domain.Debugger.Location, String.t()) :: {String.t(), map()}
  def continue_to_location(location, target_call_frames \\ nil) do
    params = as_query([{"location", location}, {"targetCallFrames", target_call_frames}])
    {"Debugger.continueToLocation", params}
  end

  @doc """
  Disables debugger for given page.
  """
  @spec disable() :: {String.t(), map()}
  def disable() do
    {"Debugger.disable", %{}}
  end

  @doc """
  Enables debugger for the given page. Clients should not assume that the debugging has been
  enabled until the result for this command is received.
  ## Parameters:
    - (Optional) `max_scripts_cache_size`: The maximum size in bytes of collected scripts (not referenced by other heap objects)
  the debugger can hold. Puts no limit if parameter is omitted.
  """
  @spec enable(number()) :: {String.t(), map()}
  def enable(max_scripts_cache_size \\ nil) do
    params = as_query([{"maxScriptsCacheSize", max_scripts_cache_size}])
    {"Debugger.enable", params}
  end

  @doc """
  Evaluates expression on a given call frame.
  ## Parameters:
    - (Required) `call_frame_id`: Call frame identifier to evaluate on.
  - (Required) `expression`: Expression to evaluate.
  - (Optional) `object_group`: String object group name to put result into (allows rapid releasing resulting object handles
  using `releaseObjectGroup`).
  - (Optional) `include_command_line_api`: Specifies whether command line API should be available to the evaluated expression, defaults
  to false.
  - (Optional) `silent`: In silent mode exceptions thrown during evaluation are not reported and do not pause
  execution. Overrides `setPauseOnException` state.
  - (Optional) `return_by_value`: Whether the result is expected to be a JSON object that should be sent by value.
  - (Optional) `generate_preview`: Whether preview should be generated for the result.
  - (Optional) `throw_on_side_effect`: Whether to throw an exception if side effect cannot be ruled out during evaluation.
  - (Optional) `timeout`: Terminate execution after timing out (number of milliseconds).
  """
  @spec evaluate_on_call_frame(
          CDPotion.Domain.Debugger.CallFrameId,
          String.t(),
          String.t(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          boolean(),
          CDPotion.Domain.Runtime.TimeDelta
        ) :: {String.t(), map()}
  def evaluate_on_call_frame(
        call_frame_id,
        expression,
        object_group \\ nil,
        include_command_line_api \\ nil,
        silent \\ nil,
        return_by_value \\ nil,
        generate_preview \\ nil,
        throw_on_side_effect \\ nil,
        timeout \\ nil
      ) do
    params =
      as_query([
        {"callFrameId", call_frame_id},
        {"expression", expression},
        {"objectGroup", object_group},
        {"includeCommandLineAPI", include_command_line_api},
        {"silent", silent},
        {"returnByValue", return_by_value},
        {"generatePreview", generate_preview},
        {"throwOnSideEffect", throw_on_side_effect},
        {"timeout", timeout}
      ])

    {"Debugger.evaluateOnCallFrame", params}
  end

  @doc """
  Returns possible locations for breakpoint. scriptId in start and end range locations should be
  the same.
  ## Parameters:
    - (Required) `start`: Start of range to search possible breakpoint locations in.
  - (Optional) `end`: End of range to search possible breakpoint locations in (excluding). When not specified, end
  of scripts is used as end of range.
  - (Optional) `restrict_to_function`: Only consider locations which are in the same (non-nested) function as start.
  """
  @spec get_possible_breakpoints(
          CDPotion.Domain.Debugger.Location,
          CDPotion.Domain.Debugger.Location,
          boolean()
        ) :: {String.t(), map()}
  def get_possible_breakpoints(start, end! \\ nil, restrict_to_function \\ nil) do
    params =
      as_query([{"start", start}, {"end", end!}, {"restrictToFunction", restrict_to_function}])

    {"Debugger.getPossibleBreakpoints", params}
  end

  @doc """
  Returns source for the script with given id.
  ## Parameters:
    - (Required) `script_id`: Id of the script to get source for.
  """
  @spec get_script_source(CDPotion.Domain.Runtime.ScriptId) :: {String.t(), map()}
  def get_script_source(script_id) do
    params = as_query([{"scriptId", script_id}])
    {"Debugger.getScriptSource", params}
  end

  @doc """

  ## Parameters:
    - (Required) `script_id`: Id of the script to disassemble
  """
  @spec disassemble_wasm_module(CDPotion.Domain.Runtime.ScriptId) :: {String.t(), map()}
  def disassemble_wasm_module(script_id) do
    params = as_query([{"scriptId", script_id}])
    {"Debugger.disassembleWasmModule", params}
  end

  @doc """
  Disassemble the next chunk of lines for the module corresponding to the
  stream. If disassembly is complete, this API will invalidate the streamId
  and return an empty chunk. Any subsequent calls for the now invalid stream
  will return errors.
  ## Parameters:
    - (Required) `stream_id`: description not provided :(
  """
  @spec next_wasm_disassembly_chunk(String.t()) :: {String.t(), map()}
  def next_wasm_disassembly_chunk(stream_id) do
    params = as_query([{"streamId", stream_id}])
    {"Debugger.nextWasmDisassemblyChunk", params}
  end

  @doc """
  This command is deprecated. Use getScriptSource instead.
  ## Parameters:
    - (Required) `script_id`: Id of the Wasm script to get source for.
  """
  @spec get_wasm_bytecode(CDPotion.Domain.Runtime.ScriptId) :: {String.t(), map()}
  def get_wasm_bytecode(script_id) do
    params = as_query([{"scriptId", script_id}])
    {"Debugger.getWasmBytecode", params}
  end

  @doc """
  Returns stack trace with given `stackTraceId`.
  ## Parameters:
    - (Required) `stack_trace_id`: description not provided :(
  """
  @spec get_stack_trace(CDPotion.Domain.Runtime.StackTraceId) :: {String.t(), map()}
  def get_stack_trace(stack_trace_id) do
    params = as_query([{"stackTraceId", stack_trace_id}])
    {"Debugger.getStackTrace", params}
  end

  @doc """
  Stops on the next JavaScript statement.
  """
  @spec pause() :: {String.t(), map()}
  def pause() do
    {"Debugger.pause", %{}}
  end

  @doc """

  ## Parameters:
    - (Required) `parent_stack_trace_id`: Debugger will pause when async call with given stack trace is started.
  """
  @spec pause_on_async_call(CDPotion.Domain.Runtime.StackTraceId) :: {String.t(), map()}
  def pause_on_async_call(parent_stack_trace_id) do
    params = as_query([{"parentStackTraceId", parent_stack_trace_id}])
    {"Debugger.pauseOnAsyncCall", params}
  end

  @doc """
  Removes JavaScript breakpoint.
  ## Parameters:
    - (Required) `breakpoint_id`: description not provided :(
  """
  @spec remove_breakpoint(CDPotion.Domain.Debugger.BreakpointId) :: {String.t(), map()}
  def remove_breakpoint(breakpoint_id) do
    params = as_query([{"breakpointId", breakpoint_id}])
    {"Debugger.removeBreakpoint", params}
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
    - (Required) `call_frame_id`: Call frame identifier to evaluate on.
  - (Optional) `mode`: The `mode` parameter must be present and set to 'StepInto', otherwise
  `restartFrame` will error out.
  """
  @spec restart_frame(CDPotion.Domain.Debugger.CallFrameId, String.t()) :: {String.t(), map()}
  def restart_frame(call_frame_id, mode \\ nil) do
    params = as_query([{"callFrameId", call_frame_id}, {"mode", mode}])
    {"Debugger.restartFrame", params}
  end

  @doc """
  Resumes JavaScript execution.
  ## Parameters:
    - (Optional) `terminate_on_resume`: Set to true to terminate execution upon resuming execution. In contrast
  to Runtime.terminateExecution, this will allows to execute further
  JavaScript (i.e. via evaluation) until execution of the paused code
  is actually resumed, at which point termination is triggered.
  If execution is currently not paused, this parameter has no effect.
  """
  @spec resume(boolean()) :: {String.t(), map()}
  def resume(terminate_on_resume \\ nil) do
    params = as_query([{"terminateOnResume", terminate_on_resume}])
    {"Debugger.resume", params}
  end

  @doc """
  Searches for given string in script content.
  ## Parameters:
    - (Required) `script_id`: Id of the script to search in.
  - (Required) `query`: String to search for.
  - (Optional) `case_sensitive`: If true, search is case sensitive.
  - (Optional) `is_regex`: If true, treats string parameter as regex.
  """
  @spec search_in_content(CDPotion.Domain.Runtime.ScriptId, String.t(), boolean(), boolean()) ::
          {String.t(), map()}
  def search_in_content(script_id, query, case_sensitive \\ nil, is_regex \\ nil) do
    params =
      as_query([
        {"scriptId", script_id},
        {"query", query},
        {"caseSensitive", case_sensitive},
        {"isRegex", is_regex}
      ])

    {"Debugger.searchInContent", params}
  end

  @doc """
  Enables or disables async call stacks tracking.
  ## Parameters:
    - (Required) `max_depth`: Maximum depth of async call stacks. Setting to `0` will effectively disable collecting async
  call stacks (default).
  """
  @spec set_async_call_stack_depth(integer()) :: {String.t(), map()}
  def set_async_call_stack_depth(max_depth) do
    params = as_query([{"maxDepth", max_depth}])
    {"Debugger.setAsyncCallStackDepth", params}
  end

  @doc """
  Replace previous blackbox patterns with passed ones. Forces backend to skip stepping/pausing in
  scripts with url matching one of the patterns. VM will try to leave blackboxed script by
  performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
  ## Parameters:
    - (Required) `patterns`: Array of regexps that will be used to check script url for blackbox state.
  """
  @spec set_blackbox_patterns(list(String.t())) :: {String.t(), map()}
  def set_blackbox_patterns(patterns) do
    params = as_query([{"patterns", patterns}])
    {"Debugger.setBlackboxPatterns", params}
  end

  @doc """
  Makes backend skip steps in the script in blackboxed ranges. VM will try leave blacklisted
  scripts by performing 'step in' several times, finally resorting to 'step out' if unsuccessful.
  Positions array contains positions where blackbox state is changed. First interval isn't
  blackboxed. Array should be sorted.
  ## Parameters:
    - (Required) `script_id`: Id of the script.
  - (Required) `positions`: description not provided :(
  """
  @spec set_blackboxed_ranges(
          CDPotion.Domain.Runtime.ScriptId,
          list(CDPotion.Domain.Debugger.ScriptPosition)
        ) :: {String.t(), map()}
  def set_blackboxed_ranges(script_id, positions) do
    params = as_query([{"scriptId", script_id}, {"positions", positions}])
    {"Debugger.setBlackboxedRanges", params}
  end

  @doc """
  Sets JavaScript breakpoint at a given location.
  ## Parameters:
    - (Required) `location`: Location to set breakpoint in.
  - (Optional) `condition`: Expression to use as a breakpoint condition. When specified, debugger will only stop on the
  breakpoint if this expression evaluates to true.
  """
  @spec set_breakpoint(CDPotion.Domain.Debugger.Location, String.t()) :: {String.t(), map()}
  def set_breakpoint(location, condition \\ nil) do
    params = as_query([{"location", location}, {"condition", condition}])
    {"Debugger.setBreakpoint", params}
  end

  @doc """
  Sets instrumentation breakpoint.
  ## Parameters:
    - (Required) `instrumentation`: Instrumentation name.
  """
  @spec set_instrumentation_breakpoint(String.t()) :: {String.t(), map()}
  def set_instrumentation_breakpoint(instrumentation) do
    params = as_query([{"instrumentation", instrumentation}])
    {"Debugger.setInstrumentationBreakpoint", params}
  end

  @doc """
  Sets JavaScript breakpoint at given location specified either by URL or URL regex. Once this
  command is issued, all existing parsed scripts will have breakpoints resolved and returned in
  `locations` property. Further matching script parsing will result in subsequent
  `breakpointResolved` events issued. This logical breakpoint will survive page reloads.
  ## Parameters:
    - (Required) `line_number`: Line number to set breakpoint at.
  - (Optional) `url`: URL of the resources to set breakpoint on.
  - (Optional) `url_regex`: Regex pattern for the URLs of the resources to set breakpoints on. Either `url` or
  `urlRegex` must be specified.
  - (Optional) `script_hash`: Script hash of the resources to set breakpoint on.
  - (Optional) `column_number`: Offset in the line to set breakpoint at.
  - (Optional) `condition`: Expression to use as a breakpoint condition. When specified, debugger will only stop on the
  breakpoint if this expression evaluates to true.
  """
  @spec set_breakpoint_by_url(
          integer(),
          String.t(),
          String.t(),
          String.t(),
          integer(),
          String.t()
        ) :: {String.t(), map()}
  def set_breakpoint_by_url(
        line_number,
        url \\ nil,
        url_regex \\ nil,
        script_hash \\ nil,
        column_number \\ nil,
        condition \\ nil
      ) do
    params =
      as_query([
        {"lineNumber", line_number},
        {"url", url},
        {"urlRegex", url_regex},
        {"scriptHash", script_hash},
        {"columnNumber", column_number},
        {"condition", condition}
      ])

    {"Debugger.setBreakpointByUrl", params}
  end

  @doc """
  Sets JavaScript breakpoint before each call to the given function.
  If another function was created from the same source as a given one,
  calling it will also trigger the breakpoint.
  ## Parameters:
    - (Required) `object_id`: Function object id.
  - (Optional) `condition`: Expression to use as a breakpoint condition. When specified, debugger will
  stop on the breakpoint if this expression evaluates to true.
  """
  @spec set_breakpoint_on_function_call(CDPotion.Domain.Runtime.RemoteObjectId, String.t()) ::
          {String.t(), map()}
  def set_breakpoint_on_function_call(object_id, condition \\ nil) do
    params = as_query([{"objectId", object_id}, {"condition", condition}])
    {"Debugger.setBreakpointOnFunctionCall", params}
  end

  @doc """
  Activates / deactivates all breakpoints on the page.
  ## Parameters:
    - (Required) `active`: New value for breakpoints active state.
  """
  @spec set_breakpoints_active(boolean()) :: {String.t(), map()}
  def set_breakpoints_active(active) do
    params = as_query([{"active", active}])
    {"Debugger.setBreakpointsActive", params}
  end

  @doc """
  Defines pause on exceptions state. Can be set to stop on all exceptions, uncaught exceptions,
  or caught exceptions, no exceptions. Initial pause on exceptions state is `none`.
  ## Parameters:
    - (Required) `state`: Pause on exceptions mode.
  """
  @spec set_pause_on_exceptions(String.t()) :: {String.t(), map()}
  def set_pause_on_exceptions(state) do
    params = as_query([{"state", state}])
    {"Debugger.setPauseOnExceptions", params}
  end

  @doc """
  Changes return value in top frame. Available only at return break position.
  ## Parameters:
    - (Required) `new_value`: New return value.
  """
  @spec set_return_value(CDPotion.Domain.Runtime.CallArgument) :: {String.t(), map()}
  def set_return_value(new_value) do
    params = as_query([{"newValue", new_value}])
    {"Debugger.setReturnValue", params}
  end

  @doc """
  Edits JavaScript source live.
  In general, functions that are currently on the stack can not be edited with
  a single exception: If the edited function is the top-most stack frame and
  that is the only activation of that function on the stack. In this case
  the live edit will be successful and a `Debugger.restartFrame` for the
  top-most function is automatically triggered.
  ## Parameters:
    - (Required) `script_id`: Id of the script to edit.
  - (Required) `script_source`: New content of the script.
  - (Optional) `dry_run`: If true the change will not actually be applied. Dry run may be used to get result
  description without actually modifying the code.
  - (Optional) `allow_top_frame_editing`: If true, then `scriptSource` is allowed to change the function on top of the stack
  as long as the top-most stack frame is the only activation of that function.
  """
  @spec set_script_source(CDPotion.Domain.Runtime.ScriptId, String.t(), boolean(), boolean()) ::
          {String.t(), map()}
  def set_script_source(script_id, script_source, dry_run \\ nil, allow_top_frame_editing \\ nil) do
    params =
      as_query([
        {"scriptId", script_id},
        {"scriptSource", script_source},
        {"dryRun", dry_run},
        {"allowTopFrameEditing", allow_top_frame_editing}
      ])

    {"Debugger.setScriptSource", params}
  end

  @doc """
  Makes page not interrupt on any pauses (breakpoint, exception, dom exception etc).
  ## Parameters:
    - (Required) `skip`: New value for skip pauses state.
  """
  @spec set_skip_all_pauses(boolean()) :: {String.t(), map()}
  def set_skip_all_pauses(skip) do
    params = as_query([{"skip", skip}])
    {"Debugger.setSkipAllPauses", params}
  end

  @doc """
  Changes value of variable in a callframe. Object-based scopes are not supported and must be
  mutated manually.
  ## Parameters:
    - (Required) `scope_number`: 0-based number of scope as was listed in scope chain. Only 'local', 'closure' and 'catch'
  scope types are allowed. Other scopes could be manipulated manually.
  - (Required) `variable_name`: Variable name.
  - (Required) `new_value`: New variable value.
  - (Required) `call_frame_id`: Id of callframe that holds variable.
  """
  @spec set_variable_value(
          integer(),
          String.t(),
          CDPotion.Domain.Runtime.CallArgument,
          CDPotion.Domain.Debugger.CallFrameId
        ) :: {String.t(), map()}
  def set_variable_value(scope_number, variable_name, new_value, call_frame_id) do
    params =
      as_query([
        {"scopeNumber", scope_number},
        {"variableName", variable_name},
        {"newValue", new_value},
        {"callFrameId", call_frame_id}
      ])

    {"Debugger.setVariableValue", params}
  end

  @doc """
  Steps into the function call.
  ## Parameters:
    - (Optional) `break_on_async_call`: Debugger will pause on the execution of the first async task which was scheduled
  before next pause.
  - (Optional) `skip_list`: The skipList specifies location ranges that should be skipped on step into.
  """
  @spec step_into(boolean(), list(CDPotion.Domain.Debugger.LocationRange)) :: {String.t(), map()}
  def step_into(break_on_async_call \\ nil, skip_list \\ nil) do
    params = as_query([{"breakOnAsyncCall", break_on_async_call}, {"skipList", skip_list}])
    {"Debugger.stepInto", params}
  end

  @doc """
  Steps out of the function call.
  """
  @spec step_out() :: {String.t(), map()}
  def step_out() do
    {"Debugger.stepOut", %{}}
  end

  @doc """
  Steps over the statement.
  ## Parameters:
    - (Optional) `skip_list`: The skipList specifies location ranges that should be skipped on step over.
  """
  @spec step_over(list(CDPotion.Domain.Debugger.LocationRange)) :: {String.t(), map()}
  def step_over(skip_list \\ nil) do
    params = as_query([{"skipList", skip_list}])
    {"Debugger.stepOver", params}
  end
end
