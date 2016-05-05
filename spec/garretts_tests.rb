require_relative 'spec_helper'

describe Robot do

  before :each do
    @robot = Robot.new
  end

  describe '#heal!' do

    it 'heals the robot for 20 points' do
      @robot.wound(50)
      @robot.heal!(20)
      expect(@robot.health).to eq(70)
    end #it

    it 'raises runtime error if target health is 0' do
      @robot.wound(1000)
      expect(@robot.health).to eq(0)
      # @robot.heal!(10)
      expect{@robot.heal!(10)}.to raise_error
    end #it

  end # describe #heal!




  describe '#attack!' do
    before :each do
      @robot = Robot.new
      @other_robot = Robot.new
      @box = BoxOfBolts.new
    end
    it 'passes wound(5) when given 5' do
      expect(@other_robot).to receive(:wound).with(5)
      @robot.attack!(@other_robot)
    end #it

  it 'does not call wound() if target is not a Robot' do
    expect{@robot.attack!(@box)}.to raise_error
  end #it

  end #describe #attack!

end # describe Robot
