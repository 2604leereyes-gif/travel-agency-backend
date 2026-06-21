# frozen_string_literal: true

class Api::V1::Admin::UserController < Api::V1::AdminController

    def update
        if current_user.update(user_params)
            render json: {
                user: UserBlueprint.render_as_hash(current_user)
            }
        else
            render json: {
                errors: current_user.errors.full_messages
            }, status: :unprocessable_entity
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end
end