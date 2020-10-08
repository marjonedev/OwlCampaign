json.extract! campaign, :id, :emaillist_id, :template_id, :from, :subject, :content, :date_send, :time_send, :created_at, :updated_at
json.url campaign_url(campaign, format: :json)
