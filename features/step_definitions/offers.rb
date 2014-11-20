When /^I submit a request$/ do
  Timecop.freeze Time.local(2014,3,3,12,30,0)
  allow(HashKeyService).to receive(:compute) { 'HASH' }

  visit offers_search_path
  fill_in 'User ID', with: 'player1'
  fill_in 'Parameter', with: 'campaign2'
  fill_in 'Page', with: 3
  click_button 'Search'
end

Then /^I should see the offers$/ do
  within first('li .offer') do
    expect(page).to have_selector '.title', text: 'Tap Fish'
    expect(page).to have_selector '.payout', text: '90'
    expect(page).to have_selector '.thumbnail img[src="THUMBNAIL1_LOWRES"]'
  end

  within 'li:eq(2) .offer' do
    expect(page).to have_selector '.title', text: 'Offer 2'
    expect(page).to have_selector '.payout', text: '90'
    expect(page).to have_selector '.thumbnail img[src="THUMBNAIL2_LOWRES"]'
  end
end

Then /^I should see that there are no offers$/ do
  expect(page).to have_selector '.no_offers', text: 'No offers'
end
