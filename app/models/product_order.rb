class ProductOrder < ApplicationRecord
  belongs_to :product
  belongs_to :order

  def self.average_products_ordered
    product_counts = group(:order_id).count(:product_id).map { |order_id, prod_id| prod_id }
    product_counts.present? ? product_counts.sum/product_counts.length : 0
  end
end
