json.array!(@beverages) do |beverage|
  json.extract! beverage, :id, :name, :price
  json.url beverage_url(beverage, format: :json)
end
