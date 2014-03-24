require_relative 'actors'

module Actors
  Input = actor do
    Output.push gets
  end

  Output = actor do
    puts pop
  end
end

Actors.run [Actors::Input, Actors::Output]
