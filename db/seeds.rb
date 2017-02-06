# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).

# Creating websites
Website.skip_callback(:create, :after, :create_ranking)
websites = %w( github.com amazon.in gmail.com ).map do |url|
  Website.create!( url: url )
end
Website.set_callback(:create, :after, :create_ranking)

# Seeding random rankings for the created websites
( ( Date.current - 100 )..Date.yesterday ).each do |date|
  websites.each do |website|
    website.rankings.create!( alexa_global_rank: rand(1..500000), created_at: date.to_datetime )
  end
end

# Create User with Admin access
user = User.create!({email: "sudhanshusiwan@gmail.com", password: 'password', reset_password_token: nil, reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 3,
                current_sign_in_at: "2017-01-10 00:13:38", last_sign_in_at: "2017-01-09 22:23:24", current_sign_in_ip: "127.0.0.1", last_sign_in_ip: "127.0.0.1" })

# Add the websites for the first user.
websites.each do |website|
  UserWebsite.create!( website_id: website.id, user_id: user.id )
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')