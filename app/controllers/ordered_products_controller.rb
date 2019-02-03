class OrderedProductsController < ApplicationController

  def create
    ordered_product = helpers.current_order.ordered_products.build(ordered_products_params)
    if ordered_product.save
      redirect_to cart_path
    else
      redirect_to root_path
    end
  end

  private
    def ordered_products_params
      params.permit(:product_id)
    end
end
