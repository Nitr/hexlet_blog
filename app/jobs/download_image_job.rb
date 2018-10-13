class DownloadImageJob < ApplicationJob
  queue_as :default

  def perform(post_id)
    post = Post.find(post_id)
    DownloadImage.new(post).download!
  end
end
