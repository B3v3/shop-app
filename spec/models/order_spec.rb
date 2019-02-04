require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:order) { build(:order) }

  describe 'validations' do
    it "should accept a valid order" do
      expect(order).to be_valid
    end

    describe 'total price' do
      it "should be present" do
        order.total_price = nil
        expect(order).to be_invalid
      end

      it "should be a integer" do
        order.total_price = 'hello'
        expect(order).to be_invalid
      end

      it "should be greater or equal than 0" do
        order.total_price = -1
        expect(order).to be_invalid

        order.total_price = 0
        expect(order).to be_valid

        order.total_price = 1
        expect(order).to be_valid
      end
    end

    describe 'status' do
      it 'should be present' do
        order.status = ''
        expect(order).to be_invalid
      end

      it "should be In progress or Done" do
        order.status = 'i dont know'
        expect(order).to be_invalid

        order.status = 'In progress'
        expect(order).to be_valid

        order.status = 'Done'
        expect(order).to be_valid
      end
    end
  end

  describe 'Callbacks' do
    it "should set status if non" do
      expect(Order.new.status).to eql("In progress")
    end

    it 'should set price if non' do
      expect(Order.new.total_price).to eql(0)
    end
  end

  describe 'update_price' do
    it "update price when given a number price" do
      order.save
      expect { order.update_price(50)}.to change(order, :total_price).by(50)
    end

    it "does nothing when given price isnt number" do
      order.save
      expect { order.update_price("a")}.not_to change(order, :total_price)
    end
  end
end
