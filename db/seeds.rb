@user = User.new(
  email: 'admin@admin.com',
  password: '123456789',
  password_confirmation: '123456789',
  administrator: true,
  privilege: 1
)

@user.save!