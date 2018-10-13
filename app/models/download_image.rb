class DownloadImage
  def initialize(post)
    @post = post
  end

  def download!
    @post.image.attach(io: file, filename: filename)
  end

  private

  def filename
    @filename ||= File.basename(@post.image_url)
  end

  def file
    @file ||= open(@post.image_url)
  end
end
