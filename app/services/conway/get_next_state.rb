class Conway::GetNextState < BaseService
  def initialize(board_buffer, iterations: 1)
    width = board_buffer[0].length
    height = board_buffer.length
    @iterations = iterations
    @board = Conway::Board.new(width: width, height: height)
    @board.set_from_buffer(board_buffer.flatten)
  end

  def call
    @iterations.times do
      @board.next_tick
    end

    @board.as_json
  end
end
