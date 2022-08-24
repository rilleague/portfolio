require 'rails_helper'

RSpec.describe PostForm, type: :model do
  let(:post_form) { PostForm.new({}, post: Post.new(attributes))  }
  
  describe '#save' do
    context '必須項目が入力されている場合' do
      let(:tag_list){ ['tagname1', 'tagname2'] }
      context '画像無しの場合' do
        let(:attributes){{title: 'これはテスト', category_id: '2', detail: 'この文章はテスト用の文章'}}
        it '保存に成功し、Postのレコードが1つ追加されている' do
          expect do
            binding.pry
            post_form.save(tag_list)
          end.to change{Post.count}.by(1)
        end
      end
      context '画像が1枚保存されている場合' do
      end
    end
  end
end