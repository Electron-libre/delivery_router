module DeliveryRouter
  class Riders
    def initialize(riders)
      self.state = riders.to_h { |r| [r.id, r] }
    end

    def get(id)
      state.fetch(id)
    end

    def min_delivery_time(order)
      state.values.min_by { |e| e.delivery_time(order) }
    end

    private
    attr_accessor :state
  end
end
