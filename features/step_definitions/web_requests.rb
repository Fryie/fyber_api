Given /^there are some offers$/ do
  stub_request(:get, %r{http://api\.sponsorpay\.com/.*}).to_return(
    body: File.read(Rails.root.join('features', 'fixtures', 'offers.json')),
    headers: {
      'Content-Type' => 'application/json',
      'X-Sponsorpay-Response-Signature' => '9d0312e5e40465cf4ac1f40ba39f1cd7174a4e62'
    }
  )
end

Given /^there are no offers$/ do
  stub_request(:get, %r{http://api\.sponsorpay\.com/.*}).to_return(
    body: File.read(Rails.root.join('features', 'fixtures', 'no_offers.json')),
    headers: {
      'Content-Type' => 'application/json',
      'X-Sponsorpay-Response-Signature' => '81b3d42ff29d21caf5f56e17048bf28bdcbb830d'
    }
  )
end

Then /^the fyber API should be queried$/ do
  expect(WebMock).to have_requested(:get,
    'http://api.sponsorpay.com/feed/v1/offers.json').with(query: {
      appid: 157,
      uid: 'player1',
      ip: '109.235.143.113',
      locale: 'de',
      device_id: '2b6f0cc904d137be2e1730235f5664094b831186',
      pub0: 'campaign2',
      timestamp: 1393846200,
      page: 3,
      offer_types: 112,
      os_version: '6.0',
      hashkey: 'HASH'
    }
 )
end
