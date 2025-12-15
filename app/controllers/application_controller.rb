class ApplicationController < ActionController::API
  include JsonWebToken

  before_action :authorize_request

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header

    decoded = jwt_decode(token)

    @current_user = User.find(decoded[:user_id]) if decoded
  rescue
    render json: { error: 'Não autorizado' }, status: :unauthorized
  end
end