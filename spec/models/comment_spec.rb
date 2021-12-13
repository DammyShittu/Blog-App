require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'Comment Model Validations' do
    subject { Comment.new(text: 'Very nice post', author_id: 1, post_id: 1) }

    before { subject.save }

    it 'checks if title is valid' do
      subject.text = nil
      expect(subject).to_not be_valid
    end

    it 'checks if author id is a number' do
      subject.author_id = '45e%'
      expect(subject).to_not be_valid
    end

    it 'checks if post id is a number' do
      subject.post_id = 'look'
      expect(subject).to_not be_valid
    end
  end
end
