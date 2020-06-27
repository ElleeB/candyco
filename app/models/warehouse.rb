class Warehouse < ApplicationRecord
  has_many :orders
  has_many :products, through: :orders

  PRODUCTS = {
    # fulfills cookies only
    yum_city: %w(cookies).sort,
    # fulfills candy bars and brownies
    deelish_destination: %w(candy\ bars brownies).sort,
    # fulfills brownies only
    nomnom_nation: %w(brownies).sort,
    # fulfills candies, cupcakes, and all previous products [utilize for previous products only if other warehouses unable to fulfill]
    sweet_station: %w(candies cupcakes).sort
  }.freeze
end
