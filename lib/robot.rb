class Robot

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
      items << item
      @items_weight += item.weight
      @equipped_weapon = item if item.is_a? Weapon
      item.feed(self) if item.is_a?(BoxOfBolts) && (health <= 80)
      #auto_heal(item)
    end #if
  end #pick_up

  def auto_heal(item)
     if @health <= 80 && item.is_a?(BoxOfBolts)
       #me = self
       item.feed(self)
     end #if
   end #auto_heal

  def equipped_weapon
    @equipped_weapon
  end #equipped_weapon


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
    if adjacent?(target)
      @equipped_weapon == nil ? target.wound(5) : @equipped_weapon.hit(target)
    end #if/else
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

  def adjacent?(target) #let [0] be horizontal, and [1] be vertical
    return true if (horiz_parallel?(target) && vert_adjacent?(target)) || (vert_parallel?(target) && horiz_adjacent?(target)) || (vert_parallel?(target) && horiz_parallel?(target))
    false
  end #check_adjacent

  def horiz_parallel?(target)
    t = target.position
    @position[0] == t[0]
  end #horiz_adjacent?

  def vert_parallel?(target)
    t = target.position
    @position[1] == t[1]
  end #vert_adjacent?

  def horiz_adjacent?(target)
    t = target.position
    (t[0] == (@position[0] + 1)) || (t[0] == (@position[0] - 1))
  end

  def vert_adjacent?(target)
    t = target.position
    (t[1] == (@position[1] + 1)) || (t[1] == (@position[1] - 1))
  end

end #Robot
