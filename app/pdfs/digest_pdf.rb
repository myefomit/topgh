class DigestPdf
  include Prawn::View

  def initialize(person)
    @person = person
    print_digest
  end

  private

  def print_digest
    text "The award goes to", style: :bold, size: 11, align: :center
    text @person[:login]
  end
end
