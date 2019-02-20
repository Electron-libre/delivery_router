require "delivery_router/locatable"

class Rider
  include Locatable

  attr_reader :speed

  def initialize(opts)
    @speed = opts.fetch(:speed)
    super(opts)
  end

  # @param [#x, #y]  locatable
  # @return [Float] Minutes to reach location
  def time_to(locatable, from = self)
    distance_to(locatable) / speed * 60
  end

  def delivery_time(order)
    [time_to(order.restaurant), order.restaurant.cooking_time].max +
      time_to(order.customer, order.restaurant)
  end
end
