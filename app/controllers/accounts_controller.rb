class AccountsController < ApplicationController
  skip_before_action :authenticate_user

  # POST /accounts/signup
  def signup
    if params[:user]
      user = User.new(user_params)
      if user.save
        success_response({}, 201, 'Registered Successfully')
      else
        error_response(user.errors.as_json, 422)
      end
    else
      error_response({ error_key: 'Requested data is not properly formatted.'}, 400)
    end
  end

  #POST /accounts/login
  def login
    user = User.find_by(email: params[:email])
    # binding.pry
    if user&.authenticate(params[:password])
      token = JsonWebToken.encode(user_id: user.id, role: user.role)
      render json: { token: token, user: user.as_json(only: [:first_name, :last_name, :role]) }, status: :ok
    else
      render json: { error: "Invalid email or password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :role, :first_name, :last_name, :phone)
  end
end
