defmodule ExUnitTimer do

  def setup do
    if Enum.member?(System.argv, "--times") do
      ExUnit.configure(
        add_formatter(ExUnit.configuration, ExUnitTimer.TimeFormatter)
      )
    end
  end

  defp add_formatter(config, f) do
    Keyword.update(config, :formatters, [f], &([f|&1]))
  end
end

