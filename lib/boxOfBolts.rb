require_relative 'item'

class BoxOfBolts < Item

  def initialize
    super('Box of bolts', 25)
  end #initialize

  def feed(target)
      target.heal(20)
  end #feed


end #class
