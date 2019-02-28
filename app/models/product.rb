class Product < ApplicationRecord
  extend FriendlyId
  friendly_id :name, use: :slugged

  after_update :update_orders_price
  before_validation :check_if_tag_is_present

  has_many :ordered_products, dependent: :destroy
  has_many :orders, through: :ordered_products

  belongs_to :tag

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

  def check_if_tag_is_present
    if self.tag_id.nil?
      if Tag.where(name: 'Other').exists?
        self.tag_id = Tag.find_by(name: 'Other').id
      else
        self.tag_id = Tag.create(name: 'Other').id
      end
    end
  end
end
