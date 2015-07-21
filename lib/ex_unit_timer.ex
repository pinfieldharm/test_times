defmodule ExUnitTimer do

  def setup do
    ExUnit.configure(
      add_formatter(ExUnit.configuration, ExUnitTimer.TimeFormatter)
    )
  end

  defp add_formatter(config, f) do
    Keyword.update(config, :formatters, [f], &([f|&1]))
  end
end

