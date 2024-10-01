class CreateBoards < ActiveRecord::Migration[7.2]
  def change
    create_table :boards do |t|
      t.text :initial_state
      t.text :current_state

      t.timestamps
    end
  end
end
