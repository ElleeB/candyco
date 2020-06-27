class ReportsController < ApplicationController

  # acts as home page for app at its current mvp state
  def index
    @warehouses = Warehouse.all
  end
end
