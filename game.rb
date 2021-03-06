require_relative 'board'
require_relative 'player'

class ChessGame
  attr_reader :board, :display, :players, :curr_player

  def initialize
    @board = Board.new
    @display = Display.new(@board)
    @players = {
      :black => HumanPlayer.new(:black, @display),
      :white => HumanPlayer.new(:white, @display)
    }
    @curr_player = :white
  end

  def play
    until @board.check_mate?(curr_player)
      begin
        start_pos, end_pos = players[curr_player].make_move(board)
        board.move(curr_player, start_pos, end_pos)
        rotate_curr_player!
      rescue Exception => e
        puts "Couldn't make the move!"
        puts e.message
        sleep(3)
        retry
      end
    end
    rotate_curr_player!
    puts "#{@curr_player} wins!"
  end

  private

  def rotate_curr_player!
    @curr_player = (@curr_player == :white) ? :black : :white
  end
end

if __FILE__ == $PROGRAM_NAME
  ChessGame.new.play
end
