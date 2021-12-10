require 'rails_helper'

RSpec.describe User, type: :model do
  describe "User Model Validations" do
    subject { User.new(name: 'Damola', bio: 'Software developer with a heart of gold.') }

    before{subject.save}

    it "checks if name is valid" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "checks if bio is present" do
      subject.bio = nil
      expect(subject).to_not be_valid
    end

    it "validates that posts counter is an integer" do
      subject.posts_counter = "@m,,"
      expect(subject).to_not be_valid
    end

    it "validates that posts counter is greater than or equal to 0" do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end

  end

  describe 'validates recent posts method' do
    before { 4.times { |post| Post.create(author: subject, title: "This is post #{post}") } }

    it 'shows three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end
end
