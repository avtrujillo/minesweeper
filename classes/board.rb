class Board

  TILE_AND_MINE_COUNTS = {
    small: {mines: 10, board_size: [9, 9]},
    medium: {mines: 40, board_size: [16, 16]},
    large: {mines: 99, board_size: [16, 30]}
  }

  def initialize(difficulty)
    tile_and_mine_counts = TILE_AND_MINE_COUNTS[difficulty]
    @total_mines = tile_and_mine_counts[:mines]
    @board = Array.new

    @row_count = tile_and_mine_counts[:board_size][1]
    @column_count = tile_and_mine_counts[:board_size][0]

    mine_placements = place_mines(tile_and_mine_counts)

    for r in (0...@row_count) do
      row = Array.new
      for c in (0...@column_count) do
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

  def adjacent_count(row_coor, column_coor)
    final_count = 0
    tile = @board[row_coor][column_coor]
    raise 'tile not found' unless tile
    if tile.adjacent_count
      return tile.adjacent_count
    else
      [-1, 0, 1].each do |row_offset|
        [-1, 0, 1].each do |column_offset|
          unless (row_offset == 0) && (column_offset == 0)
            if @board[row_coor + row_offset]
              adjacent_tile = @board[row_coor + row_offset][column_coor + column_offset]
            end
            final_count += 1 if adjacent_tile && adjacent_tile.has_mine?
          end
        end
      end
    end
    tile.adjacent_count = final_count
  end

  VERTICAL_BAR = '-----------------------'

  def display
    @board.each_with_index do |row, row_index|
      puts VERTICAL_BAR
      row.each_with_index do |tile, column_index|
        print '|'
        if tile.icon.nil?
          print adjacent_count(row_index, column_index).to_s
        else
          print tile.icon
        end
      end
      puts '|'
    end
    puts VERTICAL_BAR
  end

end
