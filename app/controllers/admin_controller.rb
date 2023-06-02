class AdminController < ApplicationController
  def index
    @categories = Category.all
    @product = Product.new
    @tags = Tag.all
    @orders = Order.order(updated_at: :desc)
  end
end
