json.items(@customers) do |customer|
  json.id customer.id
  json.text customer.fullname
end