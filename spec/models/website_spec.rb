require 'rails_helper'

RSpec.describe Website, :type => :model do
  subject { described_class.new }

  it 'is valid with valid attributes' do
    subject.url = 'google.com'
    expect(subject).to be_valid
  end

  it 'is not valid without a url' do
    expect(subject).to_not be_valid
  end

  describe 'Associations' do
    it { should have_many(:rankings) }
    it { should have_many(:user_websites) }
    it { should have_many(:users) }
  end

  describe 'Callbacks' do

    it 'it will always have at least one ranking record' do
      website = Website.create!(url: 'google.com')
      expect( website.rankings.count ).to_not eq(0)
    end

  end

  describe '.get_alexa_global_rank' do

    it 'returns a integer for a valid url' do
      subject.url = 'google.com'
      rank = subject.get_alexa_global_rank

      expect(rank).to_not eq(0)
      expect(rank).to be_a(Integer)
    end

    it 'returns zero for a invalid url' do
      subject.url = 'invalid_url'
      rank = subject.get_alexa_global_rank

      expect(rank).to eq(0)
    end

  end

end