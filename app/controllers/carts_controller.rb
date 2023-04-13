class CartsController < ApplicationController
  skip_before_action :protect_pages

  def create
    if !Current.user
      redirect_to new_session_path, notice: "Porfavor inicia sesion para realizar ordenes."
      return
    end
    @cart = Cart.find_by(product_id: params[:product_id])
    if @cart
      @cart.update(quantity: params[:quantity])
      redirect_to product_path(product), notice: "Cantidad Actualizada."
    else
      Cart.create(product: product, user: Current.user, quantity: params[:quantity])
      redirect_to product_path(product), notice: "Se agrego al carrito."
    end
  end

  def index
    @cart = Cart.all
    @product = Product.joins(:carts).where(:carts => { :user_id => Current.user.id }).select("products.*, carts.quantity as cart_quantity")
  end

  def edit
    product
  end

  def update
    @cart = Cart.find_by(product_id: params[:product_id])
    if @cart.update(quantity: params[:cart][:quantity])
      redirect_to carts_path, notice: "Cantidad actualizada."
    else
      redirect_to carts_path, status: :unprocessable_entity
    end
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