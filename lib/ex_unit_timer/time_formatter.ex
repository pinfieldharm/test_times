defmodule ExUnitTimer.TimeFormatter do
  require Logger
  use GenEvent
  
  def init(_opts) do
    results = []
    {:ok, results}
  end

  def handle_event({:test_finished, %ExUnit.Test{state: nil} = test}, results) do
    {:ok, [test | results]}
  end

  def handle_event({:suite_finished, _, _}, results) do
    print_time_reports(results)
    :remove_handler
  end

  def handle_event(_, results) do
    {:ok, results}
  end

  defp print_time_reports(results) do
    
    sorted = Enum.sort(results, fn (a,b) -> a.time < b.time end)
    time_width = String.length("#{List.last(sorted).time}")
    
    mapped = Enum.map(sorted, &([&1.time, relative_location(&1), String.replace("#{&1.name}", ~r/test /,"", global: false)]))
    path_width = Enum.max(Enum.map(mapped, fn [_, path, _] -> String.length(path) end))
    name_width = max(terminal_width - (time_width + path_width + 6), 20)
    Enum.each(mapped, fn [time, path, name] -> :io.format("~#{time_width}s | ~#{path_width}s | ~-#{name_width}.#{name_width}s~n", ["#{time}", "#{path}", "#{name}"]) end) 

  end

  defp terminal_width do
    try do
      case System.cmd("tput", ["cols"]) do
        {w, 0} -> elem(Integer.parse(w),0)
        x -> 80
      end
    catch
      _ -> 80
    end
  end

  defp relative_location(test) do
    "#{Path.relative_to_cwd(test.tags[:file])}:#{test.tags[:line]}"
  end


end
