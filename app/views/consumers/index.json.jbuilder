json.array!(@consumers) do |consumer|
  if authenticated?
    json.extract! consumer, :id, :name, :email, :credit, :debt, :amount_of_beverages, :amount_of_paid_beverages
  else
    json.extract! consumer, :id, :name, :credit, :debt, :amount_of_beverages, :amount_of_paid_beverages
  end
  json.url consumer_url(consumer, format: :json)
end
