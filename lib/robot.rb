class Robot


  #@@default_weapon = Weapon.new("Default", 0, 5, 1)
  attr_accessor :position,
                :items,
                :items_weight,
                :health,
                :equipped_weapon

  def initialize
    @position = [0,0] #let [0] be horizontal, and [1] be vertical.
    @items = []
    @items_weight = 0
    @health = 100
    @equipped_weapon = nil
  end #initialize

### ITEM METHODS ###

  def pick_up(item)
    if items_weight + item.weight <= 250
      item_get(item)
      true
    end #if
  end #pick_up

  def item_get(item)
      @items << item
      @items_weight += item.weight
      @equipped_weapon = item if item.is_a? Weapon
      item.feed(self) if item.is_a?(BoxOfBolts) && (health <= 80)
  end #item_get

  def equipped_weapon
    @equipped_weapon
  end #equipped_weapon

  def consume_grenade
    if @equipped_weapon.is_a?(Grenade)
      @equipped_weapon = nil
    end #if
  end #grenade_attack


###HEALTH METHODS####

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

  def wound(amt)
    @health -= amt
    if @health < 0
        @health = 0
    end #if
  end #wound

  def robot_dead_error
    raise "That robot is dead!"
  end #robot_dead_error


### WEAPON METHODS ###

  def attack(target)
    if @equipped_weapon == nil
      if in_range?(target,1)
        target.wound(5)
      end #if
    elsif @equipped_weapon != nil && in_range?(target, @equipped_weapon.range)
      @equipped_weapon.hit(target)
      consume_grenade
    end #if/elsif
  end #attack

  def attack!(target)
    if target.is_a? Robot
      @equipped_weapon == nil ? target.wound(5) : @equipped_weapon.hit(target)
    else
      raise "That's not a robot, mate!"
    end #if/else
  end #attack


### POSITION METHODS ###

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

  def in_range?(target, range) #let [0] be horizontal, and [1] be vertical
    if parallel?(target)
      range >= (self.position[0]-target.position[0]).abs && range >= (self.position[1]-target.position[1]).abs
    else
      false
    end #if/else
  end #in_range?

  def parallel?(target)
    self.position[0] == target.position[0] || self.position[1] == target.position[1]
  end #parallel?


end #Robot



###
#Originally wrote these as "adjacent," later
#refactored to assess whether or not
#they are in range.
###

# def adjacent?(target) #let [0] be horizontal, and [1] be vertical
#   return true if (horiz_parallel?(target) && vert_adjacent?(target)) || (vert_parallel?(target) && horiz_adjacent?(target)) || (vert_parallel?(target) && horiz_parallel?(target))
#   false
# end #check_adjacent
#
# def horiz_parallel?(target)
#   t = target.position
#   @position[0] == t[0]
# end #horiz_adjacent?
#
# def vert_parallel?(target)
#   t = target.position
#   @position[1] == t[1]
# end #vert_adjacent?
#
# def horiz_adjacent?(target)
#   t = target.position
#   (t[0] == (@position[0] + 1)) || (t[0] == (@position[0] - 1))
# end
#
# def vert_adjacent?(target)
#   t = target.position
#   (t[1] == (@position[1] + 1)) || (t[1] == (@position[1] - 1))
# end


#--------------------------

# def horiz_parallel?(target)
#   t = target.position
#   @position[0] == t[0]
# end #horiz_parallel?
#
# def vert_parallel?(target)
#   t = target.position
#   @position[1] == t[1]
# end #vert_parallel?
#
# def horiz_in_range?(target, range)
#   t = target.position
#   (t[0] - @position[0]).abs <= range
# end
#
# def vert_in_range?(target, range)
#   t = target.position
#   (t[1] - @position[1]).abs <= range
# end
