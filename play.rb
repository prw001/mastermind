require_relative 'colorize.rb'
require_relative 'mastermind.rb'
require_relative 'game_board.rb'
require_relative 'AI.rb'
$invalid_response = "Not a valid response, please use one of the options indicated above.".red

def validResponse(response)
  case response
  when '1', '2'
    return true
  else
    return false
  end
end

def options()
  puts "\n\n      ::::::OPTIONS::::::\n".blue+
      "Option (1):".green + " Player creates the code\n" +
      "Option (2):".green + " Computer creates the code\n" +
      "Please type '1' or '2' then press Enter:\n"
  option = gets.chomp
  while !validResponse(option)
    puts $invalid_response
    option = gets.chomp
  end
  if option == '1'
    return true
  else
    return false
  end
end

def difficultySetting()
  puts "\n\n      :::SELECT COMPUTER DIFFICULTY:::\n".red+
       "Option (1):".green + " Easy\n".yellow +
       "Option (2):".green + " Normal\n".red +
       "Please type '1' or '2', then press Enter:\n"
    difficulty = gets.chomp
    while !validResponse(difficulty)
      puts $invalid_response
      difficulty = gets.chomp
    end
  return difficulty
end

def userPrompt
  prompt = "\n\n||||||||````````````````````````||||||||\n".blue +
            "~~////**".blue + " Welcome to Mastermind! ".green + "**////~~\n".blue + 
            "||||||||........................||||||||\n\n\n".blue +
            "Would you like to play a round?\n" +
            "Option (1):".green + " Play Game\n" +
            "Option (2):".green + " Exit Program\n" + 
            "Please type '1' or '2' then press enter:\n"
  game = nil
  is_playing = false
  puts prompt
  response = gets.chomp
  while !validResponse(response)
    puts $invalid_response
    response = gets.chomp
  end
  if response == '1'
    is_playing = true
  end
  while is_playing
    if options()
      difficulty = difficultySetting()
      game = Mastermind.new('p', difficulty)
      game.play
    else
      game = Mastermind.new('c')
      game.play
    end
    puts "Play again?\n'Yes' -> enter '1'\n'No' -> enter '2':\n"
    response = gets.chomp
    while !validResponse(response)
      puts $invalid_response
      response = gets.chomp
    end
    if response == '2'
      is_playing = false
    end
  end
  puts 'Goodbye!'
end

userPrompt()
