#frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, "モデルに関するテスト",type: :model do
  describe '実際に保存してみる' do
    it "有効な投稿内容の場合は保存されるか" do
      expect(FactoryBot.build(:post)).to be_valid
    end
  end
  context "空白のバリデーションチェック"do
    it "placeが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
       post = Post.new(place: '',address: 'hoge',body: 'hoge',category: 'hoge')
       expect(post).to be_invalid
       expect(post.errors[:place].to include("入力してください"))
    end
    it "addressが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
       post = Post.new(place: 'hoge',address: '',body: 'hoge',category: 'hoge')
       expect(post).to be_invalid
       expect(post.errors[:address].to include("入力してください"))
    end
    it "bodyが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
       post = Post.new(place: 'hoge',address: 'hoge',body: '',category: 'hoge')
       expect(post).to be_invalid
       expect(post.errors[:body].to include("入力してください"))
    end
    it "categoryが空白の場合にバリデーションチェックされ空白のエラーメッセージが返ってきているか" do
       post = Post.new(place: 'hoge',address: 'hoge',body: 'hoge',category: '')
       expect(post).to be_invalid
       expect(post.errors[:category].to include("入力してください"))
    end
  end
end