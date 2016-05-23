require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  def setup
    @aziflaj = {
      username: "aziflaj",
      email: "aldoziflaj@email.com",
      password: "password"
    }

    @invalid = {
      username: "aziflaj",
      email: "invalid@email",
      password: " "
    }
  end

  test "should create new user and login them on signup" do
    get signup_path
    assert_template "users/new"
    assert_difference 'User.count', 1 do
      post_via_redirect users_path, user: @aziflaj
    end
    assert_template "users/show"

    # assert the user is listed on the users list
    get users_path
    assert_select "a[href=?]", user_path(current_user), text: current_user.username
  end

  test "should not signup invalid user" do
    get signup_path
    assert_template "users/new"
    assert_no_difference 'User.count' do
      post_via_redirect users_path, user: @invalid
    end
    assert_template "users/new"
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
