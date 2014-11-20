class OffersController < ApplicationController

  def display_search_form
    render :search_form
  end

  def submit_search_form
    query = params.symbolize_keys.slice(:uid, :pub0, :page)
    query[:page] = query[:page].to_i

    begin
      @offers = OfferService.search(query)
      render :offer_list
    rescue OfferSearchException
      flash[:error] = 'Oops, something went wrong!'
      render :search_form
    end
  end

end
