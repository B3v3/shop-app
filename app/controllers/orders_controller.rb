class OrdersController < ApplicationController
  def cart
    @ordered_products = helpers.current_order.ordered_products
  end

  def clear_cart
    helpers.current_order.ordered_products.destroy_all
    redirect_to cart_path
  end

end
