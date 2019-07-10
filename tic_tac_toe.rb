class Player
  attr_reader :name, :positions, :mark

  def initialize(name, mark)
  	@name = name
  	@mark = mark
  	@positions = []
  end

  def add_position(position)
  	@positions << position
  end
end

class Board
  attr_reader :roundWon

  WINS = [[3,5,7],[2,5,8],[1,5,9],[4,5,6],[1,2,3],[7,8,9],[1,4,7],[3,6,9]]

  def initialize
  	@roundWon = false
    @board_tiles = [["-", "-", "-"],["-", "-", "-"],["-", "-", "-"]]
    @positions = {"1"=>"00", "2"=>"01", "3"=>"02", 
    			  "4"=>"10", "5"=>"11", "6"=>"12", 
    			  "7"=>"20", "8"=>"21", "9"=>"22"}	
  end	

  def set_tile(position, player)
  	position_tile = @positions[position.to_s].split('')
  	if @board_tiles[position_tile[0].to_i][position_tile[1].to_i] == '-'
  	  @board_tiles[position_tile[0].to_i][position_tile[1].to_i] = player.mark
  	  show_tiles
  	  player.add_position(position.to_i)
  	  win?(player)
  	else
  	  return puts "Illegal move"
  	end
  end

  private

  def show_tiles
  	3.times do |i|
  	  puts @board_tiles[i].join
  	end
  end

  def win?(player)
	for combination in WINS
  	  if (combination - player.positions).empty?
    	puts "#{player.name} wins!"
    	@roundWon = true
  	  end	
    end
  end
end

class Game
  def initialize
  	new_round
  end

  def enter_player
  	puts "Please enter your name: "
  	name = gets.chomp
    puts "Please enter x or o"
  	value = gets.chomp
  	Player.new(name, value)
  end

  def play
  	while @board.roundWon == false
  	  turn(@playerOne)
  	  break if @board.roundWon
  	  turn(@playerTwo)
    end
    puts
    puts "New game!"
    new_round
  end

  def new_round
  	@playerOne = enter_player
  	@playerTwo = enter_player
  	@board = Board.new
  	play
  end

  private

  def turn(player)
  	puts "#{player.name} tile position: "
  	@position = gets.chomp
  	@board.set_tile(@position, player)
  end
end

=begin
board = Board.new
playerOne = Player.new("Gareth", "x")
playerTwo = Player.new("Harry", "o")

board.set_tile(3, playerOne)
board.set_tile(1, playerOne)
board.set_tile(2, playerTwo)
board.set_tile(6, playerOne)
board.set_tile(9, playerOne)
board.show_tiles
=end