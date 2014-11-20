require 'rails_helper'

describe OffersController do
  
  describe '#display_search_form' do

    it 'renders the search form' do
      get :display_search_form
      expect(response).to render_template :search_form
    end

  end

  describe '#submit_search_form' do

    before :each do
      allow(OfferService).to receive(:search) { 'OFFERS' }
    end

    it 'queries offers for the given parameters' do
      post :submit_search_form, uid: 'uid', pub0: 'param', page: 2
      expect(OfferService).to have_received(:search).with(
        uid: 'uid', pub0: 'param', page: 2
      )
    end

    context 'if query succeeds' do

      before :each do
        post :submit_search_form, uid: 'uid', pub0: 'param', page: 2
      end

      it 'sets the offers variable' do
        expect(assigns(:offers)).to eq 'OFFERS'
      end

      it 'renders the offer list' do
        expect(response).to render_template :offer_list
      end

    end

    context 'if query fails' do

      before :each do
        allow(OfferService).to receive(:search).and_raise OfferSearchException
        post :submit_search_form, uid: 'uid', pub0: 'param', page: 2
      end

      it 'displays an error' do
        expect(flash[:error]).to be_present
      end

      it 'rerenders the search form' do
        expect(response).to render_template :search_form
      end

    end

  end

end
