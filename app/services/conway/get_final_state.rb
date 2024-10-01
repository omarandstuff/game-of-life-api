class Conway::GetFinalState < BaseService
  def initialize(board_buffer, iterations:)
    width = board_buffer[0].length
    height = board_buffer.length
    @iterations = iterations
    @board = Conway::Board.new(width: width, height: height)
    @board.set_from_buffer(board_buffer.flatten)
  end

  def call
    @iterations.times do
      previous_state = @board.as_json
      @board.next_tick
      next_state = @board.as_json

      return next_state if previous_state == next_state
    end

    nil
  end
end
