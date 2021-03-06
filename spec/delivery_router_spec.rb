describe DeliveryRouter do
  describe "#route" do

    before(:all) do
      @customers = [
        Customer.new(:id => 1, :x => 1, :y => 1),
        Customer.new(:id => 2, :x => 5, :y => 1),
      ]
      @restaurants = [
        Restaurant.new(:id => 3, :cooking_time => 15, :x => 0, :y => 0),
        Restaurant.new(:id => 4, :cooking_time => 35, :x => 5, :y => 5),
      ]
      @riders = [
        Rider.new(:id => 1, :speed => 10, :x => 2, :y => 0),
        Rider.new(:id => 2, :speed => 10, :x => 1, :y => 0),
      ]
      @delivery_router = DeliveryRouter.new(@restaurants, @customers, @riders)
    end

    context "given customer 1 orders from restaurant 3" do
      before(:all) do
        @delivery_router.add_order(:customer => 1, :restaurant => 3)
      end

      context "given customer 2 does not order anything" do
        before(:all) do
          @delivery_router.clear_orders(:customer => 2)
        end

        it "does not assign a route to rider 1" do
          route = @delivery_router.route(:rider => 1)
          expect(route).to be_empty
        end

        it "sends rider 2 to customer 1 through restaurant 3" do
          route = @delivery_router.route(:rider => 2)
          expect(route.length).to eql(2)
          expect(route[0].id).to eql(3)
          expect(route[1].id).to eql(1)
        end

        it "delights customer 1" do
          expect(@delivery_router.delivery_time(:customer => 1)).to be < 60
        end
      end

      context "given customer 2 orders from restaurant 4" do
        before(:all) do
          @delivery_router.add_order(:customer => 2, :restaurant => 4)
        end

        it "sends rider 1 to customer 2 through restaurant 4" do
          route = @delivery_router.route(:rider => 1)
          expect(route.length).to eql(2)
          expect(route[0].id).to eql(4)
          expect(route[1].id).to eql(2)
        end

        it "sends rider 2 to customer 1 through restaurant 3" do
          route = @delivery_router.route(:rider => 2)
          expect(route.length).to eql(2)
          expect(route[0].id).to eql(3)
          expect(route[1].id).to eql(1)
        end

        it "delights customer 1" do
          expect(@delivery_router.delivery_time(:customer => 1)).to be < 60
        end

        it "delights customer 2" do
          expect(@delivery_router.delivery_time(:customer => 2)).to be < 60
        end
      end
     end
  end

  describe "#add_order" do
    let(:customers) { [Customer.new(id: 1, x: 11, y: 1)] }
    let(:restaurants) { [Restaurant.new(id: 4, cooking_time: 35, x: 5, y: 5)] }
    let(:riders) { [Rider.new(id: 1, speed: 10, x: 2, y: 0)] }
    let(:router) { DeliveryRouter.new(restaurants, customers, riders) }

    describe "when can't ship in less than 60 minutes" do
      it "returns [:error, delivery_time]" do
        res, reason = router.add_order(customer: 1, restaurant: 4)
        expect(reason).to be :delivery_too_long
        expect(res).to be :error
      end
    end

    describe "when restaurant does not exists" do
      it "returns [:error, nil]" do
        res, reason = router.add_order(customer: 1, restaurant: 1)
        expect(res).to be :error
        expect(reason).to be :restaurant_not_found
      end
    end

    describe "when restaurant does not exists" do
      it "returns [:error, nil]" do
        res, reason = router.add_order(customer: 2, restaurant: 4)
        expect(res).to be :error
        expect(reason).to be :customer_not_found
      end
    end
  end
end
