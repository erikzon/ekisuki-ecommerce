class AdminController < ApplicationController
  def index
    @categories = Category.all
    @product = Product.new
  end
end
