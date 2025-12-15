module Api
  module V1
    class AuthController < ApplicationController
    skip_before_action :authorize_request, only: [:login]

    
      def login
        user = User.find_by(email: params[:email])

        if user&.authenticate(params[:password])
          token = jwt_encode(user_id: user.id)
          render json: { token: token, user: user }
        else
          render json: { error: 'Acesso negado' }, status: :unauthorized
        end
      end
    end
  end
end