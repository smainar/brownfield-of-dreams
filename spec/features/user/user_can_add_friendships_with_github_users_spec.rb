# frozen_string_literal: true

require 'rails_helper'

describe 'A Registered Github user' do
  it 'can add other registered github users as friends' do
    VCR.use_cassette('github_user_friends', record: :new_episodes) do
      user_1 = create(:github_user)

      user_2 = create(
        :github_user,
        github_handle: 'kylecornelissen',
        github_url: 'https://github.com/kylecornelissen'
      )
      user_3 = create(
        :github_user,
        github_handle: 'bplantico',
        github_url: 'https://github.com/bplantico'
      )

      user_4 = create(
        :github_user,
        github_handle: 'ryanmillergm',
        github_url: 'https://github.com/ryanmillergm'
      )

      user_5 = create(
        :github_user,
        github_handle: 'n-flint',
        github_url: 'https://github.com/n-flint'
      )

      user_6 = create(
        :github_user,
        github_handle: 'chakeresa',
        github_url: 'https://github.com/chakeresa'
      )

      friendship_1 = Friendship.create!(user_id: user_1.id, friend_id: user_2.id)

      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user_1)

      visit '/dashboard'

      within(page.all('.github-followers')[1]) do
        expect(page).to have_button('Add Friend')
        click_on 'Add Friend'
      end

      expect(page).to
      have_content("#{user_3.github_handle} has been added as a friend.")
      user_1.reload
      visit '/dashboard'

      within(first('.github-followers')) do
        expect(page).to_not have_button('Add Friend')
      end

      expect(page).to have_content('My Friends')

      within(page.all('.friend-list')[1]) do
        expect(page).to have_link('bplantico')
      end
    end
  end
end
