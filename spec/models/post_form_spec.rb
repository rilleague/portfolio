require 'rails_helper'

RSpec.describe PostForm, type: :model do
  let(:post_form) { PostForm.new(attributes) }

  describe '#save' do
    context '必須項目が入力されている場合' do
      before do
        @user = User.create(nickname: 'taro', email: 'hoge@gmail.com', password: 'test123')
      end
      let(:tag_list){ ['tagA', 'tagB'] }

      context '画像無しの場合' do
        let(:attributes){ {'title' => 'テストします', 'category_id' => '2', 'detail' => 'この文章はテスト用の文章です', 'user_id' => @user.id} }
        it '保存に成功し、Postのレコードが1つ追加されている' do
          expect do
            post_form.save(tag_list)
          end.to change{Post.count}.by(1)
        end
      end

      context '画像有りの場合' do
        let(:attributes){ {'title' => 'テストします', 'category_id' => '2', 'detail' => 'この文章はテスト用の文章です', 'user_id' => @user.id} }
        it '保存に成功し、保存された画像情報を取得出来る' do
          post_form.save(tag_list)
          post = post_form.to_model.reload
          post.images.each do |image|
            expect(image.original_filename).to eq ["test.png", "test1.png", "test2.png"]
          end
        end
      end
    end
  end
end