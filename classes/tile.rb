class Tile

  attr_accessor :adjacent_count

  FLAG_ICONS = {unflagged: '*', danger: '!', uncertain: '?'}

  def initialize(has_mine)
    @has_mine = has_mine
    @status = :unflagged
    @adjacent_count = nil
  end

  def reveal
    @status = :revealed
    return @has_mine
  end

  def toggle_flag
    if @status == :revealed
      then raise "tile already revealed"
    elsif @status == :unflagged
      @status = :danger
    elsif @status == :danger
      @status = :uncertain
    elsif @status == :uncertain
      @status = :unflagged
    else
      raise "invalid status"
    end
  end

  def has_mine?
    return @has_mine
  end

  def icon
    if @status == :revealed
      return contents_icon
    elsif FLAG_ICONS[@status]
      return FLAG_ICONS[@status]
    else
      raise "invalid status: #{@status}"
    end
  end

  def contents_icon
    if @has_mine
      return 'X'
    else
      return @adjacent_count
    end
  end

end
