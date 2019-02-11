class ProductsController < ApplicationController
  before_action :find_product,            except:   [:index, :new, :create]
  before_action :authenticate_user!,      except:   [:index, :show]
  before_action :check_if_user_is_admin,  except:   [:index, :show]

  def index
    @products = Product.all
  end

  def show;end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)
    if @product.save
      redirect_to @product
    else
      render 'new'
    end
  end

  def edit;end

  def update
    if @product.update(product_params)
      redirect_to @product
    else
      render 'edit'
    end
  end

  def destroy
    @product.destroy
    redirect_to root_path
  end

  private
  def find_product
    @product = Product.friendly.find(params[:id])
  end

  def check_if_user_is_admin
    redirect_to root_path unless current_user.is_admin?
  end

  def product_params
    params.require(:product).permit(:name, :price, :description)
  end
end
