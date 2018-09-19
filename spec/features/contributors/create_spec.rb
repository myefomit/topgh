require 'rails_helper'

RSpec.describe 'create' do
  context 'correct params given' do
    let(:api_url) do
      'https://api.github.com/repos/rails/rails/stats/contributors'
    end
    let(:stubbed_response) do
      [
        { author: { login: '4th', avatar_url: '4', html_url: '4'} },
        { author: { login: '3rd', avatar_url: '3', html_url: '3'} },
        { author: { login: '2nd', avatar_url: '2', html_url: '2'} },
        { author: { login: '1st', avatar_url: '1', html_url: '1'} }
      ].to_json
    end
    let(:repo_url) { 'https://github.com/rails/rails' }

    before do
      stub_request(:get, api_url)
        .to_return(status: 200, body: stubbed_response, headers: {})
    end

    it 'creates list of top contributors' do
      visit root_path

      fill_in 'Repo URL', with: repo_url
      click_button 'Search'

      aggregate_failures do
        expect(page).to have_content '3rd'
        expect(page).to have_content '2nd'
        expect(page).to have_content '1st'
        expect(page).not_to have_content '4th'
      end
    end
  end
end
