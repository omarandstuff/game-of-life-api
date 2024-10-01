require 'rails_helper'

RSpec.describe BoardsController, type: :controller do
  describe 'GET /boards/:id' do
    let!(:board) { Board.create(initial_state: [[0, 1, 0], [1, 0, 1], [0, 1, 0]], current_state: [[0, 1, 0], [1, 0, 1], [0, 1, 0]]) }

    it 'returns the state of the board' do
      get :show, params: { id: board.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['state']).not_to be_nil
    end
  end

  describe 'POST /boards' do
    let(:valid_attributes) { { state: '[[0, 1], [1, 0]]' } }

    it 'creates a new board and returns its ID' do
      post :create, params: { board: valid_attributes }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['id']).not_to be_nil
    end
  end

  describe 'PATCH /boards/:id' do
    let!(:board) { Board.create(initial_state: [[0, 1], [1, 0]], current_state: [[0, 1], [1, 0]]) }

    it 'returns the next state of the board' do
      patch :update, params: { id: board.id }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['state']).not_to be_nil
    end
  end

  describe 'GET /boards/next' do
    let!(:board) { Board.create(initial_state: [[0, 1, 0], [1, 0, 1], [0, 1, 0]], current_state: [[0, 1, 0], [1, 0, 1], [0, 1, 0]]) }

    it 'returns what is the next state of the board' do
      get :next, params: { id: board.id }

      result_state = JSON.parse(response.body)['state']

      expect(response).to have_http_status(:ok)
      expect(result_state).to eq([[0, 1, 0], [1, 0, 1], [0, 1, 0]])
    end

    it 'returns what is the state after x iterations' do
      get :next, params: { id: board.id, iterations: 2 }

      result_state = JSON.parse(response.body)['state']

      expect(response).to have_http_status(:ok)
      expect(result_state).to eq([[0, 1, 0], [1, 0, 1], [0, 1, 0]])
    end
  end

  describe 'GET /boards/final' do
    let!(:board) { Board.create(initial_state: [[0, 1, 1], [0, 0, 1], [0, 0, 0]], current_state: [[0, 1, 1], [0, 0, 1], [0, 0, 0]]) }

    it 'returns what is the final state of the board using the default limit' do
      get :final, params: { id: board.id }

      result_state = JSON.parse(response.body)['state']

      expect(response).to have_http_status(:ok)
      expect(result_state).to eq([[0, 0, 0], [0, 0, 0], [0, 0, 0]])
    end

    it 'returns what is the final state of the board using a custom limit' do
      get :final, params: { id: board.id, iterations: 2 }

      result_state = JSON.parse(response.body)['state']

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end
end
