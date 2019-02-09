module ApplicationHelper
  def current_order
    if user_signed_in?
      create_new_order if (!session[:order_id] || !check_order)
      return Order.find(session[:order_id])
    else
      redirect_to root_path
    end
  end

  def create_new_order
    session[:order_id] = current_user.orders.create.id
  end

  #to check if current order belongs to current user
  def check_order
     current_user == Order.find(session[:order_id]).user
  end

  def end_order
    session[:order_id].delete
  end
end
