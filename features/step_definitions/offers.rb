When /^I submit a request$/ do
  visit offers_search_path
  fill_in 'User ID', with: 'player1'
  fill_in 'Parameter', with: 'campaign2'
  fill_in 'Page', with: 3
  click_button 'Search'
end
