json.array!(@interruptions) do |interruption|
  json.extract! interruption, :id, :type, :recovered, :aktion_id, :details
  json.url interruption_url(interruption, format: :json)
end
