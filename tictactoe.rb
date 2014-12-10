#  2 players, 1 board (9 cells - 3 rows, 3 columns)
#  create the board with a hash to store the cells' information
#  identify method to display the board on the screen with puts
#  create 2 classes Board and Player to work with separately
#  ask for players' input with gets.chomp and assign the marks X / O
#  display the board on the screen with draw_board method that's been identified
#  players take turns to make a move (how to make them take turns? rand?)
#  figuring out when / how the game ends:
#     player1 wins or player2 wins (3 X's / 3 O's in a row or diagonally)
#     8 possible combinations to win (3 in a row, 3 down, 2 diagonally) -> loop?
#     check to see if win combination was made
#     if no one wins end the game and ask to start over
#  make sure the users' input is correct (print an error message if not):
#    i.e. number of the cell doesn't exist (cells on the board) / cell is taken
#  make sure to draw_board after every input so players can see where to move
#  create new class Gameplay (running draw_board, welcome, players in it)


# ---- The Code ----


# Board: creating a new class to store methods for the game board
# initialize method creates a hash that stores the info for the board cells 

class Board
	attr_accessor :board
	def initialize 
		@board = {
			"a1"=> "a1", "a2"=> "a2",  "a3"=> "a3",
			"b1"=> "b1", "b2"=> "b2",  "b3"=> "b3",
			"c1"=> "c1", "c2"=> "c2",  "c3"=> "c3"
		}	
	end

	# method that draws the board on the screen
	def draw_board
		puts "#{@board["a1"]} | #{@board["a2"]} | #{@board["a3"]}"
		puts "-----------"
		puts "#{@board["b1"]} | #{@board["b2"]} | #{@board["b3"]}"
		puts "-----------"
		puts "#{@board["c1"]} | #{@board["c2"]} | #{@board["c3"]}"
	end
end

# Player: creating a new class to store / create new methods related to players
# using initialize to create the player attributes as instance variables
# (i used written out set and get methods for name and mark at first
# but decided to use attr_accessor instead b/c shorter / easier)

class Player
	attr_accessor :name, :mark
	def initialize
		@name = name
		@mark = mark
	end
end

# Gameplay: creating a new class for the actual process of the game (storing new methods)
# using initialize method to access the instance variables
# creating objects within objects

class Gameplay
	def initialize
		@b = Board.new
		@player1 = Player.new
		@player2 = Player.new
		@current_turn = 0
	end

	# running 4 different methods defined below
	def play
		welcome
		ask_name
		ask_name2 
		ask_input
		turns
	end

	def welcome
	# Welcome screen (new method)
		puts "Would you like to play? (Yes / No)"
		answer = gets.chomp.capitalize # asking for user's input and capitalize it
		if answer == "Yes" # writing a condition to define what happens with different inputs
		 	puts "Let's do this!"
		 	puts ""
		elsif answer == "No"
		 	puts "Bye-bye!"
		 	exit # exiting the program if user doesn't want to play
		else
	 		puts "Please answer Yes or No."
	 		welcome # repeats the method if the input is something else rather than yes/no
	 	end
	end

	# asking for users' input (name) and assigning them their marks X and O
	def ask_name
		puts "Player 1, what's your name?"
		@player1.name = gets.chomp.capitalize
		@player1.mark = "X" 
		if @player1.name.nil?
			ask_name
		else
			puts "Hello #{@player1.name}, welcome to the game! You will be #{@player1.mark}."
			puts ""
		end
	end

	def ask_name2
		puts "Player 2, what's your name?"
		@player2.name = gets.chomp.capitalize!
		@player2.mark = "O"
		if @player2.name.nil?
			ask_name2
		else
			puts "Hello #{@player2.name}, welcome to the game! You will be #{@player2.mark}."
			puts ""
			puts "Let's begin!"
		end
	end

	# trying to ask for the move input and replace the number on the board with X or O
	def ask_input
		puts "Take a look at the board, please."
		@b.draw_board
		puts "#{@player1.name}, make your move please (pick a cell number)."
		move = gets.chomp

		if move == "a1"
		 	@b.board[move] = @player1.mark
		 	@b.draw_board
		 	taking_turns
		 	
		# elsif move == "a2"
		# 	@b.board[move] = @player1.mark
		# 	@b.draw_board
		# 	ask_input
		# elsif move == "a3"
		# 	@b.board[move] = @player1.mark
		# 	@b.draw_board
		# 	ask_input
		 end
	end

	def taking_turns
		@current_turn.even? ? turns.player1 : turns.player2
	end

	def turns(player)
		whos_turn
		if check_if_taken == true
			puts "Sorry, this cell is taken, please try again."
		else 
			@current_turn += 1
			taking_turns
		end
		draw_board
		check_if_won
	end

	def whos_turn
		puts "#{player.name}, it is your turn (#{player.mark})."
	end

	def win_combos
		@win =
			[[a1, a2, a3], [b1, b2, b3], [c1, c2, c3],
			[a1, b1, c1], [a2, b2, c2], [a3, b3, c3], 
			[a1, b2, c3], [a3, b2, c1]]
	end

	def check_if_won(player)
		@win.each { |x| @winner = player if x.all? { |y| @board.board[y] == player.mark } }
		#check if any of the combos in the array above is true
		#check what player the combo belongs to
		#print whether @player1.name or player2.name won 
		#check if it's a draw
	end

	# def check_if_taken
	# 	input = nil
	# 	until (0..8).include?(input)
	# 		puts "Please pick a cell on the board."
	# 		input = gets.chomp
	# 	end
	# 	input
	# 	# check if the cell the user chose is taken or not
	# 	# if it is then ask for input again
	# end

	# printing this at the very end when the outcome is either win or tie
	def gameover_print
		puts "Game over"
		puts "Would you like to play again?"
		playagain = gets.chomp.capitalize
		if playagain == "Yes"
			Gameplay
		elsif playagain == "No"
			exit
		else
			puts "Please answer Yes or No."
			gameover_print
		end
	end
end

# to create a Gameplay object called 'g'
# running the whole thing
g = Gameplay.new
g.play