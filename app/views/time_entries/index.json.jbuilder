json.array!(@time_entries) do |time_entry|
  json.extract! time_entry, :id, :timing, :run, :week_id, :racer_id
  json.url time_entry_url(time_entry, format: :json)
end
