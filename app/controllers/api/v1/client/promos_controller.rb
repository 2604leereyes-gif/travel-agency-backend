# frozen_string_literal: true

class Api::V1::Client::PromosController < Api::V1::ClientController
  def index
    promos = Promo.where(active: true)
                  .order(created_at: :desc)
                  .page(params[:page])
                  .per(10)

    render json: {
      promos: PromoBlueprint.render_as_hash(promos),
      meta: {
        current_page: promos.current_page,
        total_pages: promos.total_pages,
        total_count: promos.total_count
      }
    }
  end

  def show
    promo = Promo.find(params[:id])

    if promo.active?
      render json: PromoBlueprint.render_as_hash(promo)
    else
      render json: { error: "Promo not found" }, status: :not_found
    end
  end
end
