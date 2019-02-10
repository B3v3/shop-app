class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders
  has_one :admin

  def is_admin?
    !self.admin.nil?
  end

  def set_admin
    Admin.create(user_id: self.id) unless self.is_admin?
  end
end
