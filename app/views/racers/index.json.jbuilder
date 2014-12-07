json.array!(@racers) do |racer|
  json.extract! racer, :id, :name, :gender, :team_id, :discipline_id, :classification_id
  json.url racer_url(racer, format: :json)
end
