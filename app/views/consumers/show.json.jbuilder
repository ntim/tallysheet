if authenticated?
  json.extract! @consumer, :id, :name, :email, :created_at, :updated_at, :credit, :debt, :amount_of_beverages, :amount_of_paid_beverages, :tallysheet_entries
else
  json.extract! @consumer, :id, :name, :created_at, :updated_at, :credit, :debt, :amount_of_beverages, :amount_of_paid_beverages, :tallysheet_entries
end