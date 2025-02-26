# frozen_string_literal: true

require 'rails_helper'

describe 'An Admin receives a flash message when they cannot tutorial' do
  let(:tutorial) { create(:tutorial) }
  let(:admin)    { create(:admin) }

  scenario 'by adding a video', :js do
    VCR.use_cassette('admin_edit_tutorial', record: :new_episodes) do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

      visit edit_admin_tutorial_path(tutorial)

      click_on 'Add Video'

      fill_in 'video[title]', with: 'How to tie your shoes.'
      fill_in 'video[description]', with: 'Over, underpull and through.'
      fill_in 'video[video_id]', with: 'J7ikFUlkP_k'
      click_on 'Create Video'

      expect(current_path).to eq(edit_admin_tutorial_path(tutorial))

      expect(page).to have_content('Unable to create video')
    end
  end
end
