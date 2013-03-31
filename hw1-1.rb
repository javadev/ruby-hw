def palindrome?(str)
  letters = str.downcase.scan(/\w/)
  letters == letters.reverse
end

def count_words(string)
  # set up a hash that accumulates the number of occurrences per word
  wordcount = Hash.new(0)
  string.downcase.scan(/\b\w+\b/) { |word| wordcount[word] += 1 }
  # no need to use return here, the function already evaluates to the last
  # value
  wordcount
end

#puts palindrome?("A man, a plan, a canal -- Panama")  # => true
#puts palindrome?("Madam, I'm Adam!")                  # => true
#puts palindrome?("Abracadabra")                       # => false (nil is also ok)

#puts count_words("A man, a plan, a canal -- Panama")
    # => {'a' => 3, 'man' => 1, 'canal' => 1, 'panama' => 1, 'plan' => 1}
#puts count_words "Doo bee doo bee doo"
    # => {'doo' => 3, 'bee' => 2}