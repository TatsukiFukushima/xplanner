# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

User.create!(name: "chandler",
            email: "chanchan@icloud.com",
            password: "chanchan",
            password_confirmation: "chanchan",
            admin: true,
            activated: true,
            activated_at: Time.zone.now)

User.create!(name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true,
             activated: true,
             activated_at: Time.zone.now)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               activated: true,
               activated_at: Time.zone.now)
end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }


# 長期目標
5.times do |i|
  user = User.find(i + 1)
  8.times do 
    category = Faker::Lorem.word.capitalize
    content = Faker::Lorem.sentence(1)
    params = { long_term_goal: { category: category, content: content, deadline_attributes: { date: '2018-10-27' } } }
    user.long_term_goals.create!(params[:long_term_goal])
  end 
end 

# 中期目標
8.times do |i|
  user = User.first
  long_term_goal = user.long_term_goals[i]
  5.times do 
    content = Faker::Lorem.sentence(1)
    params = { mid_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
    long_term_goal.mid_term_goals.create!(params[:mid_term_goal])
  end 
end 

8.times do |i|
  user = User.find(2)
  long_term_goal = user.long_term_goals[i]
  5.times do 
    content = Faker::Lorem.sentence(1)
    params = { mid_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
    long_term_goal.mid_term_goals.create!(params[:mid_term_goal])
  end 
end 

# 短期目標
user = User.first 
long_term_goals = user.long_term_goals
long_term_goals.each do |l_goal|
  mid_term_goals = l_goal.mid_term_goals
  mid_term_goals.each do |m_goal|
    5.times do 
      content = Faker::Lorem.sentence(1)
      params = { short_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
      m_goal.short_term_goals.create!(params[:short_term_goal])
    end 
  end 
end 

user = User.find(2)
long_term_goals = user.long_term_goals
long_term_goals.each do |l_goal|
  mid_term_goals = l_goal.mid_term_goals
  mid_term_goals.each do |m_goal|
    5.times do 
      content = Faker::Lorem.sentence(1)
      params = { short_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
      m_goal.short_term_goals.create!(params[:short_term_goal])
    end 
  end 
end 


# アプローチ
user = User.first
long_term_goals = user.long_term_goals 
long_term_goals.each do |l_goal|
  mid_term_goals = l_goal.mid_term_goals 
  mid_term_goals.each do |m_goal|
    short_term_goals = m_goal.short_term_goals
    short_term_goals.each do |s_goal| 
      5.times do 
        content = Faker::Lorem.sentence(1)
        params = { approach: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
        s_goal.approaches.create!(params[:approach])
      end 
    end 
  end 
end 

user = User.find(2)
long_term_goals = user.long_term_goals 
long_term_goals.each do |l_goal|
  mid_term_goals = l_goal.mid_term_goals 
  mid_term_goals.each do |m_goal|
    short_term_goals = m_goal.short_term_goals
    short_term_goals.each do |s_goal| 
      5.times do 
        content = Faker::Lorem.sentence(1)
        params = { approach: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
        s_goal.approaches.create!(params[:approach])
      end 
    end 
  end 
end 