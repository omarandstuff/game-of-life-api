class BoardsController < ApplicationController
  def show
    render json: { state: JSON.parse(board.current_state) }
  end

  def create
    board = Board.create(initial_state: board_params[:state], current_state: board_params[:state])
    render json: { id: board.id }, status: :created
  end

  def update
    current_state = JSON.parse(board.current_state)
    next_state = Conway::GetNextState.call(current_state)

    board.update(current_state: next_state.to_json)

    render json: { state: next_state }
  end

  def next
    current_state = JSON.parse(board.current_state)
    next_state = Conway::GetNextState.call(current_state, iterations: iterations)

    render json: { state: next_state }
  end

  def final
    current_state = JSON.parse(board.current_state)
    final_state = Conway::GetFinalState.call(current_state, iterations: iterations)

    if final_state
      render json: { state: final_state }
    else
      render json: { error: 'Unable to stabilize within the limit' }, status: :unprocessable_entity
    end
  end

  private

  def board_params
    params.require(:board).permit(:state)
  end

  def board
    @board ||= Board.find(params[:id])
  end

  def iterations
    params[:iterations].to_i.positive? ? params[:iterations].to_i : default_final_state_iterations
  end

  def default_final_state_iterations
    100
  end
end
