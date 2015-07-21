# encoding: utf-8
class ImageUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/images"
  end

  def extension_white_list
    %w(jpg png bmp)
  end
end
