# frozen_string_literal: true

class Api::V1::Client::TravelPackagesController < Api::V1::ClientController
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

  def inquire
    travel_package = TravelPackage.find(params[:id])
    inquiry = travel_package.inquiries.new(inquiry_params)

    if inquiry.save
      render json: InquiryBlueprint.render_as_hash(inquiry), status: :created
    else
      render json: { error: inquiry.errors.full_messages.join(", ") }, status: :unprocessable_entity
    end
  end

  def inquiry_params
    params.require(:inquiry).permit(
      :email,
      :full_name,
      :phone_number,
      :number_of_travelers,
      :notes
    )
  end
end