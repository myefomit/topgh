class ContributorsController < ApplicationController
  def index; end

  def create
    response = Net::HTTP.get(build_url)
    response = JSON.parse(response)
    @contributors = response.last(3)
    @contributors.map! do |contributor|
      author = contributor['author']
      contributor_params = ({
        login: author['login'],
        avatar_url: author['avatar_url'],
        url: author['html_url']
      })
      build_contributor contributor_params
    end
  end

  private

  def build_contributor(contributor)
    Contributor.find_by(login: contributor[:login]) ||
    Contributor.create(contributor)
  end

  def build_url
    owner, repo = params[:url].split('/').last(2)
    url = "https://api.github.com/repos/#{owner}/#{repo}/stats/contributors"
    URI url
  end
end
