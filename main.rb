
class Necessity

  attr_reader :name, :phase

  def initialize(time, name)
    @phase = 0
    @time = time
    @cooldown = time
    @name = name
  end

  def cooldown
    @cooldown -= 1
    if @cooldown == 0
      up
      @cooldown = @time
    end
  end

  def up
    @phase += 1 if @phase < 4

  end

  def down
    @phase -= 1 if @phase > 0
  end

end


class Pet

  attr_reader :name, :necessities

  def initialize(pet_name)
    @name = pet_name
    @necessities = [
      Necessity.new(30, "Hunger"),
      Necessity.new(10, "Fun"),
      Necessity.new(50, "Hygiene")
    ]
  end

end


class Game

  def start
    puts "Type pet name:"
    @pet = Pet.new(gets)
    gameloop
  end

  def update
    @pet.necessities.each do |n|
      n.cooldown
    end
  end

  def draw
    puts "Pet: #{@pet.name}"

    necessities_line = ""
    @pet.necessities.each do |n|
      necessities_line += "#{n.name}: #{n.phase}  "
    end
    puts necessities_line

  end

  def gameloop
    system("clear")

    update
    draw

    sleep 1

    gameloop
  end

end


game = Game.new
game.start
