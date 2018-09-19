require 'rails_helper'

RSpec.describe GithubAdapter::Repo do
  include_context 'github stub'

  context 'correct params given' do
    subject { described_class.new(url: stubbed_repo_url).contributors }

    it 'returns exact number of contributors' do
      expect(subject.count).to eq described_class::CONTRIBUTORS_NUMBER
    end

    it 'returns contributors in right order' do
      aggregate_failures do
        expect(subject[0][:login]).to eq '1st'
        expect(subject[1][:login]).to eq '2nd'
        expect(subject[2][:login]).to eq '3rd'
      end
    end
  end
end
