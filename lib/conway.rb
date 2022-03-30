class Board
  attr_reader :live_cells

  NEIGHBOURS = [[-1, -1], [0, -1], [+1, -1],
                [-1,  0],          [+1,  0],
                [-1, +1], [0, +1], [+1, +1]]

  def initialize(width: 20, height: 20, live_cells: [])
    @width, @height, @live_cells = width, height, live_cells.sort
  end

  def evolve(evolutions = 1)
    evolutions.times do
      @live_cells = all_neighbours.select { |x, y| should_it_live?(cell_alive?(x, y), live_neighbours(x, y)) }.sort
      show
    end
  end

  def all_neighbours
    @live_cells |
      @live_cells.each.with_object([]) { |(x, y), object| NEIGHBOURS.each { |dx, dy| object << [x + dx, y + dy] } }
  end

  def cell_alive?(x, y) = @live_cells.include?([x, y])

  def live_neighbours(x, y) = NEIGHBOURS.count { |dx, dy| cell_alive?(x + dx, y + dy) }

  def should_it_live?(alive, live_neighbours)
    (alive and live_neighbours.between?(2, 3)) or (!alive and live_neighbours == 3)
  end

  def show
    puts "\e[2J\e[0;0H"; @height.times { |j| @width.times { |i| print cell_alive?(i, j) ? "█▉" : "  " }; puts }
  end
end
