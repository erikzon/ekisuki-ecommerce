class OrdersController < ApplicationController
  before_action :set_order, only: %i[ destroy ]
  skip_before_action :protect_pages, only: %i[ create new update ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end
  def show
    @order = Order.find(params[:id])
    @product = Product.joins(:carts).where(carts: { user_id: @order.user_id, order_id: @order.id })
                      .select("products.*, carts.quantity as cart_quantity, carts.size as cart_size")
  end

  def update
    @order = Order.find_by(token: params[:token])
    encontrado = @order.present?
    previamenteConfirmada = @order&.confirmed
    if @order&.update(confirmed: true) and encontrado
      # Acción exitosa
      if not previamenteConfirmada
        OrderMailer.notifyUs.deliver_later
      end
      @mensaje = "Gracias por confirmar, tu orden sera despachada en breve!"
    else
      # Error en la actualización
      @mensaje = "El token no es valido! Porfavor revisa tu url."
    end
  end

  # GET /orders/new
  def new
    @order = Order.new

    @last_order = Order.where(user_id: Current.user.id).last

    if @last_order
      @last_order_name = @last_order.name
      @last_order_phone_number = @last_order.phone_number
      @last_order_email = @last_order.email
      @last_order_shipping_address = @last_order.shipping_address
      @last_order_note = @last_order.note
    end
  end

  # POST /orders or /orders.json
  def create
    @product = Product.joins(:carts).where(carts: { user_id: Current.user.id, order_id: nil }).select("products.*, carts.quantity as cart_quantity")
    @total = @product.map { |p| p.price * p.cart_quantity }.sum
    require 'securerandom'

    @order = Order.new(order_params.merge(user_id: Current.user.id, total: @total, token: SecureRandom.urlsafe_base64(32,padding: false)))

    respond_to do |format|
      if @order.save
        # traer la carreta del usuario actual con order_id null
        @carts = Cart.where(user_id: Current.user, order_id: nil )
        @carts.each do |cart|
          cart.update(order_id: @order.id)
        end
        OrderMailer.with(user: Current.user, order: @order, cart: @carts.to_a).confirmOrder.deliver_later
        format.html { redirect_to order_url(@order), notice: "Gracias! por favor revisa tu correo." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :phone_number, :email, :shipping_address, :note)
  end

end
