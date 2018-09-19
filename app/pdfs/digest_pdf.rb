require 'open-uri'

class DigestPdf
  include Prawn::View

  def initialize(person)
    @person = person

    move_down 70
    print_digest
  end

  private

  def print_digest
    text 'The award goes to', style: :bold, size: 24, align: :center
    move_down 20

    avatar
    move_down 20

    text @person.login, style: :bold, size: 20, align: :center
    move_down 10

    text "Check out #{@person.login}'s profile at:", size: 16, align: :center
    text @person.url, link: @person.url, size: 16, align: :center, color: '0000ff'
  end

  def avatar
    download = open(@person.avatar_url)
    avatar_path = "#{Rails.root}/tmp/#{@person.login}_avatar"
    IO.copy_stream(download, avatar_path)

    image avatar_path, fit: [200, 200], position: :center
    File.delete(avatar_path)
  end
end
