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
    sorted = Enum.sort(results, fn (a,b) -> a.time < b.time end)
    rows = Enum.map(sorted, &test_to_row/1)
    widths = widths(rows)
    print_time_reports(rows, widths)
    :remove_handler
  end

  def handle_event(_, results) do
    {:ok, results}
  end

  defp widths(rows) do
    time = String.length(hd(List.last(rows)))
    path = Enum.max(Enum.map(rows, fn [_, path, _] -> String.length(path) end))
    name = max(terminal_width - (time + path + 6), 20)
    %{time: time, path: path, name: name}
  end

  defp test_to_row(t) do
    ["#{t.time}", 
      relative_location(t), 
      String.replace("#{t.name}", ~r/test /,"", global: false)]
  end

  defp print_time_reports(rows, widths) do
    Enum.each( rows, 
      &(:io.format("~#{widths.time}s | ~#{widths.path}s | ~-#{widths.name}s~n", &1))
    )
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
