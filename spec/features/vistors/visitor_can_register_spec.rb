require 'rails_helper'

describe 'vister can create an account', :js do
  it ' visits the home page' do
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'


    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(current_path).to eq(dashboard_path)

    expect(page).to have_content("Logged in as: #{first_name} #{last_name}")
    expect(page).to have_content("This account has not yet been activated. Please check your email.")

    user = User.last
    user.update!(email_confirmed: "inactive", confirm_token: 123456)

    visit confirm_email_user_path(user.id, params: { token: user.confirm_token })

    expect(current_path).to eq(dashboard_path)

    visit dashboard_path
    expect(page).to have_content("Thank you! Your account is now activated.")
  end

  it 'cannot create non-unique email' do
    create(:user, email: 'jimbob@aol.com')
    email = 'jimbob@aol.com'
    first_name = 'Jim'
    last_name = 'Bob'
    password = 'password'
    password_confirmation = 'password'


    visit '/'

    click_on 'Sign In'

    expect(current_path).to eq(login_path)

    click_on 'Sign up now.'

    expect(current_path).to eq(new_user_path)

    fill_in 'user[email]', with: email
    fill_in 'user[first_name]', with: first_name
    fill_in 'user[last_name]', with: last_name
    fill_in 'user[password]', with: password
    fill_in 'user[password_confirmation]', with: password

    click_on'Create Account'

    expect(page).to have_content("Email already exists")

  end 
end
