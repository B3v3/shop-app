class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_update :update_orders_price

  has_many :ordered_products, dependent: :destroy
  has_many :orders, through: :ordered_products

  validates :name, presence: true, uniqueness: { case_sensitive: false},
                   length: { minimum: 3,maximum: 64 }

  validates :price, presence: true, numericality: { only_integer: true,
                                                    greater_than_or_equal_to: 0 }

  validates :description, presence: true, length: { minimum: 2, maximum: 1000 }

  def update_orders_price
    self.orders.where(status: 'In progress').each do |order|
      order.set_price
    end
  end
end
