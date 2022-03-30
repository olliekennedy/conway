# @param {Integer[][]} board
# @return {Void} Do not return anything, modify board in-place instead.
def game_of_life(board)
  width, height = board[0].length, board.length
  live_cells = []
  board.each_with_index do |y, j|
    y.each_with_index do |x, i|
      live_cells << [i, j] if x == 1
    end
  end

  puts "live_cells = #{live_cells.inspect}"

  neighbours = [
    [-1, -1], [0, -1], [1, -1],
    [-1,  0],          [1,  0],
    [-1,  1], [0,  1], [1,  1]
  ]

  new_live_cells = []

  (0...height).each do |y|
    (0...width).each do |x|
      living_neighbours = neighbours.count { |i, j| live_cells.include?([x + i, y + j]) }
      if (live_cells.include?([x, y]) && living_neighbours.between?(2, 3)) or (!live_cells.include?([x, y]) && living_neighbours == 3)
        new_live_cells << [x, y]
      end
    end
  end

  puts "new_live_cells = #{new_live_cells.inspect}"
  puts "old board = #{board.inspect}"

  board.each_with_index do |y, j|
    y.each_with_index do |_, i|
      if new_live_cells.include?([i, j])
        board[j][i] = 1
      else
        board[j][i] = 0
      end
    end
  end
end
