class Order
  attr_reader :customer, :restaurant
  attr_accessor :rider

  def initialize(customer, restaurant)
    @customer = customer
    @restaurant = restaurant
  end

  def to_route
    [restaurant, customer]
  end

  def delivery_time
    rider.delivery_time(self)
  end
end
