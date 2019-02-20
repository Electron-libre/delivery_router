module DeliveryRouter
  class Orders
    def initialize
      self.state = {}
    end

    def add(order)
      state.store order.customer.id, order
    end

    def clear(customer_id)
      state.delete(customer_id)
    end

    def get(customer_id)
      state.fetch(customer_id)
    end

    def for_rider(rider_id)
      state.values.select { |e| e.rider.id == rider_id }
    end

    private

    attr_accessor :state
  end
end
