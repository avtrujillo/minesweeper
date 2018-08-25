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

  def flag
    case @status
    when :revealed
      raise "tile already revealed"
    when :unflagged
      @status = :flagged
    when :flagged
      @status = :danger
    when :danger
      @status = uncertain
    when :uncertain
      @status = unflagged
    else
      raise "invalid status"
    end
  end

  def has_mine?
    return @has_mine
  end

  def icon
    case @status
    when :revealed
      return contents_icon
    when :danger
    when :unflagged
    when :uncertain
      return FLAG_ICONS[@status]
    else
      raise 'invalid status'
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
