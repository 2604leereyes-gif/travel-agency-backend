# frozen_string_literal: true

class Api::V1::Admin::PromosController < Api::V1::AdminController
  before_action :set_promo, only: [:update, :destroy]

  PER_PAGE = 10

  def index
    promos = Promo.order(created_at: :desc).page(params[:page]).per(PER_PAGE)
    render json: {
      promos: PromoBlueprint.render_as_hash(promos),
      meta: {
        current_page: promos.current_page,
        next_page: promos.next_page,
        prev_page: promos.prev_page,
        total_pages: promos.total_pages,
        total_count: promos.total_count
      }
    }
  end

  def create
    promo = Promo.new(promo_params)

    if promo.save
      render json: PromoBlueprint.render_as_hash(promo), status: :created
    else
      render json: { error: promo.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def update
    if @promo.update(promo_params)
      render json: PromoBlueprint.render_as_hash(@promo)
    else
      render json: { error: @promo.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def destroy
    if @promo.destroy
      render json: { message: "Promo deleted" }
    else
      render json: { error: @promo.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  private

  def set_promo
    @promo = Promo.find(params[:id])
  end

  def promo_params
    params.require(:promo).permit(:title, :details, :active)
  end
end
