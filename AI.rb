$LOAD_PATH << '.'
require 'GameTools.rb'

class AI
	include GameTools
	def initialize(difficulty)
		@difficulty = difficulty
	end

	def guess(turn, code, guesses, hints)
		new_guess = []
		if @difficulty == 'easy'
			new_guess = generateEasyGuess(turn, code, guesses, hints)
		else
			new_guess = generateNormalGuess(turn, code, guesses)
		end
		return new_guess
	end

	private

	def randomColor
		return (numToColor(rand(1..6)))
	end

	def randomGuess
		random_guess = []
		4.times do
			random_guess.push(randomColor())	
		end
		return random_guess	
	end

	def generateEasyGuess(turn, code, guesses, hints)
		next_guess = []
		last_turn = (turn - 2)
		case
		when turn == 1
			return randomGuess()
		when (turn > 1 && (turn % 2 == 0))
			if guesses[last_turn].any? {|color| code.include? color}
				next_guess = guesses[last_turn].shuffle
			else
				next_guess = randomGuess()
			end
		when (turn > 1 && (turn % 2 == 1))
			#this is to make the AI look as though its 'reasoning' about the next guesses
			if hints[last_turn].include? '+'
				guesses[last_turn].each_with_index{|color, index|
					if code[index] != color
						next_guess[index] = randomColor()
					end
				}
			elsif hints[last_turn].include? 'o'
				next_guess = guesses[last_turn].shuffle
			else
				next_guess = randomGuess
			end
		else
			next_guess = generateNormalGuess(turn, code, guesses)
		end
		unless guesses.include? next_guess
			return next_guess
		else
			return generateEasyGuess(turn, code, guesses, hints)
		end
	end

	def generateNormalGuess(turn, code, guesses)
		last_turn = (turn - 2)
		#keeps correct colors in their slots, guesses randomly for others
		if turn == 1
			return randomGuess()
		else
			next_guess = []
			index = 0
			while index < 4
				if code[index].to_s != guesses[last_turn][index].to_s
					next_guess.push(randomColor())
				else
					next_guess.push(code[index])
				end
				index += 1
			end
		end
		unless guesses.include? next_guess
			return next_guess
		else
			return generateNormalGuess(turn, code, guesses)
		end
	end
end