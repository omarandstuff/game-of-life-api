class Board < ApplicationRecord
  validates :initial_state, presence: true
end
