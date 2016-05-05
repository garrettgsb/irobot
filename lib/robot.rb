class Robot

  attr_accessor :position,
                :items,
                :items_weight,
                :health,
                :equipped_weapon

  def initialize
    @position = [0,0]
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end #initialize

  def wound(amt)
    @health -= amt
    if @health < 0
        @health = 0
    end #if
  end #wound

  def pick_up(item)
    if items_weight + item.weight <= 250
      items << item
      @items_weight += item.weight
      @equipped_weapon = item if item.is_a? Weapon
    end #if
  end #pick_up

  def heal(amt)
    @health += amt
    if @health > 100
      @health = 100
    end #if
  end #heal



  def heal!(amt)
    if @health > 0
       @health += amt
       if @health > 100
         @health = 100
       end #if
   else
     robot_dead_error
   end #if/else
  end #heal

  def robot_dead_error
    raise "That robot is dead!"
  end #robot_dead_error

  def equipped_weapon
    @equipped_weapon
  end #equipped_weapon

  def attack(target)
    @equipped_weapon == nil ? target.wound(5) : @equipped_weapon.hit(target)
  end #attack

  def attack!(target)
    if target.is_a? Robot
      @equipped_weapon == nil ? target.wound(5) : @equipped_weapon.hit(target)
    else
      raise "That's not a robot, mate!"
    end #if/else
  end #attack


  def move_left
    self.position[0] -= 1
  end #move_left

  def move_right
    self.position[0] += 1
  end #move_right

  def move_down
    self.position[1] -= 1
  end #move_down

  def move_up
    self.position[1] += 1
  end #move_up

end #Robot
