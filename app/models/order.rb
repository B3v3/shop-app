class Order < ApplicationRecord
  has_many :ordered_products, dependent: :destroy
  has_many :products, :through => :ordered_products

  belongs_to :user

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

  #after editing product
  def set_price
    self.update_columns(total_price:(
         self.products.sum { |product, t_price = 0| t_price += product.price}))
  end

  #since is fake its only change status
  def buy
    self.update_columns(status:'Done')
  end
end
