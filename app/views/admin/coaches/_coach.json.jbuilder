json.extract! coach, :id, :name, :email, :encrypted_password, :created_at, :updated_at
json.url coach_url(coach, format: :json)
