
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

  attr_reader :name, :necessities, :dead

  def initialize(pet_name)
    @name = pet_name
    @dead = false
    @necessities = [
      Necessity.new(30, "Hunger"),
      Necessity.new(10, "Fun"),
      Necessity.new(50, "Hygiene")
    ]
  end

  def die
    @dead = true
  end

end


class Game

  def start
    puts "Type pet name:"
    @pet = Pet.new(gets)
    gameloop
  end

  def update

    sum_necessities = 0

    @pet.necessities.each do |n|
      n.cooldown
      sum_necessities += n.phase
    end

    @pet.die if sum_necessities == @pet.necessities.size * 4

  end

  def draw
    puts "Pet: #{@pet.name}"

    necessities_line = ""
    @pet.necessities.each do |n|
      necessities_line += "#{n.name}: #{n.phase}  "
    end
    puts necessities_line

    if @pet.dead
      puts "The pet died."
    end

  end

  def gameloop
    system("clear")

    update
    draw

    sleep 0.1

    gameloop
  end

end


game = Game.new
game.start
