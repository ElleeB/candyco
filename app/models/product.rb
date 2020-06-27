class Product < ApplicationRecord
  has_many :product_orders
  has_many :orders, through: :product_orders

  PRODUCT_PARAMS = [
    {name: "cookies", price: 19.99},
    {name: "candy bars", price: 15.99},
    {name: "brownies", price: 24.50},
    {name: "candies", price: 10.99},
    {name: "cupcakes", price: 12.50}
  ].freeze

  # button in view will trigger random products and the creation of an order
  def self.generate_random
    @current_products = []

    PRODUCT_PARAMS.each do |param_set|
      @current_products << self.create(name: param_set[:name], price: param_set[:price])
      @current_products << self.create(name: param_set[:name], price: param_set[:price])
    end
    @current_products.shuffle.sample(rand(1..4))
  end

  def self.set_warehouse(products)
    product_names = products.map{ |product| product.name.downcase }.uniq

    # ["candies", "cupcakes"]
    set_warehouse = "sweet station" if (product_names & Warehouse::PRODUCTS[:sweet_station]).any?
    # ["cookies"]
    set_warehouse = "yum city" if product_names == Warehouse::PRODUCTS[:yum_city]
    # ["candy bars", "brownies"]
    if product_names == ["candy bars"] || product_names.sort == Warehouse::PRODUCTS[:deelish_destination]
      set_warehouse = "deelish destination"
    end
    # ["brownies"]
    set_warehouse = "nomnom nation" if product_names == Warehouse::PRODUCTS[:nomnom_nation]
    # all products can be distributed from here
    set_warehouse = "sweet station" unless set_warehouse

    Warehouse.find_by_name(set_warehouse)
  end

end
