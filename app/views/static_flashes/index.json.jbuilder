json.array!(@static_flashes) do |static_flash|
  json.extract! static_flash, :id, :expires, :content
  json.url static_flash_url(static_flash, format: :json)
end
