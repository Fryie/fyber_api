require 'rails_helper'

describe OfferService do

  before :each do
    allow(OfferService).to receive(:submit_search_request) do
      [File.read(Rails.root.join('features', 'fixtures', 'offers.json')),
       'SIGNATURE',
      200]
    end
    allow(OfferService).to receive(:validate_signature) { true }
  end

  it 'queries the API' do
    OfferService.search a: 1, b: 2
    expect(OfferService).to have_received(:submit_search_request).with a: 1, b: 2
  end

  it 'returns created offers' do
    offers = OfferService.search({})
    expect(offers[0].title).to eq 'Tap Fish'
    expect(offers[0].payout).to eq 90
    expect(offers[0].thumbnail).to eq 'THUMBNAIL1_LOWRES'
    expect(offers[1].title).to eq 'Offer 2'
    expect(offers[1].payout).to eq 90
    expect(offers[1].thumbnail).to eq 'THUMBNAIL2_LOWRES'
  end

  context 'if API querying raises an error' do

    it 'raises an OfferSearchException' do
      allow(OfferService).to receive(:submit_search_request).and_raise SocketError
      expect {
        OfferService.search({})
      }.to raise_error OfferSearchException
    end

  end

  context 'if query returns a bad status code' do

    it 'raises an OfferSearchException' do
      allow(OfferService).to receive(:submit_search_request) do
        [File.read(Rails.root.join('features', 'fixtures', 'offers.json')),
         'SIGNATURE',
        400]
      end
      expect {
        OfferService.search({})
      }.to raise_error OfferSearchException
    end

  end

  context 'if response signature is invalid' do

    it 'raises an OfferSearchException' do
      allow(OfferService).to receive(:validate_signature) { false }
      expect {
        OfferService.search({})
      }.to raise_error OfferSearchException
    end

  end

end
