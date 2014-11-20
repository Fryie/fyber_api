require 'rails_helper'

describe OffersController do
  
  describe '#display_search_form' do

    it 'renders the search form' do
      get :display_search_form
      expect(response).to render_template :search_form
    end

  end

end
