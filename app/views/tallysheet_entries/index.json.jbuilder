json.array!(@tallysheet_entries) do |tallysheet_entry|
  json.extract! tallysheet_entry, :id, :consumer_id, :beverage_id, :amount, :created_at
  json.url tallysheet_entry_url(tallysheet_entry, format: :json)
end
