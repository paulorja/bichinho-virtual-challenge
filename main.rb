# coding: utf-8
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
      up
      @cooldown = @time
    end
  end

  def up
    @cooldown = @time
    @phase += 1 if @phase < 4
  end

  def down
    @cooldown = @time
    @phase -= 1 if @phase > 0
  end

end


class Pet

  attr_reader :name, :necessities, :dead, :lifetime

  def initialize(pet_name)
    @lifetime = 0
    @message = nil
    @name = pet_name
    @dead = false
    @necessities = [
      Necessity.new(30, "Fome"),
      Necessity.new(10, "Diversão"),
      Necessity.new(50, "Higiêne")
    ]
  end

  def die
    @dead = true
  end

  def alimentar
    @message = "Alimentando... +1 fome"
    4.times { @necessities[0].down }
    1.times { @necessities[2].up }
    @message
  end

  def banho
    @message = "Tomando banho... +1 banho"
    4.times { @necessities[2].down }
    @message
  end

  def brincar
    @message = "Brincando... +1 diversao"
    4.times { @necessities[1].down }
    1.times { @necessities[2].up }
    @message
  end

  def get_message
    m = @message
    @message = nil
    return m
  end

  def increment_lifetime
    @lifetime += 1
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

    @pet.increment_lifetime

    sum_necessities = 0

    @pet.necessities.each do |n|
      n.cooldown
      sum_necessities += n.phase
    end

    @pet.die if sum_necessities == @pet.necessities.size * 4

  end

  def draw
    system("clear")


    puts "Bichinho: #{@pet.name}"
    puts "Tempo de vida: #{@pet.lifetime}"

    necessities_line = ""
    @pet.necessities.each do |n|
      necessities_line += "#{n.name}: #{n.phase}  "
    end
    puts necessities_line


    if @pet.dead
      puts "O bichinho morreu."
    else
      puts "1 - Alimentar \n2 - Brincar \n3 - Dar banho\n0 - Sair"
      puts @pet.get_message
    end

  end

  def gameloop
    update
    draw

    unless @pet.dead
      m = ""
      begin
        frame_time = Time.now.to_f
        Timeout.timeout 1 do
          option = $stdin.getch
          case option
          when "0"
            exit!
          when "1"
            m = @pet.alimentar
          when "2"
            m = @pet.brincar
          when "3"
            m = @pet.banho
          end
        end
      ensure
        diff = Time.now.to_f - frame_time
        if diff < 1
          puts m
          puts "Aguarde.."
          sleep diff
        end
        gameloop
      end
    end

  end

end

game = Game.new
game.start

