# encoding: utf-8
class FileUploader < CarrierWave::Uploader::Base
  storage :file

  def store_dir
    "uploads/files"
  end

  def extension_white_list
    %w(docx doc epb psd pdf)
  end
end
