require 'rails_helper'

RSpec.describe Board, type: :model do
  it 'is valid with valid attributes' do
    board = Board.new(initial_state: [[0, 1], [1, 0]], current_state: [[0, 1], [1, 0]])
    expect(board).to be_valid
  end

  it 'is invalid without an initial state' do
    board = Board.new(current_state: [[0, 1], [1, 0]])
    expect(board).not_to be_valid
  end
end
