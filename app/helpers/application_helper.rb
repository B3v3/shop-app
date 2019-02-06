module ApplicationHelper
  def current_order
    create_new_order if !session[:order_id]
    return Order.find(session[:order_id])
  end

  def create_new_order
    session[:order_id] = Order.create.id
  end

  def end_order
    session[:order_id].delete
  end
end
