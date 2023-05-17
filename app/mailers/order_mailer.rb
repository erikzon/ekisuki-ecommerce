class OrderMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.order_mailer.confirmOrder.subject
  #
  def confirmOrder
    # OrderMailer.with(user: Current.user,order: @order.id, cart: Cart.where(user_id: Current.user.id)).confirmOrder.deliver_later
    @user = params[:user]
    @cart = params[:cart]
    @order = params[:order]
    @username = @user.username

    @product = Product.joins(:carts).where(carts: { user_id: @user.id, order_id: @order.id })
                      .select("products.*, carts.quantity as cart_quantity, carts.size as cart_size")

    mail to: @user.email
  end
end
