# frozen_string_literal: true

RSpec.describe Conway::Board do
  it 'can be initialized' do
    board = Conway::Board.new(width: 2, height: 2)
    expect(board.as_buffer).to eq([0, 0, 0, 0])
  end

  it 'can be set as a random' do
    board = Conway::Board.new(width: 2, height: 1)
    board.set_random

    expect(board.as_buffer).to eq([0, 0])
      .or eq([1, 0])
      .or eq([0, 1])
      .or eq([1, 1])
  end

  it 'achives the blinker' do
    board = Conway::Board.new(width: 5, height: 5)

    board.set_from_buffer([
      0, 0, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0, 0,
    ])
    board.next_tick
    expect(board.as_buffer).to eq([
      0, 0, 0, 0, 0,
      0, 0, 0, 0, 0,
      0, 1, 1, 1, 0,
      0, 0, 0, 0, 0,
      0, 0, 0, 0, 0,
    ])
    board.next_tick
    expect(board.as_buffer).to eq([
      0, 0, 0, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 1, 0, 0,
      0, 0, 0, 0, 0,
    ])
  end

  it 'achives the toad' do
    board = Conway::Board.new(width: 6, height: 6)

    board.set_from_buffer([
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0,
      0, 0, 1, 1, 1, 0,
      0, 1, 1, 1, 0, 0,
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0
    ])
    board.next_tick
    expect(board.as_buffer).to eq([
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 1, 0, 0,
      0, 1, 0, 0, 1, 0,
      0, 1, 0, 0, 1, 0,
      0, 0, 1, 0, 0, 0,
      0, 0, 0, 0, 0, 0
    ])
    board.next_tick
    expect(board.as_buffer).to eq([
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0,
      0, 0, 1, 1, 1, 0,
      0, 1, 1, 1, 0, 0,
      0, 0, 0, 0, 0, 0,
      0, 0, 0, 0, 0, 0
    ])
  end
end
