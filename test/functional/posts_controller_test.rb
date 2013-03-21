require 'test_helper'

class PostsControllerTest < ActionController::TestCase
  setup do
    @post = posts(:one)
  end

  test "should create post" do
    assert_difference('Post.count') do
      post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    end

    assert_redirected_to post_path(assigns(:post))
  end
  test "should get index" do
    post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    get :index
    assert_response :success
    assert_not_nil assigns(:posts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should show post" do
    post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    get :show, id: Post.find_by_title("title").id
    assert_response :success
  end

  test "should get edit" do
    post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    get :edit, id: Post.find_by_title("title").id
    assert_response :success
  end

  test "should update post" do
    post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    put :update, id: @post, post: { title: "title", content: "content and stuff edited", user_id: "1", category_id: "1", parent_post_id: "" }
    assert_redirected_to post_path(assigns(:post))
  end

  test "should destroy post" do
    post :create, post: { title: "title", content: "content and stuff", user_id: "1", category_id: "1", parent_post_id: "" }
    assert_difference('Post.count', -1) do
      delete :destroy, id: Post.find_by_title("title").id
    end
  end
end
