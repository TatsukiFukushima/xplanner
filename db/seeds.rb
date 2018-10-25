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

60.times do |n|
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

# 長期目標 > 中期目標 > 短期目標 > アプローチ
users = User.all 
users.each do |owner|
  5.times do 
    category = Faker::Lorem.word.capitalize
    content = Faker::Lorem.sentence(1)
    params = { long_term_goal: { category: category, content: content, deadline_attributes: { date: '2018-10-27' } } }
    owner.long_term_goals.create!(params[:long_term_goal])
  end 
  l_goals = owner.long_term_goals
  l_goals.each do |l_goal|
    content = Faker::Lorem.sentence(1)
    params = { mid_term_goal: { user_id: owner.id, content: content, deadline_attributes: { date: '2018-10-26' } } }
    l_goal.mid_term_goals.create!(params[:mid_term_goal])
  end 
  m_goals = owner.mid_term_goals
  m_goals.each do |m_goal|
    content = Faker::Lorem.sentence(1)
    params = { short_term_goal: { user_id: owner.id, content: content, deadline_attributes: { date: '2018-10-25' } } }
    m_goal.short_term_goals.create!(params[:short_term_goal])
  end 
  s_goals = owner.short_term_goals
  s_goals.each do |s_goal|
    content = Faker::Lorem.sentence(1)
    params = { approach: { user_id: owner.id, content: content, deadline_attributes: { date: '2018-10-24' } } }
    s_goal.approaches.create!(params[:approach])  
  end 
end 


# X Room
10.times do |i|
  user = User.find(i + 1)
  category = Faker::Lorem.word.capitalize
  description = Faker::Lorem.sentence(2)
  params = { xroom: { category: category, description: description } }
  user.xrooms.create!(params[:xroom])
end 

# Like
20.times do |i|
  user = User.find(i + 1)
  random_num_ary = (1..300).sort_by{rand}
  5.times do
    random_pop     = random_num_ary.pop
    params = { like: { likable_type: 'LongTermGoal', likable_id: random_pop, user_id: user.id } }
    Like.create!(params[:like])
  end
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    params = { like: { likable_type: 'MidTermGoal', likable_id: random_pop, user_id: user.id } }
    Like.create!(params[:like])
  end 
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    params = { like: { likable_type: 'ShortTermGoal', likable_id: random_pop, user_id: user.id } }
    Like.create!(params[:like])
  end 
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    params = { like: { likable_type: 'Approach', likable_id: random_pop, user_id: user.id } }
    Like.create!(params[:like])
  end 
end 

# Comment
20.times do |i|
  user = User.find(i + 1)
  random_num_ary = (1..300).sort_by{rand}
  5.times do
    random_pop     = random_num_ary.pop
    content = Faker::Lorem.sentence(1)
    params = { comment: { commentable_type: 'LongTermGoal', commentable_id: random_pop, content: content, user_id: user.id } }
    Comment.create!(params[:comment])
  end
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    content = Faker::Lorem.sentence(1)
    params = { comment: { commentable_type: 'MidTermGoal', commentable_id: random_pop, content: content, user_id: user.id } }
    Comment.create!(params[:comment])
  end 
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    content = Faker::Lorem.sentence(1)
    params = { comment: { commentable_type: 'ShortTermGoal', commentable_id: random_pop, content: content, user_id: user.id } }
    Comment.create!(params[:comment])
  end 
  random_num_ary = (1..300).sort_by{rand}
  5.times do 
    random_pop     = random_num_ary.pop
    content = Faker::Lorem.sentence(1)
    params = { comment: { commentable_type: 'Approach', commentable_id: random_pop, content: content, user_id: user.id } }
    Comment.create!(params[:comment])
  end 
end 

# # 長期目標
# 5.times do |i|
#   user = User.find(i + 1)
#   8.times do 
#     category = Faker::Lorem.word.capitalize
#     content = Faker::Lorem.sentence(1)
#     params = { long_term_goal: { category: category, content: content, deadline_attributes: { date: '2018-10-27' } } }
#     user.long_term_goals.create!(params[:long_term_goal])
#   end 
# end 

# # 中期目標
# 8.times do |i|
#   user = User.first
#   long_term_goal = user.long_term_goals[i]
#   5.times do 
#     content = Faker::Lorem.sentence(1)
#     params = { mid_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#     long_term_goal.mid_term_goals.create!(params[:mid_term_goal])
#   end 
# end 

# 8.times do |i|
#   user = User.find(2)
#   long_term_goal = user.long_term_goals[i]
#   5.times do 
#     content = Faker::Lorem.sentence(1)
#     params = { mid_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#     long_term_goal.mid_term_goals.create!(params[:mid_term_goal])
#   end 
# end 

# # 短期目標
# user = User.first 
# long_term_goals = user.long_term_goals
# long_term_goals.each do |l_goal|
#   mid_term_goals = l_goal.mid_term_goals
#   mid_term_goals.each do |m_goal|
#     5.times do 
#       content = Faker::Lorem.sentence(1)
#       params = { short_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#       m_goal.short_term_goals.create!(params[:short_term_goal])
#     end 
#   end 
# end 

# user = User.find(2)
# long_term_goals = user.long_term_goals
# long_term_goals.each do |l_goal|
#   mid_term_goals = l_goal.mid_term_goals
#   mid_term_goals.each do |m_goal|
#     5.times do 
#       content = Faker::Lorem.sentence(1)
#       params = { short_term_goal: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#       m_goal.short_term_goals.create!(params[:short_term_goal])
#     end 
#   end 
# end 


# # アプローチ
# user = User.first
# long_term_goals = user.long_term_goals 
# long_term_goals.each do |l_goal|
#   mid_term_goals = l_goal.mid_term_goals 
#   mid_term_goals.each do |m_goal|
#     short_term_goals = m_goal.short_term_goals
#     short_term_goals.each do |s_goal| 
#       5.times do 
#         content = Faker::Lorem.sentence(1)
#         params = { approach: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#         s_goal.approaches.create!(params[:approach])
#       end 
#     end 
#   end 
# end 

# user = User.find(2)
# long_term_goals = user.long_term_goals 
# long_term_goals.each do |l_goal|
#   mid_term_goals = l_goal.mid_term_goals 
#   mid_term_goals.each do |m_goal|
#     short_term_goals = m_goal.short_term_goals
#     short_term_goals.each do |s_goal| 
#       5.times do 
#         content = Faker::Lorem.sentence(1)
#         params = { approach: { user_id: user.id, content: content, deadline_attributes: { date: '2018-10-27' } } }
#         s_goal.approaches.create!(params[:approach])
#       end 
#     end 
#   end 
# end 