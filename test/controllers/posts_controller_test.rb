require 'test_helper'
require 'active_job/test_helper'

ActiveJob::Base.queue_adapter = :test

class PostsControllerTest < ActionDispatch::IntegrationTest
  include ActiveJob::TestHelper

  setup do
    @post = posts(:one)
  end

  test "should get index" do
    get posts_url
    assert_response :success
  end

  test "should get new" do
    get new_post_url
    assert_response :success
  end

  test "should create post" do
    @post = posts(:with_image)

    assert_performed_jobs(1, only: DownloadImageJob) do
      assert_difference('Post.count') do
        post posts_url, params: { post: { body: @post.body, name: @post.name, image_url: @post.image_url }  }
      end
    end

    last_post = Post.last

    assert_redirected_to post_url(last_post)
  end

  test "should show post" do
    get post_url(@post)
    assert_response :success
  end

  test "should get edit" do
    get edit_post_url(@post)
    assert_response :success
  end

  test "should update post" do
    patch post_url(@post), params: { post: { body: @post.body, name: @post.name } }
    assert_redirected_to post_url(@post)
  end

  test "should destroy post" do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end

    assert_redirected_to posts_url
  end
end
