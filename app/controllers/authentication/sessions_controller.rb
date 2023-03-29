class Authentication::SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to products_path, notice: "Bienvenid@ #{@user.username}"
    else
      redirect_to new_session_path, alert: "Datos incorrectos."
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to products_path, notice: "Sesion Finalizada."
    # session[:user_id] = nil
    # Current.user = nil
    # redirect_to products_path, notice: "Sesion Finalizada."
  end
end