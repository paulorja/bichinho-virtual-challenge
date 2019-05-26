

class Game

  def start
    puts "Type pet name:"
    @pet_name = gets
    gameloop
  end

  def update

  end

  def draw
    puts "Pet: #{@pet_name}"
    puts '###############################'
    puts '#     ####### #################'
    puts '####  ######  #################'
    puts '#### ######  ##################'
    puts '#####       ###################'
    puts '###############################'
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
