class Authentication::SessionsController < ApplicationController
  skip_before_action :protect_pages

  def new
    if Current.user.present?
      destroy
    end
    @category = Category.all
  end

  def create
    @user = User.find_by("email = :login OR username = :login", { login: params[:login] })

    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      if @user.admin?
        redirect_to admin_index_path, notice: "Bienvenido admin c:<"
      else
        redirect_to products_path, notice: "Bienvenid@ #{@user.username}"
      end

    else
      redirect_to new_session_path, alert: "Datos incorrectos."
    end
  end

  def destroy
    session[:user_id] = nil
    reset_session
    redirect_to categories_path, notice: "Sesion Finalizada."
  end
end