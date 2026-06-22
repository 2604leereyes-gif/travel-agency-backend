
users = [
  { username: "admin", email: "admin@example.com", password: "password", password_confirmation: "password", role: "super_admin" }
]

users.each do |user_attrs|
  user = User.find_by(username: user_attrs[:username], email: user_attrs[:email])
  if user.blank?
    User.create!(user_attrs)
    p "User #{user_attrs[:username]} created successfully."
  else
    p "User #{user_attrs[:username]} already exists, skipping..."
  end
end

contact_attrs = {
  google_maps_url: 'https://www.google.com/maps/place/One+Mall+Valenzuela/@14.6882049,121.001016,16z/data=!4m6!3m5!1s0x3397b6a95bee90c5:0xb2c8aaa3b496dadc!8m2!3d14.6875303!4d121.0002891!16s%2Fg%2F11c575qcqg?entry=ttu&g_ep=EgoyMDI2MDYxNi4wIKXMDSoASAFQAw%3D%3D',

  phone_numbers: [{key: 'main', value: '09123456789'}],

  emails: [{key: '', value: '09123456789'}],

  business_hours: [{key: 'mon-fri', value: '9:00AM - 8:00PM'}],

  address: '1st Flr., One Mall Valenzuela'
}

contact = Contact.first
if contact.nil?
  Contact.create!(contact_attrs)
  p "Contact has been created successfully."
else
  p "Contacy has already exists, skipping..."
end