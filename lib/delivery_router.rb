require 'delivery_router/customer'
require 'delivery_router/restaurant'
require 'delivery_router/rider'
require 'delivery_router/router'

module DeliveryRouter
  def self.new(*args)
    Router.new(*args)
  end
end
