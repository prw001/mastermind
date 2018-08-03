require_relative 'GameTools.rb'

class Mastermind
  include GameTools
  @@how_to_play = "\n\nHOW TO PLAY:\n".green +
        "1. One player picks a secret code of 4 colors in a particular order.\n" +
        "2. The other player has 12 turns to guess the code\n" +
        "3. Indicators are placed to the right of each guess based on their accuracy:\n"+
        "   -Correct colors in correct position are noted by a '+'\n" +
        "   -Correct colors in wrong position are noted with an 'o'\n" +
        "   -Incorrect colors receive no notation: '-'\n" +
        "4. The guesser inputs their guesses for the turn one color at a time, left to right.\n"
        "5. The player guessing wins by guessing correctly before the end of the 12th turn.\n"
  @@turn_prompt = "Enter one of the following:\n" +
        "'b' for " + "blue".blue + ", 'r' for " + "red".red +
        ", 'g' for " + "green".green + ", 'y' for " + "yellow".yellow +
        ", 'p' for " + "pink".pink + ", or 'c' for " + "cyan".light_blue + "\n"
  @@bad_input_error = "Invalid input.  Please type one of the characters listed above."

  def initialize(mode, difficulty = nil)
    @game_board = nil
    @computer_is_master = true
    @turn = 1
    @guess = []
    @mode = mode #'c' -> computer creates the code, or 'p' -> player creates the code
    @difficulty = difficulty
  end

  def generateCode
    #computer randomly generates 4 colors, or player picks 4 colors
    code = []
    index = 1
    generate_prompt = "Secret Code slot #" 
    next_color = ''
    if @mode == 'c'
      4.times do
        code.push(numToColor(rand(1..6)))
      end
    else
      4.times do
        puts generate_prompt + index.to_s + ": "
        puts @@turn_prompt
        next_color = gets.chomp.downcase
        while bad_input(next_color)
          next_color = gets.chomp.downcase
        end
        code.push(next_color)
        index += 1
      end
    end
    return code
  end

  def bad_input(input)
    case input
    when 'r', 'g', 'y', 'b', 'p', 'c'
      return false
    else
      puts @@bad_input_error
      return true
    end
  end

  def getPlayerGuess
    guess_counter = 1
    guess = nil
    sequence = []
    while guess_counter < 5
      puts "Guess " + guess_counter.to_s + " of 4:\n"
      guess = gets.chomp.downcase
      while bad_input(guess)
        guess = gets.chomp.downcase
      end
      sequence.push(guess)
      guess_counter += 1
    end
    return sequence
  end

  def player_turn
    puts @@turn_prompt
    current_guess = getPlayerGuess()
    if @game_board.guessedRight(current_guess)
      puts "Congratulations, you've cracked the code!"
    end
    @game_board.addSequence(current_guess, @turn)
    @game_board.updateHints(current_guess, @turn)  
  end

  def computer_turn
    sleep 1
    puts "thinking..."
    sleep 1
    puts "generating guess..."
    computer_guess = @computer.guess(@turn, @game_board.secret_code,
                                     @game_board.guess_slots,
                                     @game_board.hint_slots)
    sleep 1
    puts "here's my guess:"
    sleep 0.5
    puts computer_guess.join(' ')
    @game_board.guessedRight(computer_guess)
    @game_board.addSequence(computer_guess, @turn)
    @game_board.updateHints(computer_guess, @turn)
    sleep 0.5
    puts "\n"
  end

  def play
    code = generateCode
    @game_board = GameBoard.new(code)
    if @mode == 'p'
      @computer = AI.new(@difficulty)
    else
      puts @@how_to_play
    end
    while !@game_board.gameOver() && @turn < 13
      puts "Current Board:\n"
      @game_board.displayBoard()
      if @mode == 'c'
        player_turn()
      else
        computer_turn()
      end
      @turn += 1
    end
    puts "Final Board:\n"
    @game_board.displayBoard()
    if !@game_board.gameOver
      puts "Nice try, but you did not crack the code.\n" +
           "The secret code was:\n" +
           @game_board.colorCode.join + "\n"
    end
  end

end