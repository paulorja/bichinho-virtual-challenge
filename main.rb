# coding: utf-8
require 'io/console'
require 'timeout'


class Necessity

  attr_reader :name, :phase, :message, :message_time

  def initialize(time, name)
    @phase = 0
    @time = time
    @cooldown = Time.now.to_i
    @name = name
    @message = ""
    @message_time = 0
  end

  def cooldown(doubled_increment)
    if @cooldown + @time <= Time.now.to_i
      up
      up if doubled_increment
      @cooldown = Time.now.to_i
    end
  end

  def up
    @cooldown = Time.now.to_i
    if @phase < 4
      @phase += 1
      @message = "+"
      @message_time = Time.now.to_i + 2
    end
  end

  def down
    @cooldown = Time.now.to_i
    if @phase > 0
      @phase -= 1
      @message = "-"
      @message_time = Time.now.to_i + 2
    end
  end

  def get_message
    return @message if @message_time > Time.now.to_i
  end

end


class Necessities

  attr_accessor :fome, :diversao, :higiene

  def initialize
    @fome = Necessity.new(30, "Fome")
    @diversao = Necessity.new(10, "Diversão")
    @higiene = Necessity.new(50, "Higiêne")
  end

  def doubled_increment
    return true if @fome.phase == 4 or @diversao.phase == 4 or @higiene.phase == 4
  end

  def sum
    @fome.phase + @diversao.phase + @higiene.phase
  end

  def draw
    line = ""
    all.each do |n|
      line += "#{n.name}: #{n.phase}#{n.get_message}  "
    end
    line
  end

  def all
    [@fome, @diversao, @higiene]
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
    @necessities = Necessities.new
  end

  def die
    @dead = true
  end

  def alimentar
    set_message "Alimentando..."
    4.times { @necessities.fome.down }
    1.times { @necessities.higiene.up }
  end

  def banho
    set_message "Tomando banho..."
    4.times { @necessities.higiene.down }
  end

  def brincar
    set_message "Brincando..."
    4.times { @necessities.diversao.down }
    1.times { @necessities.higiene.up }
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
    puts "Digite um nome para o bichinho:"
    @pet = Pet.new(gets)
    @input = nil
    gameloop
  end

  def update
    @pet.necessities.all.each do |n|
      n.cooldown(@pet.necessities.doubled_increment)
    end
    @pet.die if @pet.necessities.sum == 12
  end

  def draw
    system("clear")

    puts "Bichinho: #{@pet.name}"
    puts "Tempo de vida: #{@pet.lifetime}"
    puts @pet.necessities.draw


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
