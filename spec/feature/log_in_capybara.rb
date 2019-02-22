def log_in_capybara(user)
  visit '/users/sign_in'
  within("#new_user") do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
  end
  click_button 'Log in'
end
