class Api::V1::Admin::InquiriesController < Api::V1::AdminController
  before_action :require_super_admin!
  before_action :set_inquiry, only: [:show, :update, :destroy]

  def index
    inquiries = Inquiry.order(created_at: :desc)
                       .page(params[:page])
                       .per(10)

    render json: {
      inquiries: InquiryBlueprint.render_as_hash(inquiries),
      meta: {
        current_page: inquiries.current_page,
        total_pages: inquiries.total_pages,
        total_count: inquiries.total_count
      }
    }
  end

  def show
    render json: InquiryBlueprint.render_as_hash(@inquiry)
  end

  def update
    if @inquiry.update(inquiry_params)
      render json: InquiryBlueprint.render_as_hash(@inquiry)
    else
      render json: { errors: @inquiry.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def destroy
    @inquiry.soft_delete
    render json: { message: "Inquiry deleted" }
  end

  private

  def set_inquiry
    @inquiry = Inquiry.find(params[:id])
  end

  def inquiry_params
    params.require(:inquiry).permit(
      :email,
      :full_name,
      :phone_number,
      :destination,
      :departure_date,
      :return_date,
      :number_of_travelers,
      :estimated_budget,
      :notes,
      :status,
      :travel_package_id
    )
  end
end