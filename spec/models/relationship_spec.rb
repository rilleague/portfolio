require 'rails_helper'

RSpec.describe Relationship, type: :model do
  before do
    @relationship = FactoryBot.build(:relationship)
  end

  describe 'フォロー機能' do
    context 'フォロー出来る場合' do
      it 'パラメーターにfollower_idとfollowed_idが存在すればフォロー出来る' do
        expect(@relationship).to be_valid
      end
    end

    context 'フォロー出来ない場合' do
      it 'follower_idが空の場合、フォロー出来ない' do
        @relationship.follower_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followerを入力してください")
      end

      it 'followed_idが空の場合、フォロー出来ない' do
        @relationship.followed_id = nil
        @relationship.valid?
        expect(@relationship.errors.full_messages).to include("Followedを入力してください")
      end
    end

    context "一意性の検証" do
      before do
        @relation = FactoryBot.create(:relationship)
        @user1 = FactoryBot.build(:relationship)
      end

      it 'follower_idとfollowedの組み合わせは一意性(他と重複しない)がないと保存出来ない' do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @relation.followed_id)
        relation2.valid?
        expect(relation2.errors.full_messages).to include("Followerはすでに存在します")
      end

      it 'follower_idが既存で有っても、followed_idが異なっている場合は、保存出来る' do
        relation2 = FactoryBot.build(:relationship, follower_id: @relation.follower_id, followed_id: @user1.followed_id)
        expect(relation2).to be_valid
      end

      it 'followed_idが既存で有っても、follower_idが異なっている場合は、保存出来る' do
        relation2 = FactoryBot.build(:relationship, follower_id: @user1.follower_id, followed_id: @relation.followed_id)
        expect(relation2).to be_valid
      end
    end
  end
end
