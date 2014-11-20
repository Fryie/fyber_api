class OfferService
  include HTTParty
  base_uri 'api.sponsorpay.com/feed/v1'

  def self.search(query_params)
    params_without_hash = collect_params(query_params)
    get '/offers.json', query: params_without_hash.merge(
      hashkey: HashKeyService.compute(params_without_hash)
    )
  end

  private

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

end
