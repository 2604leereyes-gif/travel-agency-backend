# frozen_string_literal: true

class Api::V1::Admin::SubscribersController < Api::V1::AdminController
    before_action :require_super_admin!

    def index
        subscribers = Subscriber.active
                                .order(subscribed_at: :desc)
                                .page(params[:page])
                                .per(10)

        render json: {
        subscribers: SubscriberBlueprint.render_as_hash(subscribers),
        meta: {
            current_page: subscribers.current_page,
            next_page: subscribers.next_page,
            prev_page: subscribers.prev_page,
            total_pages: subscribers.total_pages,
            total_count: subscribers.total_count
        }
        }
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

    def destroy
        subscriber = Subscriber.find(params[:id])

        if subscriber.destroy
        render json: { message: 'Subscriber deleted' }
        else
        render json: { error: subscriber.errors.full_messages.join(', ') }, status: :unprocessable_entity
        end
    end
end