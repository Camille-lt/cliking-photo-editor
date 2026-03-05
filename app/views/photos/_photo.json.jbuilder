json.extract! photo, :id, :title, :description, :brightness, :contrast, :saturation, :created_at, :updated_at
json.url photo_url(photo, format: :json)
