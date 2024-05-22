p "Welcome to Hangman"

#Method to open file and create array of all words
def load_script
word_dictionary = []
  if File.exist?("./google-10000-english-no-swears.txt")
    f = File.open("./google-10000-english-no-swears.txt", 'r')
    for line in f.readlines
      word_dictionary.push(line.chomp)
    end
  else 
    p "Cannot find file."
  end
  word_dictionary
end

# Retrieving secret word
def get_secret_word
  word_dictionary = load_script
  secret_word = ''
  loop do 
    secret_word = word_dictionary[rand(word_dictionary.size)]
  break if secret_word.size > 5 && secret_word.size < 12
  end
  secret_word
end

#Create placeholder for game
def start_game
  placeholder = []
  secret_word = get_secret_word
  secret_word.size.times do 
    placeholder.push('_')
  end
  guesses = 6
  guess_list = []
  loop do 
    p "Secret word: "
    p placeholder
    p 
    p "Guess a letter?"

    letter = gets.chomp
    guess_list.push(letter + ' ')
      if secret_word.include?(letter.downcase)
        secret_word.chars.each_with_index do |char, idx|
        placeholder[idx] = letter if char == letter.downcase
      end
    else
      guesses -= 1
      p "Guesses left: #{guesses}"
      p "Guess List:"
      p guess_list.join

    end
  break if guesses == 0 or !placeholder.include?('_')

  end



  #Verdict
  if !placeholder.include?('_')
    p "You won! The secret word was: #{secret_word}"
  else
    p "You ran out of guesses. The secret word was '#{secret_word}"
  end
end



start_game



