require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'User Model Validations' do
    subject { User.new(name: 'Damola', bio: 'Software developer with a heart of gold.', posts_counter: 2) }

    before { subject.save }

    it 'checks if name is valid' do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it 'checks if bio is present' do
      subject.bio = 'Hello there, I am a software developer'
      expect(subject).to be_valid
    end

    it 'validates that posts counter is an integer' do
      subject.posts_counter = '@m,,'
      expect(subject).to_not be_valid
    end

    it 'validates that posts counter is greater than or equal to 0' do
      subject.posts_counter = -1
      expect(subject).to_not be_valid
    end
  end

  describe 'validates recent posts method' do
    before do
      4.times do |post|
        Post.create(author_id: subject, title: "This is post #{post}", text: 'Lorem ipsum laoessh, riahe')
      end
    end

    it 'shows three recent posts' do
      expect(subject.recent_posts).to eq(subject.posts.last(3))
    end
  end
end
