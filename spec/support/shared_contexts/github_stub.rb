RSpec.shared_context 'github stub', shared_context: :metadata do
  let(:stubbed_api_url) do
    'https://api.github.com/repos/rails/rails/stats/contributors'
  end
  let(:stubbed_response) do
    [
      { author: { login: '4th', avatar_url: '4', html_url: '4'} },
      { author: { login: '3rd', avatar_url: '3', html_url: '3'} },
      { author: { login: '2nd', avatar_url: '2', html_url: '2'} },
      { author: { login: '1st', avatar_url: '1', html_url: '1'} }
    ].to_json
  end
  let(:stubbed_repo_url) { 'https://github.com/rails/rails' }

  before do
    stub_request(:get, stubbed_api_url)
      .to_return(status: 200, body: stubbed_response, headers: {})
  end
end
