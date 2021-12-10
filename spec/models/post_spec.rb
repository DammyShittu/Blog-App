require 'rails_helper'

RSpec.describe Post, type: :model do
  describe "Post Model Validations" do
    user = User.create(name: 'Dammy', bio: 'Dammy is so cool!', )
    subject { Post.new(title: 'Bootstrap vs Tailwind', text: 'Let\'s  talk about Bootstrap and Tailwind', author_id: user) }

    before{subject.save}

    it "checks if title is valid" do
      subject.title = nil
      expect(subject).to_not be_valid
    end

    it "checks if title has more than 250 characters" do
      subject.title.length > 250
      expect(subject).to_not be_valid
    end

    it "validates that comments counter is an integer" do
      subject.comments_counter = "jdj"
      expect(subject).to_not be_valid
    end

    it "validates that comments counter is greater than or equal to 0" do
      subject.comments_counter = -5.5
      expect(subject).to_not be_valid
    end

    it "validates that likes counter is an integer" do
      subject.likes_counter = "abc"
      expect(subject).to_not be_valid
    end

    it "validates that likes counter is greater than or equal to 0" do
      subject.likes_counter = -1
      expect(subject).to_not be_valid
    end

    describe 'should test methods in post model' do
      it 'post should have five recent comments' do
        expect(subject.recent_comments).to eq(subject.comments.last(5))
      end
    end
  end
end
