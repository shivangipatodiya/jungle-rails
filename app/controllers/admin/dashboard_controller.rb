class Admin::DashboardController < ApplicationController
  def show
    @count = Product.count
    @types = Category.count
  end
end
