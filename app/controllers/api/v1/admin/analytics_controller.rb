# frozen_string_literal: true

class Api::V1::Admin::AnalyticsController < Api::V1::AdminController

    def index
        start_date = 6.days.ago.to_date

        raw_counts = Inquiry
        .where(created_at: start_date.beginning_of_day..Time.current)
        .group("DATE(created_at)")
        .count

        inquiry_week_report = (start_date..Date.current).map do |date|
            {
                day: date.strftime("%a"),
                count: raw_counts[date] || 0
            }
        end

        total_subscribers = Subscriber.count

        latest_inquiries = Inquiry.last(4)

        active_packages = TravelPackage.active.count

        inquiry_count = Inquiry.count

        conversion_rate = (Inquiry.confirmed.count.to_f/inquiry_count) * 100 if inquiry_count > 0

        render(json: {
            
                inquiry_week_report: inquiry_week_report,
                total_subscribers: total_subscribers,
                latest_inquiries: latest_inquiries,
                active_packages: active_packages,
                inquiry_count: inquiry_count,
                conversion_rate: conversion_rate || 0
            
        })
    end
end
