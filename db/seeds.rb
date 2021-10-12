puts "🌱 Seeding spices..."

# Seed your database here
User.create(username: "Test", useremail: "test@gmail.com", userpwd: "test", login_status: true, account_active: true, join_date: DateTime.now)

puts "✅ Done seeding!"
