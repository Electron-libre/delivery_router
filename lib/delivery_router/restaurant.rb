require "delivery_router/locatable"

class Restaurant
  include Locatable

  attr_reader :cooking_time

  def initialize(opts)
    @cooking_time = opts.fetch(:cooking_time)
    super(opts)
  end
end
