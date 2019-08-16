5.times do |t|
  User.create!(name: "User#{t+1}", description: "User#{t+1}のdescription", email: "User#{t+1}@test.com", password: "password")
end

user = User.find(1)

10.times do |t|
  user.todos.create!("#{t+1}Todoテスト投稿", description: "#{t+1}テストdescription", user_id: user.id)
end