require 'delivery_router/order'
require 'delivery_router/orders'
require 'delivery_router/riders'

module DeliveryRouter
  class Router
    def initialize(restaurants, customers, riders)
      self.restaurants = restaurants
      self.customers = customers
      self.riders = Riders.new(riders)
      self.orders = Orders.new
    end

    def add_order(customer:, restaurant:)
      return [:error, :customer_not_found] unless c = customers[customer]
      return [:error, :restaurant_not_found] unless r = restaurants[restaurant]
      order = Order.new(c, r)
      order.rider = riders.min_delivery_time(order)
      if order.delivery_time < 60
         orders.add(order)
        [:ok, order.delivery_time]
      else
        [:error, :delivery_too_long]
      end
    end

    def clear_orders(customer:)
      orders.clear(customer)
    end

    def delivery_time(customer:)
      orders.get(customer).delivery_time
    end

    def route(rider:)
      orders.for_rider(rider).flat_map(&:to_route)
    end

    private

    attr_reader :customers, :restaurants,  :orders
    attr_accessor :riders, :orders

    def restaurants=(restaurants)
      @restaurants = restaurants.to_h { |r| [r.id, r] }
    end


    def customers=(customers)
      @customers = customers.to_h { |c| [c.id, c] }
    end

  end
end
