require 'test_helper'

class UserTest < ActionDispatch::IntegrationTest
  fixtures :users

  def test_login
    visit "/"
    assert page.has_content? ("Sign In")



  end
end
