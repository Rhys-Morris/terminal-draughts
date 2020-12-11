require_relative './marker'

class KingMarker < Marker
    def initialize(color)
        super(color)
        self.flag_king
    end

    def flag_king
        @king = true
    end

    def update_valid_moves(board, current_state, current_position)

        # Reset moves
        @valid_moves = []
        @jump_moves = {}

        # Check current row and index position in row
        current_row = current_position[1].to_i - 1
        cell_index = board[current_row].find_index current_position

        # Get row above and below
        row_above_index = current_row - 1
        row_below_index = current_row + 1

        row_above = row_above_index < 0 ? nil : board[row_above_index]
        row_below = row_below_index > 7 ? nil : board[row_below_index]

        # Get diagonal move positions
        left_index = cell_index - 1
        right_index = cell_index + 1

        if row_above && left_index >= 0
            above_left = row_above[left_index]
        end

        if row_above && right_index <= 7
            above_right = row_above[right_index]
        end

        if row_below && left_index >= 0
            below_left = row_below[left_index]
        end

        if row_below && right_index <= 7
            below_right = row_below[right_index]
        end

        # Check if cell is empty and a valid move
        if above_left && current_state[above_left] == nil
            @valid_moves << above_left
        end

        if above_right && current_state[above_right] == nil
            @valid_moves << above_right
        end

        if below_left && current_state[below_left] == nil
            @valid_moves << below_left
        end

        if below_right && current_state[below_right] == nil
            @valid_moves << below_right
        end

        # Check if cell has opposite colour and can be jumped

        puts "King marker at #{current_position} cells surrounding"
        p [above_left, above_right, below_left, below_right]

        puts "Valid moves #{@valid_moves}"
    end
end