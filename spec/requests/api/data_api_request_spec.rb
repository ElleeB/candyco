require 'rails_helper'

RSpec.describe "Api::DataApis", type: :request do

  let!(:yum_city) { create(:warehouse, name: "yum city") }
  let!(:nomnom_nation) { create(:warehouse, name: "nomnom nation") }
  let!(:deelish_destination) { create(:warehouse, name: "deelish destination") }
  let!(:sweet_station) { create(:warehouse, name: "sweet station") }

  describe "reported order data" do
    before do
      5.times { post order_generate_path }
      @total_orders = Order.all.size.to_s
      @total_products = ProductOrder.all.size.to_s
      @gross_sales = Order.sum(&:total_value).to_s
      @avg_prod_per = ProductOrder.average_products_ordered.to_s
      @avg_order_val = Order.average_value.round(2).to_s

      get api_report_data_path
    end

    it "calculates total orders" do
      expect(response.body).to include(@total_orders)
    end

    it "total product sold" do
      expect(response.body).to include(@total_products)
    end

    it "calculates gross sales" do
      expect(response.body).to include(@gross_sales)
    end

    it "calculates average products per order" do
      expect(response.body).to include(@avg_prod_per)
    end

    it "calculates average order value" do
      expect(response.body).to include(@avg_order_val)
    end
  end
end
