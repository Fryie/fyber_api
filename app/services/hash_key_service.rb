class HashKeyService

  def self.compute(params)
    sorted_params = sort(params)
    param_string = join(sorted_params)
    param_string += "&#{Settings.fyber_api.api_key}"
    Digest::SHA1.hexdigest param_string
  end

  private

  def self.sort(params)
    params.to_a.sort { |a, b| a[0] <=> b[0] }
  end

  def self.join(params)
    params.map do |pair|
      pair.join '='
    end.join '&'
  end

end
