class OrderedProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  after_create do
    self.order.update_price(self.product.price)
  end

  before_destroy do
    self.order.update_price(-self.product.price)
  end
end
