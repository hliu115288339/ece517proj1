require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do

    @category = categories(:one)
    @user = users(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, category: { name: 'categoryName' }
    end

    assert_redirected_to category_path(assigns(:category))
  end

  test "should show category" do
    get :show, id: @category
    assert_response :success
  end

  test "should get edit" do
    post :create, category: { name: 'Name' }
    get :edit, id: Category.find_by_name('Name').id
    assert_response :success
  end

  test "should update category" do
    post :create, category: { name: 'Name' }
    put :update, id: Category.find_by_name('Name').id, category: { name: 'newName' }
    assert_redirected_to category_path(assigns(:category))
  end

  test "should destroy category" do
    post :create, category: { name: 'Name' }
    assert_difference('Category.count', -1) do
      delete :destroy, id: Category.find_by_name('Name').id
    end

    assert_redirected_to categories_path
  end
end
