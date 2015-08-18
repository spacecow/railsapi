class Reference < ActiveRecord::Base
  mount_uploader :image, MentionUploader

  def image_data= data
    io = CarrierStringIO.new(Base64.decode64(data))
    self.image = io
  end

  class CarrierStringIO < StringIO
    def original_filename
      # the real name does not matter
      "photo.jpeg"
    end

    def content_type
      # this should reflect real content type, but for this example it's ok
      "image/jpeg"
    end
  end
end