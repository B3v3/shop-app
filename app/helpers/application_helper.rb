module ApplicationHelper
  def current_order
    session[:order_id] = Order.create.id if !session[:order_id]
    return Order.find(session[:order_id])
  end

  def end_order
    session[:order_id].delete
  end
end
