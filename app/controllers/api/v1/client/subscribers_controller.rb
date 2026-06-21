# frozen_string_literal: true

class Api::V1::Client::SubscribersController < Api::V1::ClientController
  def create
    subscriber = Subscriber.new(subscriber_params)

    if subscriber.save
      render json: SubscriberBlueprint.render_as_hash(subscriber), status: :created
    else
      render json: { error: subscriber.errors.full_messages.join(', ') }, status: :unprocessable_entity
    end
  end

  def unsubscribe
    subscriber = Subscriber.find_by(unsubscribe_token: params[:token])

    if subscriber.nil?
      render json: { error: 'Invalid unsubscribe link' }, status: :not_found
      return
    end

    if subscriber.unsubscribed?
      render json: { message: 'Already unsubscribed' }
      return
    end

    subscriber.update(status: :unsubscribed)
    render json: { message: 'You have been successfully unsubscribed' }
  end

  private

  def subscriber_params
    params.require(:subscriber).permit(:email, :name)
  end
end
