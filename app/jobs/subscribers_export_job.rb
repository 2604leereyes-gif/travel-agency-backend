# frozen_string_literal: true

class SubscribersExportJob < ApplicationJob
  queue_as :default

  def perform(export_id, filename, base_url)
    subscribers = Subscriber.order(subscribed_at: :desc)

    headers = %w[id email name status subscribed_at created_at updated_at]
    rows = subscribers.map do |s|
      [
        s.id,
        s.email,
        s.name,
        s.status,
        s.unsubscribe_token,
        s.subscribed_at&.iso8601,
        s.created_at&.iso8601,
        s.updated_at&.iso8601
      ]
    end

    CsvExportService.export(
      headers: headers,
      rows: rows,
      filename: filename,
      export_id: export_id,
      base_url: base_url
    )
  end
end
