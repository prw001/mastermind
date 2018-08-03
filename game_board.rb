class GameBoard
  @@colors = ['r', 'g', 'y', 'b', 'c', 'p']
  attr_reader :guess_slots
  attr_reader :secret_code
  attr_reader :hint_slots
  def initialize(secret_code)
    @gameOver = false
    @guess_slots = loadSlots()
    @hint_slots = loadSlots()
    @secret_code = secret_code
  end

  def colorCode
    color_code = []
    @secret_code.each do |color|
      color_code.push(addColor(color))
    end
    return color_code
  end

  def addColor(char)
    case char
    when 'r'
      return "r".red
    when 'g'
      return "g".green
    when 'y'
      return "y".yellow
    when 'b'
      return "b".blue
    when 'p'
      return "p".pink
    when 'c'
      return "c".light_blue
    else
      return char
    end
  end

  def displayBoard
    hint_index = 0
    current_line = ''
    puts "________________._______"
    @guess_slots.each do |slot|
      current_line = '|  '
      slot.each do |guess|
        if guess == '-'
          current_line += '-  '
        else
          current_line += addColor(guess) + '  '
        end
      end
      current_line += ' |   ' + @hint_slots[hint_index][0].to_s +
                      ' ' + @hint_slots[hint_index][1].to_s + " | Round #{(hint_index + 1).to_s}\n" +
                      "|...............|   " + @hint_slots[hint_index][2].to_s + ' ' +
                      @hint_slots[hint_index][3].to_s + " |"
      puts current_line
      hint_index += 1
      puts "________________|_______|"
    end
  end

  def addSequence(sequence, turn)
    sequence.each do |guess|
      @guess_slots[turn-1].push(guess)
    end
    @guess_slots[turn-1].slice!(0, 4)
  end

  def guessedRight(guess)
    if guess == @secret_code
      @gameOver = true
      return true
    else
      return false
    end
  end

  def gameOver
    return @gameOver
  end

  def updateHints(sequence, turn)
    sequence_index = 0
    code_copy = []
    @secret_code.each do |color|
      code_copy.push(color)
    end
    while sequence_index < code_copy.length #check position and color match
      if code_copy[sequence_index] == sequence[sequence_index]
        @hint_slots[turn - 1].push("+".red)
        code_copy.slice!(sequence_index, 1)
        sequence.slice!(sequence_index, 1)
      else
        sequence_index += 1 #only increment if arrays are not modified
      end
    end
    @@colors.each do |color| #check color and NOT position match
      if (code_copy.include? color) && (sequence.include? color)
        if sequence.count(color) <= code_copy.count(color) 
          sequence.count(color).times do
            @hint_slots[turn-1].push("o".blue)
          end
        else
          code_copy.count(color).times do
            @hint_slots[turn-1].push("o".blue)
          end
        end
      end
    end
    @hint_slots[turn-1].reverse!
    @hint_slots[turn-1] = @hint_slots[turn-1].slice(0, 4)
  end

  private

  def loadSlots
    slots = []
    i = 0
    while i < 12
      slots.push(['-','-','-','-'])
      i += 1
    end
    return slots
  end
end