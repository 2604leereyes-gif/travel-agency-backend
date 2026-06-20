# frozen_string_literal: true

require 'csv'
require 'fileutils'


class CsvExportService

  # Generate a CSV file from headers and rows with WebSocket progress updates
  # @param headers [Array<String>] CSV column headers
  # @param rows [Array<Array>] Array of rows, each row is an array of values
  # @param filename [String] Optional custom filename (without extension)
  # @param export_id [String] Unique export ID for WebSocket channel subscription
  # @param base_url [String] Base URL for file_url generation
  # @return [Hash] { file_path: String, file_url: String, export_id: String, status: String }
  def self.export(headers:, rows:, filename: nil, export_id: nil, base_url: nil)
    new.export(headers: headers, rows: rows, filename: filename, export_id: export_id, base_url: base_url)
  end

  def export(headers:, rows:, filename: nil, export_id: nil, base_url: nil)
    filename ||= "export_#{Time.current.to_i}"
    export_id ||= SecureRandom.hex(8)
    dir = Rails.root.join('public', 'uploads', 'exports')
    FileUtils.mkdir_p(dir)

    csv_filename = "#{filename}.csv"
    file_path = dir.join(csv_filename)

    # Broadcast export started
    broadcast_export_status(export_id, 'started', { filename: csv_filename, total_rows: rows.length })

    # Write CSV file with progress updates
    CSV.open(file_path, 'w') do |csv|
      csv << headers
      broadcast_export_status(export_id, 'headers_written', { rows_written: 0 })

      rows.each_with_index do |row, index|
        csv << row
        # Broadcast progress every 100 rows to avoid too many messages
        if (index + 1) % 100 == 0
          broadcast_export_status(export_id, 'progress', { rows_written: index + 1, total_rows: rows.length })
        end
      end
    end

    # Build file URL
    base_url ||= 'http://localhost:3000'
    file_url = "#{base_url}/uploads/exports/#{csv_filename}"

    # Broadcast export completed
    status = broadcast_export_status(export_id, 'completed', { file_url: file_url, file_path: file_path.to_s }

    {
      file_path: file_path.to_s,
      file_url: file_url,
      export_id: export_id,
      status: 'completed'
    }
  rescue => e
    broadcast_export_status(export_id, 'failed', { error: e.message })
    raise "CSV export failed: #{e.message}"
  end

  private

  def broadcast_export_status(export_id, status, payload = {})
    ActionCable.server.broadcast("export_#{export_id}", {
      status: status,
      timestamp: Time.current.iso8601,
      **payload
    })
  end
end
