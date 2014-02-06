json.array!(@consumers) do |consumer|
  json.extract! consumer, :id, :name, :email, :credit, :debt, :amount_of_beverages, :amount_of_payed_beverages
  json.url consumer_url(consumer, format: :json)
end
