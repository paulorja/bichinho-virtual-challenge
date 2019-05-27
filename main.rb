# coding: utf-8
require 'io/console'
require 'timeout'


class Necessity

  attr_reader :name, :phase

  def initialize(time, name)
    @phase = 0
    @time = time
    @cooldown = Time.now.to_i
    @name = name
  end

  def cooldown
    if @cooldown + @time <= Time.now.to_i
      up
      @cooldown = Time.now.to_i
    end
  end

  def up
    @cooldown = Time.now.to_i
    @phase += 1 if @phase < 4
  end

  def down
    @cooldown = Time.now.to_i
    @phase -= 1 if @phase > 0
  end

end


class Pet

  attr_reader :name, :necessities, :dead

  def initialize(pet_name)
    @start_time = Time.now.to_i
    @message = nil
    @message_time = 0
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
    set_message "Alimentando..."
    4.times { @necessities[0].down }
    1.times { @necessities[2].up }
  end

  def banho
    set_message "Tomando banho..."
    4.times { @necessities[2].down }
  end

  def brincar
    set_message "Brincando..."
    4.times { @necessities[1].down }
    1.times { @necessities[2].up }
  end

  def set_message(msg)
    @message = msg
    @message_time = Time.now.to_i
  end

  def get_message
    if @message_time + 2 > Time.now.to_i
      return @message
    end
  end

  def lifetime
    Time.now.to_i - @start_time
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
      begin
        Timeout.timeout 0.1 do
          option = $stdin.getch
          case option
          when "0"
            exit!
          when "1"
            @pet.alimentar
          when "2"
            @pet.brincar
          when "3"
            @pet.banho
          end
        end
      rescue
        puts "-"
      ensure
        gameloop
      end
    end

  end

end

game = Game.new
game.start
