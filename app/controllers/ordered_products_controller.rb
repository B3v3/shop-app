class OrderedProductsController < ApplicationController
  include ApplicationHelper

  def create
    ordered_product = current_order.ordered_products.build(ordered_products_params)
    if ordered_product.save
      redirect_to cart_path
    else
      flash[:danger] = "We've encountered some trouble with your action ):"
      redirect_to root_path
    end
  end

  def destroy
    OrderedProduct.find(params[:id]).destroy
    redirect_to cart_path
  end

  private
    def ordered_products_params
      params.permit(:product_id)
    end
end
