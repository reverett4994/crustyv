json.extract! image, :id, :nsfw, :cat, :res, :created_at, :updated_at
json.url image_url(image, format: :json)