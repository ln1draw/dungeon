class Dungeon
  attr_accessor :player

  def initialize(player_name)
    @player = Player.new(player_name)
    @rooms = []
  end

  def add_room(reference, name, description, connections)
    @rooms << Room.new(reference, name, description, connections)
  end

  def start(location)
    @player.location = location
    show_current_description
  end

  def show_current_description
    puts find_room_in_dungeon(@player.location).full_description
  end

  def find_room_in_dungeon(reference)
    @rooms.detect{|room| room.reference == reference}    
  end

  def find_room_in_direction(direction)
    room = find_room_in_dungeon(@player.location).connections[direction]
    if room == nil
      @player.location
    else
      room
    end
  end

  def go(direction)
    if direction == "east"
      direction = :east
    elsif direction == "west"
      direction = :west
    else
      puts "You can't go that way!"
    end
    puts "You go " + direction.to_s
    @player.location = find_room_in_direction(direction)
    show_current_description
  end

  class Player
    attr_accessor :name, :location

    def initialize(name)
      @name=name
    end
  end


  class Room
    attr_accessor :reference, :name, :description, :connections

    def initialize(reference, name, description, connections)
      @reference = reference
      @name = name
      @description = description
      @connections = connections
    end

    def full_description
        @name + "\n\nYou are in " + @description
    end
  end
end

 
my_dungeon = Dungeon.new("Fred Bloggs")
my_dungeon.add_room(:largecave, "Large Cave", "EPICALLY large cave", {:west => :smallcave})
my_dungeon.add_room(:smallcave, "Small Cave", "This cave is teeny-tiny", {:east => :largecave})

my_dungeon.start(:largecave)
want_to_play = true
  
while want_to_play

  puts "type in a command, or type 'quit' to quit"
  prompt = gets.downcase.chomp
  if prompt=="quit" or prompt == "q"
    want_to_play=false
  else 
    prompt = prompt.split(" ")
    verb = prompt[0]
    noun = prompt[1]
    case verb
    when "go" then my_dungeon.go(noun)
    end
  end
end

