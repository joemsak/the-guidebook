ActiveRecord::Base.transaction do
  %w[admin coach client].each do |type|
    user = User.find_or_initialize_by({
      name: "Test #{type.capitalize}",
      email: "#{type}1@example.com"
    })

    user.update({
      password: user.email,
      password_confirmation: user.email
    })

    user.create_profile(type)

    puts "---"
    puts "#{type.capitalize} #{user.email} ready!"
  end
end
