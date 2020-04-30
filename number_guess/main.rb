require_relative 'ui'

def stop_playing?
  keep_playing = ask_keep_playing
  keep_playing != 'y'
end

def choose_number(difficulty_level)
  possible_numbers = 10 * difficulty_level ** 2

  chosen_number = rand(1..possible_numbers)
  display_chosen_range 1, possible_numbers
  chosen_number
end

def calculate_remaining_tries(difficulty_level)
  minimum_tries = 5
  remaining_tries = minimum_tries + (1..difficulty_level).reduce(:+) - 1
end

def play
  loop do
    welcome
    difficulty_level = ask_difficulty_level
    remaining_tries = calculate_remaining_tries difficulty_level
    chosen_number = choose_number difficulty_level
    guesses = []

    for current_try in 1..remaining_tries
      guess = ask_for_guess_number guesses, chosen_number, current_try, remaining_tries

      if guess == chosen_number
        display_win
        break
      end

      guesses << guess

      show_previous_guesses guesses, chosen_number, current_try, remaining_tries
      display_lost if current_try == remaining_tries
    end



    break if stop_playing?
  end
end

play