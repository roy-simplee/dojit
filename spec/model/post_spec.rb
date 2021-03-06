require 'rails_helper'

describe Post do
  describe "vote methods" do

    before do
      # user = User.create
      # topic = Topic.create
      @post = Post.new(title: 'post title', body: 'post b                         ody')
      post_user = double(votes: @post.votes)
      allow(@post).to receive(:user) {post_user}
      # p @post.to_json
      @post.save
      3.times { @post.votes.create(value: 1) }
      2.times { @post.votes.create(value: -1) }
    end

    describe '#down_votes' do
      it "counts the number of votes with value = -1" do
        expect( @post.down_votes ).to eq(2)
      end
    end

    describe '#points' do
      it "returns the sum of all down and up votes" do
        expect( @post.points ).to eq(1) # 3 - 2
      end
    end
  end
end