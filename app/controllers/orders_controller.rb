class OrdersController < ApplicationController
  before_action :set_order, only: %i[ show edit update destroy ]
  skip_before_action :protect_pages, only: %i[ create new ]

  # GET /orders or /orders.json
  def index
    @orders = Order.all
  end

  # GET /orders/1 or /orders/1.json
  def show
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

    @order = Order.new(order_params.merge(user_id: Current.user.id, total: @total))

    respond_to do |format|
      if @order.save
        # traer la carreta del usuario actual con order_id null
        @cart = Cart.find_by(user_id: Current.user)
        @cart.update(order_id: @order.id)
        format.html { redirect_to order_url(@order), notice: "Order was successfully created." }
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
