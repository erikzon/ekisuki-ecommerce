class CartsController < ApplicationController
  skip_before_action :protect_pages

  def create
    Cart.create(product: product, user: Current.user)
    redirect_to product_path(product)
  end

  def index
    @product = Product.joins(:carts).where(:carts => {:user_id => Current.user.id}).distinct
  end

  def destroy
    Cart.where(user: Current.user, product_id: product).destroy_all
    redirect_to carts_path
  end

  private

  def product
    @product ||= Product.find(params[:product_id])
  end
end