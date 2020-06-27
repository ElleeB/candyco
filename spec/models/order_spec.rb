require 'rails_helper'

RSpec.describe Order, type: :model do

  let!(:yum_city) { create(:warehouse, name: "yum city") }
  let!(:nomnom_nation) { create(:warehouse, name: "nomnom nation") }
  let!(:deelish_destination) { create(:warehouse, name: "deelish destination") }
  let!(:sweet_station) { create(:warehouse, name: "sweet station") }

  describe 'set_warehouse' do
    let(:yum_city_order) { build(:order) }
    let(:nomnom_nation_order) { build(:order) }
    let(:deelish_destination_order1) { build(:order) }
    let(:deelish_destination_order2) { build(:order) }
    let(:sweet_station_order1) { build(:order) }
    let(:sweet_station_order2) { build(:order) }

    context 'when order contains only cookies' do
      before do
        yum_city_order.products << create(:product, name: "cookies", price: 10.00)
      end

      it 'sets center to sun valley' do
        center = Product.set_warehouse(yum_city_order.products)
        expect(center).to eq(yum_city)
      end
    end

    context 'when order contains only brownies' do
      before do
        nomnom_nation_order.products << create(:product, name: "brownies", price: 5.00)
      end

      it 'sets center to green valley' do
        center = Product.set_warehouse(nomnom_nation_order.products)
        expect(center).to eq(nomnom_nation)
      end
    end

    context 'when order contains only candy bars' do
      before do
        deelish_destination_order1.products << create(:product, name: "candy bars", price: 15.00)
      end

      it 'sets center to deelish_destination' do
        center = Product.set_warehouse(deelish_destination_order1.products)
        expect(center).to eq(deelish_destination)
      end
    end

    context 'when order contains candy bars and brownies' do
      before do
        deelish_destination_order2.products << create(:product, name: "candy bars", price: 15.00)
        deelish_destination_order2.products << create(:product, name: "brownies", price: 5.00)
      end

      it 'sets center to deelish_destination' do
        center = Product.set_warehouse(deelish_destination_order2.products)
        expect(center).to eq(deelish_destination)
      end
    end

    context 'when order contains candies and/or cupcakes' do
      before do
        sweet_station_order1.products << create(:product, name: "cupcakes", price: 20.00)
      end

      it 'sets center to sweet_station' do
        center = Product.set_warehouse(sweet_station_order1.products)
        expect(center).to eq(sweet_station)
      end
    end

    context 'when order contains any other combination' do
      before do
        sweet_station_order2.products << create(:product, name: "brownies", price: 5.00)
        sweet_station_order2.products << create(:product, name: "cookies", price: 10.00)
      end

      it 'sets center to sweet_station' do
        center = Product.set_warehouse(sweet_station_order2.products)
        expect(center).to eq(sweet_station)
      end
    end
  end
end
