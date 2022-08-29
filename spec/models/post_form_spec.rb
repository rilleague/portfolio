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

  describe 'バリデーション' do
    before do
      @user = User.create(nickname: 'taro', email: 'hoge@gmail.com', password: 'test123')
    end
    let(:tag_list){ ['tagA', 'tagB'] }

    context 'titleが空の場合' do
      let(:attributes){{ 'title' => '', 'category_id' => '2', 'detail' => 'この文章はテスト用の文章です', 'user_id' => @user.id}} 
      it '保存に失敗し、エラー文が表示される' do
        post_form.valid?
        expect(post_form.errors.full_messages).to include("タイトルを入力してください")
      end
    end

    context 'titleが81字以上の場合' do
      let(:attributes){{ 'title' => 'a' * 81, 'category_id' => '2', 'detail' => 'この文章はテスト用の文章です', 'user_id' => @user.id }} 
      it '保存に失敗し、エラー文が表示される' do
        post_form.valid?
        expect(post_form.errors.full_messages).to include("タイトルは80文字以内で入力してください")
      end
    end

    context 'category_idを選択していない場合' do
      let(:attributes){{ 'title' => 'テストします', 'category_id' => '1', 'detail' => 'この文章はテスト用の文章です', 'user_id' => @user.id }} 
      it '保存に失敗し、エラー文が表示される' do
        post_form.valid?
        expect(post_form.errors.full_messages).to include("投稿カテゴリーを入力してください")
      end
    end

    context 'detailが空の場合' do
      let(:attributes){{ 'title' => 'テストします', 'category_id' => '2', 'detail' => '', 'user_id' => @user.id }} 
      it '保存に失敗し、エラー文が表示される' do
        post_form.valid?
        expect(post_form.errors.full_messages).to include("内容を入力してください")
      end
    end

    context 'detailが401字以上の場合' do
      let(:attributes){{ 'title' => 'テストします', 'category_id' => '2', 'detail' => 'a' * 401, 'user_id' => @user.id }}
      it '保存に失敗し、エラー文が表示される' do
        post_form.valid?
        expect(post_form.errors.full_messages).to include("内容は400文字以内で入力してください")
      end

      context 'imagesが4枚以上存在する場合' do
        let(:attributes){ {'title' => 'テストします', 'category_id' => '2', 'detail' => 'この文章はテスト用の文章です', 'images' => [fixture_file_upload('files/test.png', 'image/png'), fixture_file_upload('files/test1.png', 'image/png'), fixture_file_upload('files/test2.png', 'image/png'), fixture_file_upload('files/test3.png', 'image/png')], 'user_id' => @user.id} }
        it '保存に失敗し、エラー文が表示される' do
          post_form.valid?
          expect(post_form.errors.full_messages).to include("画像選択に添付出来る画像は3枚までです。")
        end
      end
    end
  end
end