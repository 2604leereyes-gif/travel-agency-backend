# frozen_string_literal: true

class Api::V1::Admin::Auth::SessionsController < ApplicationController
    def create
        user = User.find_by(email: params[:email])

        unless user&.authenticate(params[:password])
            return render json: { error: "Invalid credentials" }, status: :unauthorized
        end

        token = JwtService.encode(user_id: user.id)

        render json: {
            token: token,
            user: UserBlueprint.render_as_hash(user)
        }, status: :ok
    end
end