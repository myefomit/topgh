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
    zipfile_name = ZipService.new(contributors: contributors).zip
    send_and_delete zipfile_name
  end

  private

  def send_and_delete(file_name)
    File.open(file_name) do |file|
      send_data file.read, filename: 'digests.zip', type: 'application/zip'
    end
    File.delete(file_name)
  end
end
