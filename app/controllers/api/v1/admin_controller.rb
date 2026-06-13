class AdminController < ApplicationController
    before_action :set_current_user

    private

    def set_current_user
        auth_header = request.headers["Authorization"]
        token = auth_header.split(" ").last if auth_header

        if token
            begin
                decoded_token = JwtService.decode(token)
                @current_user = User.find(decoded_token[:user_id])
            rescue JWT::DecodeError, ActiveRecord::RecordNotFound
                @current_user = nil
            end
        end
    end

    def authenticate_user!
        return if current_user

        render json: { error: "Unauthorized" }, status: :unauthorized
    end

    def require_super_admin!
        render json: { error: "Forbidden" }, status: :forbidden unless @current_user.super_admin?
    end
end