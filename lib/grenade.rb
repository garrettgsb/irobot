class Grenade < Weapon

  attr_reader :name, :weight, :damage

  def initialize
    super('Grenade', 40, 15, 2)
  end #initialize

end #class
