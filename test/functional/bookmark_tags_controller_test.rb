require 'test_helper'

class BookmarkTagsControllerTest < ActionController::TestCase
  setup do
    @bookmark_tag = bookmark_tags(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bookmark_tags)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bookmark_tag" do
    assert_difference('BookmarkTag.count') do
      post :create, bookmark_tag: @bookmark_tag.attributes
    end

    assert_redirected_to bookmark_tag_path(assigns(:bookmark_tag))
  end

  test "should show bookmark_tag" do
    get :show, id: @bookmark_tag
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @bookmark_tag
    assert_response :success
  end

  test "should update bookmark_tag" do
    put :update, id: @bookmark_tag, bookmark_tag: @bookmark_tag.attributes
    assert_redirected_to bookmark_tag_path(assigns(:bookmark_tag))
  end

  test "should destroy bookmark_tag" do
    assert_difference('BookmarkTag.count', -1) do
      delete :destroy, id: @bookmark_tag
    end

    assert_redirected_to bookmark_tags_path
  end
end
