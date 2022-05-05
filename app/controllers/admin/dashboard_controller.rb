class Admin::DashboardController < ApplicationController
  def show
    @products = Product.count
    @category = Category.count
  end
end
