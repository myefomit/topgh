class ContributorsController < ApplicationController
  def index; end

  def create
    @contributors = GithubAdapter::Repo.new(url: params[:url]).contributors
    @contributors.map! { |contributor| build_contributor(contributor) }
  end

  private

  def build_contributor(contributor)
    Contributor.find_by(login: contributor[:login]) ||
    Contributor.create(contributor)
  end
end
