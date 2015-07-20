defmodule ExUnitTimer.TimeFormatter do
  
  use GenEvent
  
  def init(opts) do
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
    sorted = Enum.sort(results, fn (a,b) -> a.time > b.time end)
    time_width = String.length("#{hd(sorted)}")
    name_width = Enum.max(Enum.map(results, fn(r) -> String.length(r.name) end))
    case_width = Enum.max(Enum.map(results, fn(r) -> String.length(r.case) end))
    
    Enum.each(sorted, fn(t) -> :io.format("~#{time_width}s | ~#{case_width}s | ~#{name_width}", ["#{t.time}", "#{t.case}", "#{t.name}"]) end) 

  end

end
