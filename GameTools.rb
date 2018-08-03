module GameTools
    def numToColor(num)
    case num
    when 1
      return 'r'
    when 2
      return 'y'
    when 3
      return 'b'
    when 4
      return 'g'
    when 5
      return 'c'
    else
      return 'p'
    end
  end
end