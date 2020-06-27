class OrdersController < ApplicationController

  # triggered by button in view
  def create
    products = Product.generate_random
    warehouse = Product.set_warehouse(products)
    order = Order.new

    order.products = products
    order.warehouse = warehouse
    order.total_value = order.calc_total_value
    order.status = [Order::FULFILLED, Order::UNFULFILLED].sample
    order.save

    render json: { order: order, products: products }
  end

  # triggered by clear button in view
  def destroy_all
    Order.destroy_all
    ProductOrder.destroy_all
  end
end
