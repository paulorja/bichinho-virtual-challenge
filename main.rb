

def update

end

def draw

end

def gameloop

  update
  draw

  system("clear")
  sleep 1

  gameloop
end

gameloop
