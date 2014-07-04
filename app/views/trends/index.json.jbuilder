json.array!(@trends) do |trend|
  json.extract! trend, :id, :trend, :woeid
  json.url trend_url(trend, format: :json)
end
