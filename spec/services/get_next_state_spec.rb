require 'rails_helper'

RSpec.describe Conway::GetNextState, type: :service do
  let(:initial_state) {[
    [0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 1, 0, 0],
    [0, 0, 0, 0, 0]]
  }
  let(:service) { Conway::GetNextState.new(initial_state) }

  describe '#call' do
    it 'computes the next state correctly' do
      next_state = service.call
      expected_next_state = [
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0],
        [0, 1, 1, 1, 0],
        [0, 0, 0, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(next_state).to eq(expected_next_state)
    end

    it 'computes the next state correctly after x iterations' do
      service = Conway::GetNextState.new(initial_state, iterations: 2)
      next_state = service.call
      expected_next_state = [
        [0, 0, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 0, 0]
      ]

      expect(next_state).to eq(expected_next_state)
    end
  end
end
