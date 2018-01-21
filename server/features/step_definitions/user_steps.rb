Given /^a valid user$/ do
  @user = User.create!(first_name: 'John',
             last_name: 'Doe',
             email: 'john@uni-tuebingen.de',
             password: 'geheim123'
)
end