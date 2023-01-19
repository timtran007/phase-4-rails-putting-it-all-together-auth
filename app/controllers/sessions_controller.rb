class SessionsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_unauthorized_user
    
    before_action :authorize
    skip_before_action :authorize, only: [:create]

    def create
        user = User.find_by!(username: params[:username])
        if user&.authenticate(params[:password])
            session[:user_id] = user.id
            render json: user
        else
            render json: {errors: ["Invalid username and/or password"]}, status: :unauthorized
        end
    end

    def destroy
        session.delete :user_id
        head :no_content
    end

    private

    def render_unauthorized_user
        render json: {errors: ["invalid username and/or password"]}, status: :unauthorized
    end

end
