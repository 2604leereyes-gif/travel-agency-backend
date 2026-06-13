# frozen_string_literal: true

class Api::V1::Admin::TravelPackagesController < Api::V1::AdminController
  before_action :set_travel_package, only: [:show, :update, :destroy]

  def index
    travel_packages = TravelPackage.order(created_at: :desc)

    render json: TravelPackageBlueprint.render_as_hash(travel_packages)
  end

  def show
    render json: TravelPackageBlueprint.render_as_hash(@travel_package)
  end

  def create
    travel_package = TravelPackage.new(travel_package_params)

    if travel_package.save
      render json: TravelPackageBlueprint.render_as_hash(travel_package), status: :created
    else
      render json: { errors: travel_package.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    if @travel_package.update(travel_package_params)
      render json: TravelPackageBlueprint.render_as_hash(@travel_package)
    else
      render json: { errors: @travel_package.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    if @travel_package.destroy
      render json: { message: "Travel package deleted" }
    else
      render json: { errors: @travel_package.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_travel_package
    @travel_package = TravelPackage.find(params[:id])
  end

  def travel_package_params
    params.require(:travel_package).permit(
      :title,
      :description,
      :base_price,
      :show_price,
      :number_of_travelers,
      :destination,
      :is_active
    )
  end
end
