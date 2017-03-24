class TicTacToe
  def initialize(board = nil)
      @board = board || Array.new(9, " ")
  end

  # Define your WIN_COMBINATIONS constant
  WIN_COMBINATIONS = [
    [0,4,8],
    [2,4,6],
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player)
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def valid_move?(index)
    index.between?(0,8) && !position_taken?(index)
  end

  def turn
    puts "Please enter 1-9:"
    user_input = gets.strip
    index = input_to_index(user_input)
    player = current_player
    if valid_move?(index)
      move(index, player)
      display_board
    else
      turn
    end
  end

  def turn_count
    counter = 0
    @board.each do |space|
      if space == "X" || space =="O"
        counter += 1
      end
    end
    return counter
  end

  def current_player
    count = turn_count
    if count % 2 == 0
      current_player = "X"
    elsif count % 2 == 1
      current_player = "O"
    end
    return current_player
  end

  def won?
    # win_combination is a 3 element array of indexes that compose a win, [0,1,2]
    # grab each index from the win_combination that composes a win.

    game_won = WIN_COMBINATIONS.any? do |win_combination|
        win_x = win_combination.all? do |i|
          @board[i] == "X"
        end

        win_o = win_combination.all? do |i|
          @board[i] == "O"
        end

        if win_x || win_o
          return win_combination
        end
    end

    return game_won

  end

  def full?
  #accept a board and return true if every element in the board contains either an "X" or an "O"
      @board.all? do |position|
          position == "X" || position == "O"
      end
  end

  def draw?
  #returns true if the board has not been won and is full
  #returns false if the board is not won and the board is not full, and false if the board is won
    !won? && full?
  end

  def over?
  #returns true if the board has been won, is a draw, or is full
    won? || draw?
  end

  def winner
    if won? != false
        return @board[won?[0]]
    end
  end

  def play

    while !over?
        turn
    end

    if over?
      if won?
        puts "Congratulations #{winner}!"
      elsif draw?
        puts "Cat's Game!"
      end
    end

  end

end
