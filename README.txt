A recreation of the classic board game, “Mastermind” - 2 players (human vs. computer).

Developed as a response to an assignment from The Odin Project:
https://www.theodinproject.com/courses/ruby-programming/lessons/oop?ref=lnav

——————————————————————————————————————————————————————————————————————————————

Options: Either the player can create the code and the computer will guess (variable AI option), or vice verse.

Basic Rules:

-The code maker chooses 4 colors (duplicates are allowed) out of 6 possible colors (red, green, blue, yellow, pink, and cyan) to make their secret code.
-The opponent has 12 turns to guess the code correctly, and receives a set of hints each turn based on their most recent guess.
-For each part of the code where the code-cracker guessed both the color and position correctly, a ‘+’ symbol is given.  
-For each time a color is guessed correctly but not it’s position, an ‘o’ symbol is given (or multiple ‘o’s, if multiple of the same color were guessed AND the secret code includes multiples).