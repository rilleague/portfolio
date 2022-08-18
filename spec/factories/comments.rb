FactoryBot.define do
  factory :comment do
    content { 'これはテストです' }
    association :post
    association :user
  end
end
