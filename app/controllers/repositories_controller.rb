class RepositoriesController < ApplicationController
  def index; end

  def create
    response = Net::HTTP.get(build_url)
    response = JSON.parse(response)
    @contributors = response.last(3)
    @contributors.map! do |contributor|
      author = contributor['author']
      {
        login: author['login'],
        avatar_url: author['avatar_url'],
        url: author['html_url']
      }
    end
  end

  private

  def build_url
    owner, repo = params[:url].split('/').last(2)
    url = "https://api.github.com/repos/#{owner}/#{repo}/stats/contributors"
    URI url
  end
end
