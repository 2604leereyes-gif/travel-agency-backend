users = [
  { username: "admin", email: "admin@example.com", encrypted_password: "password" }
]

users.each do |user_attrs|
  User.find_or_create_by!(user_attrs)
end