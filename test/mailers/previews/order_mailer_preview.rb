# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/confirmOrder
  def confirmOrder
    OrderMailer.with(user: User.find(1), order: Order.find(2) ,cart: Cart.where(user_id: 1)).confirmOrder
  end

end
