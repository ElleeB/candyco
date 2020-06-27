class Api::DataApiController < ApplicationController

  def report_data
    render json: {
      warehouses: Warehouse.all.order(:id),
      orders: Order.with_products,
      product_orders: ProductOrder.all,
      order_total: Order.all.size,
      ttl_sold_prod: ProductOrder.all.size,
      gross_sales: Order.sum(&:total_value).round(2),
      avg_prod_per: ProductOrder.average_products_ordered,
      avg_order_val: Order.average_value.round(2)
     }
  end
end
