# CarrierWaveの設定呼び出し
require 'carrierwave/storage/abstract'
require 'carrierwave/storage/file'
require 'carrierwave/storage/fog'

# 保存先の分岐
CarrierWave.configure do |config|
  # 本番環境はS3に保存
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = 'fog/aws'
    config.fog_directory  = 'polishine20220901'
    config.asset_host = 'https://s3.amazonaws.com/polishine20220901'
    config.fog_public = false
    # iam_profile
    config.fog_credentials = {
      provider: 'AWS',
      # 環境変数で管理する場合
      aws_access_key_id: ENV['AWS_ACCESS_KEY_ID'],
      aws_secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'],
      region: 'ap-northeast-1' #東京リージョン
      # path_style: true
    }
  else
    # 開発環境はlocalに保存
    config.storage :file
    config.enable_processing = false if Rails.env.test? #test:処理をスキップ
  end  
end