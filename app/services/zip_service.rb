class ZipService

  def initialize(contributors:)
    @contributors = contributors
  end

  def zip_data
    zipfile_name = "#{Rails.root}/tmp/digests#{Time.now.to_i}.zip"

    begin
      zip_pdf_files zipfile_name
      zip_data = File.open(zipfile_name, 'r').read
    ensure
      File.delete(zipfile_name)
    end

    zip_data
  end

  private

  def zip_pdf_files(zipfile_name)
    Zip::File.open(zipfile_name, Zip::File::CREATE) do |zipfile|
      @contributors.each do |contributor|
        temp_pdf = Tempfile.new(["digest#{Time.now.to_i}", '.pdf'])
        temp_pdf.binmode
        temp_pdf.write(
          DigestPdf.new(contributor).render
        )
        temp_pdf.rewind
        zipfile.add("#{contributor.login}.pdf", temp_pdf.path)
        temp_pdf.close
      end
    end
  end
end
