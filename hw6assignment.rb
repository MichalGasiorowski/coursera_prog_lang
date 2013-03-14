# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

class MyTetris < Tetris
  # your enhancements here
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end

  def key_bindings
  	super  
    @root.bind('u', proc {@board.rotate_180}) 
    @root.bind('c', proc {cheat})
    
  end

  def cheat
    if !@board.game_over? and is_running? and @board.can_cheat?
      if @board.score < 100
        return
      else
        @board.score -= 100
        @board.can_cheat = false
      end
    end
    update_score
  end

end

class MyPiece < Piece
  # The constant All_My_Pieces should be declared here
  All_My_Pieces = All_Pieces + [rotations([[0, 0], [1, 0], [2, 0], [0, 1],[1, 1]]), # bulky-5 normal
  								#rotations([[0, 0], [-1, 0], [1, 0], [0, -1],[1, -1]]),  # bulky-5 mirror
								[[[0, 0], [-1, 0], [1, 0], [2, 0],[-2, 0]], # v-long (only needs two)
    							[[0, 0], [0, -1], [0, 1], [0, 2], [0, -2]]],
    							rotations([[0, 0], [1, 0], [0, 1]])]
  
  # your enhancements here
  Cheat_piece = [[[0, 0]]]


  def initialize (point_array, board)
    @all_rotations = point_array
    @rotation_index = (0..(@all_rotations.size-1)).to_a.sample
    @color = All_Colors.sample
    @base_position = [5, 0] # [column, row]
    @board = board
    @moved = true
  end

  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end

  def self.next_cheat_piece (board)
    MyPiece.new(Cheat_piece, board)
  end

end

class MyBoard < Board
  # your enhancements here
  def initialize (game)
    @grid = Array.new(num_rows) {Array.new(num_columns)}
    @current_block = MyPiece.next_piece(self)
    @score = 0
    @game = game
    @delay = 500
    @can_cheat = true
  end

  def score= x
    @score = x
  end

  def can_cheat?
    @can_cheat
  end

  def can_cheat= c
    @can_cheat = c
  end
  # gets the next piece
  def next_piece
    if !can_cheat?
      @current_block = MyPiece.next_cheat_piece(self)
    else
      @current_block = MyPiece.next_piece(self)
    end
    @current_pos = nil
    @can_cheat = true
  end

  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    #puts locations.size
    ss =  locations.size - 1
    (0..ss).each{|index| 
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    remove_filled
    @delay = [@delay - 2, 80].max
    
  end

  # rotates the current piece clockwise
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, 2)
    end
    draw
  end



end
