module Api
  module V1
    class UsersController < ApplicationController
      
      
      before_action :authorize_request, except: [:create]
      
      def index
        users = User.all
        render json: users, status: :ok
      end

      
      def me
        render json: @current_user, status: :ok
      end

     
      def create
        user = User.new(user_params)
        if user.save
          render json: user, status: :created
        else
          render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
        end
      end

     
      def update_me
        if @current_user.update(user_params)
          render json: { message: 'Atualizado!', user: @current_user }, status: :ok
        else
          render json: { errors: @current_user.errors.full_messages }, status: :unprocessable_entity
        end
      end

      
      def destroy_me
        @current_user.destroy
        head :no_content
      end


      private

     
      def authorize_request
        header = request.headers['Authorization']
        token = header&.split(' ')&.last

        return render json: { error: 'Token ausente ou malformado' }, status: :unauthorized unless token

        begin
          decoded = jwt_decode(token)
          @current_user = User.find(decoded[:user_id])

        rescue JWT::DecodeError
          render json: { error: 'Token inválido ou expirado' }, status: :unauthorized

        rescue ActiveRecord::RecordNotFound
          render json: { error: 'Usuário do token não encontrado' }, status: :unauthorized

        rescue StandardError
          render json: { error: 'Erro de autorização desconhecido' }, status: :unauthorized
        end
      end

      
      def user_params
        params.permit(:name, :email, :password, :password_confirmation)
      end

    end
  end
end
