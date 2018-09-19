class DigestsController < ApplicationController

  def show
    contributor = Contributor.find(params[:contributor_id])
    digest = DigestPdf.new(contributor).render
    send_data(
      digest, filename: "#{contributor.login}.pdf", type: 'application/pdf'
    )
  end

  def zip
    contributors = params[:contributors].map do |contributor|
      Contributor.find(contributor)
    end

    zip_data = ZipService.new(contributors: contributors).zip_data
    send_data zip_data, filename: 'digests.zip', type: 'application/zip'
  end
end
