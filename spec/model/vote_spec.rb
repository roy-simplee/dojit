require 'rails_helper'

describe Vote do
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        user = User.create
        topic = Topic.create
        post = Post.create(title: 'post title', body: 'post b                         ody', user: user, topic: topic)
          expect(Vote.create(:value => 1, user: user, post: post).valid?).to eq(true)
          expect(Vote.create(value: -1, user: user, post: post).valid?).to eq(true)
          expect(Vote.create(value: 2, user: user, post: post).valid?).to eq(false)
      end
    end
  end
end