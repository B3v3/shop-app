class OrdersController < ApplicationController
  include ApplicationHelper

  def cart
    @ordered_products = current_order.ordered_products
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
end
