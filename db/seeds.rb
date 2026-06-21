
users = [
  { username: "admin", email: "admin@example.com", password: "password", password_confirmation: "password", role: "super_admin" }
]

users.each do |user_attrs|
  user = User.find_by(username: user_attrs[:username], email: user_attrs[:email])
  if user.nil?
    User.create!(user_attrs)
    p "User #{user_attrs[:username]} created successfully."
  else
    p "User #{user_attrs[:username]} already exists, skipping..."
  end
end
