json.array!(@payments) do |payments|
  json.extract! payments, :id, :consumer, :amount
end
