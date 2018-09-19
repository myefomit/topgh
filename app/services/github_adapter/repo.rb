require 'net/http'

module GithubAdapter
  class Repo

    API_BASE_URL = 'https://api.github.com/repos/'
    CONTRIBUTORS_NUMBER = 3

    def initialize(url:)
      @url = url
    end

    def contributors
      contributors = request_contributors
      parse_contributors contributors
    end

    private

    def request_contributors
      # wait untill github responds with 200
      # https://developer.github.com/v3/repos/statistics/#a-word-about-caching
      response = Net::HTTP.get_response(build_api_url)
      while response.code != '200' do
        response = Net::HTTP.get_response(build_api_url)
      end
      response = JSON.parse(response.body)
    end

    def parse_contributors(response)
      contributors = response.last(CONTRIBUTORS_NUMBER)
      contributors.map do |contributor|
        author = contributor['author']
        {
          login: author['login'],
          avatar_url: author['avatar_url'],
          url: author['html_url']
        }
      end.reverse
    end

    def build_api_url
      owner, repo = @url.split('/').last(2)
      url = "#{API_BASE_URL}#{owner}/#{repo}/stats/contributors"
      URI url
    end
  end
end
