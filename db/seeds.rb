User.find_or_create_by!(email: 'dillanmedeiros@gmail.com') do |user|
  user.name = 'Dillan Medeiros'
  user.password = '1234'
  user.password_confirmation = '1234'
end