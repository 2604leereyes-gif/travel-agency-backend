# frozen_string_literal: true

class ExportChannel < ApplicationCable::Channel
  def subscribed
    export_id = params[:export_id]

    if export_id.present?
      stream_from "export_#{export_id}"
    else
      reject
    end
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end
end