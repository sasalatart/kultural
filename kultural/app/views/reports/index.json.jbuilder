json.array!(@reports) do |report|
  json.extract! report, :id, :genuine, :user_id, :reportable_id, :reportable_type
  json.url report_url(report, format: :json)
end
