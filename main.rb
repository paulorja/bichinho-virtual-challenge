require 'io/console'
require 'byebug'
require 'timeout'


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
      puts "#{name} subiu um ponto"
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
    @message = nil
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

  def alimentar
    @message = "Alimentando... +1 fome"
  end

  def banho
    @message = "Tomando banho... +1 banho"
  end

  def brincar
    @message = "Brincando... +1 diversao"
  end

  def get_message
    m = @message
    @message = nil
    return m
  end

end


class Game

  def start
    puts "Type pet name:"
    @pet = Pet.new(gets)
    @input = nil
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
    system("clear")


    puts "Pet: #{@pet.name}"

    necessities_line = ""
    @pet.necessities.each do |n|
      necessities_line += "#{n.name}: #{n.phase}  "
    end
    puts necessities_line


    if @pet.dead
      puts "The pet died."
    else
      puts "1 - Alimentar \n2 - Brincar \n3 - Dar banho\n0 - Sair"
      puts @pet.get_message
    end

  end

  def gameloop
    update
    draw

    begin
      Timeout.timeout 0.3 do
        option = $stdin.getch
        case option
        when "0"
          exit
        when "1"
          @pet.alimentar
        when "2"
          @pet.brincar
        when "3"
          @pet.banho
        end
        gameloop
      end
    rescue
      sleep 0.3
      gameloop
    end

  end

end

game = Game.new
game.start

