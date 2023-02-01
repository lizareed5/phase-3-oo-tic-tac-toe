require 'pry'
class TicTacToe
    attr_accessor :board

    def initialize
        self.board = [" ", " ", " ", " ", " ", " ", " ", " ", " "]
    end

    WIN_COMBINATIONS = [
        [0,1,2],
        [3,4,5],
        [6,7,8],
        [0,3,6],
        [1,4,7],
        [2,5,8],
        [0,4,8],
        [2,4,6]
    ]

    def display_board
        puts " #{self.board[0]} | #{self.board[1]} | #{self.board[2]} "
        puts "-----------"
        puts " #{self.board[3]} | #{self.board[4]} | #{self.board[5]} "
        puts "-----------"
        puts " #{self.board[6]} | #{self.board[7]} | #{self.board[8]} "
    end

    def input_to_index user_input
        user_input.to_i - 1
    end

    def move index, token #= "X"
        self.board[index] = token
    end

    def position_taken? index
        self.board[index] != " "
    end

    def valid_move? index
        !position_taken?(index) && index.between?(0,8)
        # !position_taken?(index) && index >= 0 && index <= 8
    end

    def turn_count
        self.board.count("X") + self.board.count("O")
    end

    def current_player
        turn_count.even? ? "X" : "O"
    end

    def turn
        puts "Please enter a number (1-9):"
        input = gets.strip
        index = input_to_index(input)
        if valid_move?(index)
            token = current_player
            move(index, token)
            display_board
        else
            turn
        end
    end

    def won?
        WIN_COMBINATIONS.detect do |combo|
            if self.board[combo[0]] == self.board[combo[1]] &&
                board[combo[1]] == self.board[combo[2]] &&
                position_taken?(combo[0])
                return combo
            end
        end
    end

    def full?
        self.board.all? do |index|
            index != " "
        end
    end

    def draw?
        full? && !won?
    end

    def over?
        won? || draw?
    end

    def winner
        won? ? self.board[won?[0]] : nil
    end

    def play
        while over? == false
            turn
        end
        if winner != nil
            puts "Congratulations #{winner}!"
        else
            puts "Cat's Game!"
        end
    end

end

# binding.pry