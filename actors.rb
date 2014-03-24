require 'thread'

module Actors
  class Actor
    def self.run
      Thread.new do
        begin
          loop do
            instance_eval(&@block)
          end
        rescue Exception => e
          puts e
        end
      end
    end

    def self.add_block(block)
      @block = block
    end

    def self.push(value)
      queue << value
    end

    def self.pop
      queue.pop
    end

    def self.queue
      @queue ||= Queue.new
    end
  end

  def self.const_missing(name)
    const_set(name, Class.new(Actor))
  end

  def self.actor(class_, &block)
    class_.add_block(block)
  end

  def self.run(actors)
    threads = actors.map { |actor| actor.run }
    threads.each { |thread| thread.join }
  end
end
