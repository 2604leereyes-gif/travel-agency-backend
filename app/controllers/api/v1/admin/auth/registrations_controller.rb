#frozen_string_literal: true

class Api::V1::Admin::Auth::RegistrationsController < ApplicationController
    def create
        user = User.new(user_params)
        user.role = "admin"

        if user.save
            token = JwtService.encode(user_id: user.id)
            
            render json: {
            token: token,
            user: user_response(user)
            }, status: :created
        else
            render json: {
            error: {
                type: "REGISTRATION_FAILED",
                message: user.errors.full_messages
            }
            }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(
            :email,
            :password,
            :password_confirmation,
            :username
        )
    end

    def user_response(user)
        {
            id: user.id,
            email: user.email,
            name: user.username,
            role: user.role
        }
    end
end