class Order < ApplicationRecord
  has_many :ordered_products
  has_many :products, :through => :ordered_products

  after_initialize do
    self.status = 'In progress' if self.status.nil?
  end

  after_initialize do
    self.total_price = 0 if self.total_price.nil?
  end

  validates :status, inclusion: { in: ["In progress", 'Done'] }
  validates :total_price, numericality: { only_integer: true,
                                          greater_than_or_equal_to: 0 }

  def update_price(price)
    self.update_columns(total_price:(self.total_price + price.to_i))
  end

  #since is fake its only change status
  def buy
    self.update_columns(status:'Done')
  end
end
