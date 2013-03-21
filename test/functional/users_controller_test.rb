require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {username: 'username', email: 'user@email.com', password: 'password', password_confirmation: 'password'}
    end
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    post :create, user: {username: 'username', email: 'user@email.com', password: 'password', password_confirmation: 'password'}
    get :edit, id: User.find_by_username('username').id
    assert_response :success
  end

  test "should update user" do
    post :create, user: {username: 'username', email: 'user@email.com', password: 'password', password_confirmation: 'password'}

    put :update, id: User.find_by_username('username').id , user: {username: 'changed', email: 'changed@gmail.com', password: 'password', password_confirmation: 'password' }
    assert_redirected_to User.find_by_username('username')
  end

  test "should destroy user" do
    post :create, user: {username: 'username', email: 'user@email.com', password: 'password', password_confirmation: 'password'}

    assert_difference('User.count', -1) do
      delete :destroy, id: User.find_by_username('username').id
    end
  end
end
