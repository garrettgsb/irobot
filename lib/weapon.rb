#require 'item'

class Weapon < Item

  attr_reader :damage

  def initialize(name, weight, dmg)
    super(name, weight)
    @damage = dmg
  end #initialize

  def hit(target)
    target.wound(damage)
  end #hit

end #class
