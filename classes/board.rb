class Board

  TILE_AND_MINE_COUNTS = {
    small: {mines: 10, board_size: [9, 9]},
    medium: {mines: 40, board_size: [16, 16]},
    large: {mines: 99, board_size: [16, 30]}
  }

  def initialize(difficulty)
    tile_and_mine_counts = TILE_AND_MINE_COUNTS[:difficulty]
    @total_mines = tile_and_mine_counts[:mines]
    @board = Array.new

    row_count = tile_and_mine_counts[:board_size][1]
    column_count = tile_and_mine_counts[:board_size][0]

    mine_placements = place_mines(tile_and_mine_counts)

    for r in (0...row_count) do
      row = Array.new
      for c in (0...column_count) do
        has_mine = mine_placements.any? {|pl| pl == [r, c]}
        row.push(Tile.new(has_mine))
      end
      @board << row
    end
  end

  def place_mines(tile_and_mine_counts)
    total_mines = tile_and_mine_counts[:mines]
    unplaced_mines = total_mines
    row_count = tile_and_mine_counts[:board_size][1]
    column_count = tile_and_mine_counts[:board_size][0]

    mine_placements = []

    until (unplaced_mines == 0) do
      placement = [(rand(row_count) - 1), (rand(column_count) - 1)]
      unless mine_placements.any? {|pl| pl == placement}
        mine_placements << placement
        unplaced_mines -= 1
      end
    end

    return mine_placements
  end

end
