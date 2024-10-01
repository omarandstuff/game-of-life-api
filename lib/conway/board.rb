# frozen_string_literal: true

class Conway::Board
  attr_reader :width
  attr_reader :height

  def initialize(width:, height:)
    @width = width
    @height = height
    @swap_chain_buffer_a = Array.new(width * height, 0)
    @swap_chain_buffer_b = Array.new(width * height, 0)
    @current_buffer = @swap_chain_buffer_a
    @next_buffer = @swap_chain_buffer_b
  end

  def set_random
    @current_buffer = @swap_chain_buffer_a
    @next_buffer = @swap_chain_buffer_b
    @current_buffer.collect! { [0, 1].sample }
  end

  def set_from_buffer(buffer)
    @swap_chain_buffer_a = buffer.clone
    @swap_chain_buffer_b = buffer.clone
    @current_buffer = @swap_chain_buffer_a
    @next_buffer = @swap_chain_buffer_b
  end

  def next_tick
    for y in 0...@height
      for x in 0...@width
        neightbor_count = get_neightbor_count(x, y)
        current_index = y * @width + x
        currently_alive = @current_buffer[current_index]

        if currently_alive == 1
          alive = neightbor_count == 2 || neightbor_count == 3 ? 1 : 0
        else
          alive = neightbor_count == 3 ? 1 : 0
        end

        @next_buffer[y * @width + x] = alive
      end
    end

    # Swap chain
    last_buffer = @current_buffer
    @current_buffer = @next_buffer
    @next_buffer = last_buffer
  end

  def as_buffer
    @current_buffer.clone
  end

  def as_json
    @current_buffer.each_slice(@width).to_a
  end

  private

  def get_neightbor_count(x, y)
    top_y = y == 0 ? @height - 1 : y - 1
    bottom_y = y == @height - 1 ? 0 : y + 1
    left_x = x == 0 ? @width - 1 : x - 1
    right_x = x == @width - 1 ? 0 : x + 1

    top_left_index = top_y * @width + left_x
    top_index = top_y * @width + x
    top_right_index = top_y * @width + right_x
    left_index = y * @width + left_x
    right_index = y * @width + right_x
    bottom_left_index = bottom_y * @width + left_x
    bottom_index = bottom_y * @width + x
    bottom_right_index = bottom_y * @width + right_x

    top_left_cell = @current_buffer[top_left_index]
    top_cell = @current_buffer[top_index]
    top_right_cell =  @current_buffer[top_right_index]
    left_cell = @current_buffer[left_index]
    right_cell = @current_buffer[right_index]
    bottom_left_cell = @current_buffer[bottom_left_index]
    bottom_cell = @current_buffer[bottom_index]
    bottom_right_cell = @current_buffer[bottom_right_index]

    return top_left_cell +
      top_cell +
      top_right_cell +
      left_cell +
      right_cell +
      bottom_left_cell +
      bottom_cell +
      bottom_right_cell
  end
end
