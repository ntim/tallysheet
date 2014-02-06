json.array!(@tallysheet_entries) do |tallysheet_entry|
  json.extract! tallysheet_entry, :id, :consumer_id, :beverage_id, :amount
  json.url tallysheet_entry_url(tallysheet_entry, format: :json)
end
