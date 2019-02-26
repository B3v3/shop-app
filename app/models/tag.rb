class Tag < ApplicationRecord
  validates :name, length: { minimum: 3, maximum: 19 }, presence: true,
                   uniqueness: { case_sensitive: false}
  has_many :products, dependent: :destroy
end
