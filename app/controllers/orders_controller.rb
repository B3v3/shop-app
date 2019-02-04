class OrdersController < ApplicationController
  include ApplicationHelper
  
  def cart
    @ordered_products = current_order.ordered_products
  end

  def clear_cart
    current_order.ordered_products.destroy_all
    redirect_to cart_path
  end

end
