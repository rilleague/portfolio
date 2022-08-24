require 'rails_helper'

RSpec.describe Comment, type: :model do
  before do
    @comment = FactoryBot.build(:comment)
  end

  describe 'コメント機能' do
    context 'コメント投稿出来る場合' do
      it 'content(文字数制限内)が存在すれば投稿出来る' do
        expect(@comment).to be_valid
      end
    end

    context 'コメント投稿出来ない場合' do
      it 'contentが空の場合' do
        @comment.content = ''
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメント内容を入力してください")
      end

      it "contentが200文字以下でなければ登録出来ない" do
        @comment.content = "a" * 201
        @comment.valid?
        expect(@comment.errors.full_messages).to include("コメント内容は200文字以内で入力してください")
      end

      it 'userが紐付いていない場合' do
        @comment.user = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Userを入力してください")
      end

      it 'postが紐付いていない場合' do
        @comment.post = nil
        @comment.valid?
        expect(@comment.errors.full_messages).to include("Postを入力してください")
      end
    end
  end
end
