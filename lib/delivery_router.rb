require 'delivery_router/customer'
require 'delivery_router/restaurant'
require 'delivery_router/rider'
require 'delivery_router/router'

module DeliveryRouter
  extend SingleForwardable
  def_delegator Router, :new
end
