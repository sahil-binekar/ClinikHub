class ApplicationController < ActionController::API
  before_action :authenticate_user

  private

  def authenticate_user
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    # render json: { error: "Unauthorized" }, status: :unauthorized unless @current_user
    error_response({error_key: "Unauthorized"}, status: :unauthorized) unless @current_user
  end

  def error_response(error_response, status_code = 400)
    render json: {
      errors: [
        status: status_code,
        success: false,
        details: error_response
      ]
    }, status: status_code
  end

  def success_response(api_response, status_code = 200, message = '')
    render json: {
      success: true,
      data: api_response,
      status_code: status_code,
      message: message,
      meta: []
    }, status: (status_code == 204 ? 200 : status_code)
  end
end