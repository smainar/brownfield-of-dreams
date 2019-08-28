require 'rails_helper'

RSpec.describe Video, type: :model do
  describe 'validations' do
    it { should validate_presence_of :position }
    it { should validate_numericality_of(:position).is_greater_than(-1) }
  end

  describe 'relationships' do
    it { should have_many :user_videos }
    it { should have_many(:users).through(:user_videos) }
    it { should belong_to :tutorial }
  end
end
