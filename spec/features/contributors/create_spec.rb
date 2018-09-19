require 'rails_helper'

RSpec.describe 'create' do
  include_context 'github stub'

  context 'correct params given' do
    it 'creates list of top contributors' do
      visit root_path

      fill_in 'Repo URL', with: stubbed_repo_url
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
