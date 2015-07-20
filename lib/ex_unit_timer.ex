defmodule ExUnitTimer do
  def initialize do
    IO.puts "hello!"
    ExUnit.configure(formatters: [ExUnitTimer.TimeFormatter|Dict.get(ExUnit.configuration, :formatters)])
  end
end

