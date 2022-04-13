class Card
  attr_reader :type, :suit, :value

  def initialize(type, suit)
    @type = type
    @suit = suit
  end

end
