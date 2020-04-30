require 'terminal-table'

def welcome
  system 'clear'
  puts "Welcome to Guess a Number!\n"
end

def ask_difficulty_level
  possible_answers = %w(1 2 3 4 5)
  puts "What difficult level do you want to play?"
  puts "1 - Easy -> 5 - Hard"

  difficulty_level = gets.strip.downcase

  unless possible_answers.include? difficulty_level
    puts "Invalid option, try again"
    ask_difficulty_level
  end

  difficulty_level.to_i
end

def display_chosen_range(min, max)
  puts "\n\nAwesome!"
  puts "Let's guess a number between #{min} and #{max}\n\n"
end

def show_previous_guesses(guesses, chosen_number)
  table_headings = ['Lower Guess', 'Higher Guess']
  higher, lower = guesses.partition { |guess| guess > chosen_number }
  table_height = [higher.size, lower.size].max
  rows = []

  table_height.times do |i|
    low = lower[i] || ''
    high = higher[i] || ''

    rows << [low, high]
  end

  table = Terminal::Table.new :headings => table_headings, :rows => rows

  puts table
end

def ask_for_guess_number(guesses, chosen_number, current_try, remaining_tries)
  puts "This is the try #{current_try} of #{remaining_tries}\n"

  total_guesses = guesses.size
  show_previous_guesses(guesses, chosen_number) if total_guesses > 0

  puts "What is your guess?"
  guess = gets.strip.to_i

  if guesses.include? guess
    puts "You have already guessed #{guess}, try another number"
    ask_for_guess_number guesses, chosen_number, current_try, remaining_tries
  end

  guess
end

def display_win
  puts "Congratulations!\n"
  puts " .-=========-."
  puts " \\'-=======-'/"
  puts " _|   .=.   |_"
  puts "((|  {{1}}  |))"
  puts " \\|   /|\\   |/"
  puts "  \\__ '`' __/"
  puts "    _`) (`_"
  puts "  _/_______\\_"
  puts " /___________\\"
  puts "\n"
end

def display_lost
  puts "\n"
  puts ' ██████   █████  ███    ███ ███████      ██████  ██    ██ ███████ ██████'
  puts '██       ██   ██ ████  ████ ██          ██    ██ ██    ██ ██      ██   ██'
  puts '██   ███ ███████ ██ ████ ██ █████       ██    ██ ██    ██ █████   ██████'
  puts '██    ██ ██   ██ ██  ██  ██ ██          ██    ██  ██  ██  ██      ██   ██'
  puts ' ██████  ██   ██ ██      ██ ███████      ██████    ████   ███████ ██   ██'
  puts "\n"
end

def ask_keep_playing
  puts "Do you want to keep playing? (y/n)"
  possible_answers = %w(y n)
  keep_playing = gets.strip.downcase

  unless possible_answers.include? keep_playing
    puts "Invalid option, try again"
    ask_keep_playing
  end

  keep_playing
end
