class OrdersController < ApplicationController
  include ApplicationHelper
  before_action :authenticate_user!
  before_action :unless_cart_is_empty,  only: :buy


  def cart
    @ordered_products = current_order.ordered_products
  end

  def history
    @orders = current_user.orders.where(status: 'Done')
  end

  def buy
    current_order.buy
    create_new_order
    redirect_to root_path
  end

  def clear_cart
    current_order.ordered_products.destroy_all
    redirect_to cart_path
  end

  private
    def unless_cart_is_empty
      unless current_order.ordered_products.any?
        redirect_to root_path
      end
    end
end
