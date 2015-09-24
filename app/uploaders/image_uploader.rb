class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick

  storage :file
  # storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  process resize_to_fit: [600, 450], convert: 'jpg'

  version :thumb do
    process resize_to_fill: [120, 120]
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end
end
