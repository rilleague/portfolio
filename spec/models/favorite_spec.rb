require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before do
    @favorite = FactoryBot.build(:favorite)
  end

  describe 'いいね機能' do
    context 'いいね出来る場合' do
      it 'user_idとpost_idが存在すれば保存出来る' do
        expect(FactoryBot.create(:favorite)).to be_valid
      end
    end

    context 'いいね出来ない場合' do
      it 'post_idが空ではいいね出来ない' do
        @favorite.post_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Postを入力してください")
      end

      it 'user_idが空ではいいね出来ない' do
        @favorite.user_id = nil
        @favorite.valid?
        expect(@favorite.errors.full_messages).to include("Userを入力してください")
      end
    end
  end
end
