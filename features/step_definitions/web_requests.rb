Given /^there are some offers$/ do
  stub_request(:get, %r{http://api\.sponsorpay\.com/.*}).to_return(
    body: File.read(Rails.root.join('features', 'fixtures', 'offers.json')),
    headers: { 'Content-Type' => 'application/json' }
  )
end

Given /^there are no offers$/ do
  stub_request(:get, %r{http://api\.sponsorpay\.com/.*}).to_return(
    body: File.read(Rails.root.join('features', 'fixtures', 'no_offers.json')),
    headers: { 'Content-Type' => 'application/json' }
  )
end
