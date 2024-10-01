require 'rails_helper'

RSpec.describe Conway::GetFinalState, type: :service do
  let(:initial_state) {[
    [0, 1, 1],
    [0, 0, 1],
    [0, 0, 0]]
  }
  let(:service) { Conway::GetFinalState.new(initial_state, iterations: 100) }

  describe '#call' do
    it 'computes the final state under the given limit' do
      final_state = service.call
      expected_next_state = [
        [0, 0, 0],
        [0, 0, 0],
        [0, 0, 0]
      ]

      expect(final_state).to eq(expected_next_state)
    end

    it 'return nil if the final state is not reached within the limit' do
      service = Conway::GetFinalState.new(initial_state, iterations: 2)
      final_state = service.call

      expect(final_state).to eq(nil)
    end
  end
end
