class ImageUploader < CarrierWave::Uploader::Base
  # 画像サイズを取得するためにRMagick使用
  include CarrierWave::MiniMagick
  process resize_to_fill: [400, 400, 'Center'] 

  # developmentとtest以外はS3を使用(=production:本番環境ではfogで外部ストレージにアップロード)
  if Rails.env.development? || Rails.env.test? 
    storage :file
  else
    storage :fog
  end

  # 画像ごとに保存するディレクトリを変える
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # 許可する画像の拡張子
  def extension_whitelist
    %w(jpg jpeg gif png)
  end
end
