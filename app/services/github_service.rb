class GithubService

  def self.get_uri(uri)
    # access_token = "token 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"
    # response = HTTParty.get(uri, headers: {authorization: access_token})
    response = HTTParty.get(uri)
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.repo
    get_uri('https://api.github.com/repos/musselmanth/little-esty-shop')
  end

  def self.contributors
    get_uri('https://api.github.com/repos/musselmanth/little-esty-shop/contributors')
  end

  def self.get_pulls
    get_uri('https://api.github.com/repos/musselmanth/little-esty-shop/pulls?state=closed')
  end

end
