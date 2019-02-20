module Locatable
  def self.included(base)
    base.class_eval do
      include Behaviour
      attr_reader :id, :x, :y
    end
  end

  module Behaviour
    def initialize(opts)
      @id = opts.fetch(:id)
      @x = opts.fetch(:x)
      @y = opts.fetch(:y)
    end


    # @param [#x, #y] locatable 
    # @return [Float] kilometers to location
    def distance_to(locatable, from = self)
      x_diff = (from.x - locatable.x).abs
      y_diff = (from.y - locatable.y).abs
      Math.sqrt(x_diff ** 2 +  y_diff ** 2)
    end
  end
end
