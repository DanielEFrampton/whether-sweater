class Background
  attr_reader :id, :image_url

  def initialize(image_url)
    @id = nil
    @image_url = image_url
  end
end
