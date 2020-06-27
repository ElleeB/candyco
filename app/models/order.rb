class Order < ApplicationRecord
  belongs_to :warehouse
  has_many :product_orders
  has_many :products, through: :product_orders, dependent: :destroy

  # set randomly for mvp
  UNFULFILLED = 0
  FULFILLED = 1

  def calc_total_value
    products.sum(&:price)
  end

  def print_status
    status == UNFULFILLED ? "unfulfilled" : "fulfilled"
  end

  def self.with_products
    @orders_products = []

    Order.all.each do |order|
      @orders_products << {order: order, products: order.products}
    end
    @orders_products
  end

  def self.average_value
    self.count > 0 ? (self.sum(&:total_value)/self.count).round(2) : 0
  end
end
