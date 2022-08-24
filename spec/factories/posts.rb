FactoryBot.define do
  factory :post do
    title { 'テストをします' }
    images { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test.png')) }
    category_id { 2 }
    part_id { 2 }
    skin_id { 2 }
    detail { 'この文章はテスト用の文章です。' }
    association :user
  end
end
