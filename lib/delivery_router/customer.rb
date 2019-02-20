require "delivery_router/locatable"

class Customer
  include Locatable
  def initialize(opts)
    super(opts)
  end
end
