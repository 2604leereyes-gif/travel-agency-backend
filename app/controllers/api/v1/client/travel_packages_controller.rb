# frozen_string_literal: true

class Api::V1::TravelPackagesController < Api::V1::ClientController
  def index
    travel_packages = TravelPackage.order(created_at: :desc)
                                   .page(params[:page])
                                   .per(10)

    render json: {
      travel_packages: TravelPackageBlueprint.render_as_hash(travel_packages),
      meta: {
        current_page: travel_packages.current_page,
        total_pages: travel_packages.total_pages,
        total_count: travel_packages.total_count
      }
    }
  end

  def show
    travel_package = TravelPackage.find(params[:id])

    render json: TravelPackageBlueprint.render_as_hash(travel_package)
  end
end