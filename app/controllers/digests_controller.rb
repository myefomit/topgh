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
      Contributor.find_by(login: contributor)
    end
    @params = contributors

    zipfile_name = "#{Rails.root}/tmp/zips/digests#{Time.now.to_i}.zip"
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      contributors.each do |contributor|
        temp_pdf = Tempfile.new(["digest_#{Time.now.to_i}", '.pdf'])
        temp_pdf.binmode
        temp_prawn_pdf = DigestPdf.new(contributor)
        temp_pdf.write temp_prawn_pdf.render
        temp_pdf.rewind
        zipfile.add("#{contributor.login}.pdf", "#{temp_pdf.path}")
        temp_pdf.close
      end
    end

    File.open(zipfile_name, 'r') do |f|
      send_data f.read, filename: 'digests.zip', type: 'application/zip'
    end
    File.delete(zipfile_name)
  end
end
