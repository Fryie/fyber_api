class OfferService
  include HTTParty
  base_uri 'api.sponsorpay.com/feed/v1'

  def self.search(query_params)
    begin
      body, signature, code = submit_search_request(query_params)
      json = JSON.parse(body)
    rescue
      raise OfferSearchException
    end

    unless code == 200 && validate_signature(body, signature)
      raise OfferSearchException
    end

    create_offers(json)
  end

  private

  def self.submit_search_request(query_params)
    params_without_hash = collect_params(query_params)
    response = get '/offers.json', query: params_without_hash.merge(
      hashkey: HashKeyService.compute(params_without_hash)
    )

    [response.body, response.headers['X-Sponsorpay-Response-Signature'], response.code]
  end

  def self.collect_params(query_params)
    {
      appid: Settings.fyber_api.app_id,
      uid: query_params[:uid],
      locale: Settings.fyber_api.locale,
      os_version: Settings.fyber_api.os_version,
      timestamp: Time.now.to_i,
      ip: Settings.fyber_api.ip,
      pub0: query_params[:pub0],
      page: query_params[:page],
      offer_types: Settings.fyber_api.offer_types,
      device_id: Settings.fyber_api.device_id
    }
  end

  def self.validate_signature(body, signature)
    Digest::SHA1.hexdigest("#{body}#{Settings.fyber_api.api_key}") == signature
  end

  def self.create_offers(json)
    json['offers'].map do |offer_json|
      Offer.new(
        title: offer_json['title'],
        payout: offer_json['payout'],
        thumbnail: offer_json['thumbnail']['lowres']
      )
    end
  end

end
