class TagsController < ApplicationController
  before_action :authenticate_user!,      except:   [:show]
  before_action :check_if_user_is_admin,  except:   [:show]

  def index
    @tags = Tag.all
    @new_tag = Tag.new
  end

  def show
     @tag = Tag.friendly.find(params[:id])
     @products = @tag.products
  end

  def create
    @tag = Tag.new(tag_params)
    if @tag.save
      redirect_to @tag
    else
      redirect_to tags_path
    end
  end

  private
  def tag_params
    params.require(:tag).permit(:name)
  end
end
