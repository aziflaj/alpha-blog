require 'test_helper'

class CreateArticlesTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create(username: "aziflaj",
                        email: "mail@email.me",
                        password: "password")
  end

  test "should create new article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_difference 'Article.count', 1 do
      post_via_redirect articles_path, article: {
        title: "To be or not to be...",
        description: "These words, written by Shakespeare and spoken by Hamlet..."
      }
    end
    assert_template "articles/show"
    assert_select "h2", text: "Title: To be or not to be..."
    assert_select "a[href=?]", user_path(@user), text: @user.username
  end

  test "should not create invalid article" do
    sign_in_as(@user, "password")
    get new_article_path
    assert_template "articles/new"
    assert_no_difference 'Article.count' do
      post_via_redirect articles_path, article: {
        title: " ",
        description: "Not valid"
      }
    end
    assert_template 'articles/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
  end
end
