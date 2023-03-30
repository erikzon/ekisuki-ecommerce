class AdminController < ApplicationController
  def index
    @categories = Category.all
    @product = Product.new
    @tags = Tag.all
  end
end
