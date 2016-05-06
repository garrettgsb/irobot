```
This file was just made to test out the range-finding methods
which would eventually allow me to implement Grenades, and maybe
other ranged weapons.

It just checks to see whether or not the range value (hard-coded
in this file, passed by @equipped_weapon in the actual Robot class)
is greater than the distance between BOTH the X and Y coordinates.

Normally, this would let you attack diagonally. I didn't want that,
so I also wrote a check to make sure that the two units are parallel
on one axis before the range check is allowed to take place. If
they're not parallel, then we just return false right away.
```
class Rangebot

  attr_accessor :position, :range

  def initialize(position=[0,0], range=1)
    @position = position
    @range = range
  end

  def parallel?(target)
    self.position[0] == target.position[0] || self.position[1] == target.position[1]
  end #parallel

  def range?(target)
    if parallel?(target)
      self.range >= (self.position[0]-target.position[0]).abs && self.range >= (self.position[1]-target.position[1]).abs
    else
      false
    end

  end

end #Rangebot
