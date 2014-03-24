require_relative 'actors'

module Actors
  actor Input do
    Output.push gets
  end

  actor Output do
    puts pop
  end
end

Actors.run [Actors::Input, Actors::Output]
