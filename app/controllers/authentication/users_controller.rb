class Authentication::UsersController < ApplicationController
  skip_before_action :protect_pages

  def new
    @category = Category.all
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if verify_recaptcha(model: @user) && @user.save
      UserMailer.with(user: @user).welcome.deliver_later
      session[:user_id] = @user.id
      redirect_to products_path, notice: "Usuario creado, ya puedes empezar a comprar!"
    else
      render :new, status: :unprocessable_entity, alert: "Ocurrio un error, intenta de nuevo mas tarde."
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :username, :password, :password_confirmation)
  end
end