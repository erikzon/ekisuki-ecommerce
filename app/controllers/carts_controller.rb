class CartsController < ApplicationController
  skip_before_action :protect_pages

  def create
    if !Current.user
      redirect_to new_session_path, notice: "Porfavor inicia sesión para realizar ordenes."
      return
    end
    @cart = Cart.find_by(product_id: params[:product_id],order_id: nil, user_id: Current.user.id)
    if @cart
      @cart.update(quantity: params[:quantity])
      @cart.update(size: params[:size])
      redirect_to product_path(product), notice: "Carrito Actualizado."
    else
      Cart.create(product: product, user: Current.user, quantity: params[:quantity], size: params[:size])
      redirect_to product_path(product), notice: "Se agrego al carrito."
    end
  end

  def index
    if Current.user.present?
      @cart = Cart.all
      @product = Product.joins(:carts).where(carts: { user_id: Current.user.id, order_id: nil })
                        .select("products.*, carts.quantity as cart_quantity, carts.size as cart_size")
    else
      redirect_to new_session_path, notice: "Inicia sesion para ver tu carrito."
    end

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