#require 'item'

class Weapon < Item

  attr_reader :damage, :range

  def initialize(name, weight, dmg, range=1)
    super(name, weight)
    @damage = dmg
    @range = range
  end #initialize

  def hit(target)
    target.wound(damage)
  end #hit

end #class
