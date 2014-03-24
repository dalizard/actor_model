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

  def self.actor(&block)
    class_ = Class.new(Actor)
    class_.add_block(block)
    class_
  end

  def self.run(actors)
    threads = actors.map { |actor| actor.run }
    threads.each { |thread| thread.join }
  end
end
