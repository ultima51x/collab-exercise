class MockYoutubeApi
  include HTTParty
  raise_on [404, 400]

  base_uri "https://mock-youtube-api-f3d0c17f0e38.herokuapp.com/api"

  def videos(page = 1)
    resp = self.class.get("/videos", {query: {page: page}})
    JSON.parse(resp.body)
  end
end
