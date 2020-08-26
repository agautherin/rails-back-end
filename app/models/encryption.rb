class Encryption < ApplicationRecord
  has_many :messages

  def self.enigma(message, key)
    current_key = self.parseKey(key)
      encrypted = message.split('').map do |letter| 
        # convert letter to Alphabet position
        l = letter.upcase
        zero_position = (l.ord - 64)
        # wrap logic in conditional regex
        if zero_position > 0 && zero_position < 27
        # use entry wheel
        first_position = self.useEntryWheel(zero_position.to_s, true)
        # rotor 3
        second_position = self.useRotor(first_position, current_key[0], 0)
        # rotor 2 
        third_position = self.useRotor(second_position, current_key[1], 1)
        # rotor 1
        fourth_position = self.useRotor(third_position, current_key[2], 2)
        # reflector
        fifth_position = self.useReflector(fourth_position)
        # rotor 1
        sixth_position = self.useReverseRotor(fifth_position, current_key[2], 2)
        # rotor 2
        seventh_position = self.useReverseRotor(sixth_position, current_key[1], 1)
        # rotor 3
        eighth_position = self.useReverseRotor(seventh_position, current_key[0], 0)
        # use entry wheel
        encrypted_letter = self.useEntryWheel(eighth_position, false)
        # turn rotor
        current_key = self.advanceRotors(current_key)
        encrypted_letter
      else
        letter
      end
    end
    encrypted.join()
  end

  def self.useEntryWheel(position, isEntry)
    wheel = self.entryWheel
    return wheel[position.to_s][0] if !isEntry
    return position
  end
   
  def self.useRotor(input, rotorPosition, rotorNum)
    # input is already adjusted
    offset = input.to_i - 1;
    # adjust by offset
    entry_point = rotorPosition + offset;
    # if over 26
    entry_point = entry_point % 26 if entry_point > 26
    # p "Rotor Adjustment: #{entry_point}"
    rotor_model = self.rotor(rotorNum) # get specific rotor
    letter_couple = rotor_model[entry_point.to_s]
    # p "Letter Pair: #{letter_couple}"
    letter_ord = (letter_couple[1].ord - 64)
    # p letter_ord
    if (letter_ord < rotorPosition) 
        exit_point = (26 - rotorPosition + 1) + letter_ord
    elsif (letter_ord > rotorPosition)
        exit_point = letter_ord + (1 - rotorPosition)
    else 
        exit_point = 1
    end
    # p "Exit Position: #{exit_point}"
    return exit_point.to_s

  end

  def self.useReverseRotor(input, rotorPosition, rotorNum)
    # input is already adjusted
    offset = input.to_i - 1;
    # adjust by offset
    entry_point = rotorPosition + offset;
    # if over 26
    entry_point = entry_point % 26 if entry_point > 26
    entry_letter = (entry_point+64).chr
 
    rotor_model = self.rotor(rotorNum) # get specific rotor
    letter_couple = rotor_model[entry_point.to_s][0]
    letter = letter_couple[0]
   
    couple = rotor_model.find do |k, v| 
      v[1] == letter
    end
    letter_ord = couple[0].to_i

    exit_point = 1
    i = rotorPosition
    while (i < letter_ord) do
      if i < 26
          i+=1
      else 
          i = 1
      end
      exit_point+=1
    end
     
    if (letter_ord < rotorPosition) 
      exit_point = (26 - rotorPosition + 1) + letter_ord
    elsif (letter_ord > rotorPosition)
      exit_point = letter_ord + (1 - rotorPosition)
    else 
      exit_point =  1
    end

    return exit_point.to_s

  end

  def self.useReflector(input)
    reflector_model = self.reflector
    letter_return = reflector_model[input][1]
    # p "Entry Letter: #{reflector_model[input][0]}, Exit Letter: #{letter_return}"
    return (letter_return.ord - 64).to_s
  end


  def self.advanceRotors(arr)
    arr[0] += 1;
    if (arr[0] > 26) 
        arr[1] += 1
        arr[0] = 1
    end
    if (arr[1] > 26)
        arr[2] += 1
        arr[1] = 1
    end
    if (arr[2] > 26)
        arr[2] = 1
    end

    return arr
  end

  def self.parseKey(key)
    key.split('rotor').map do |num| num.to_i end
  end

  def self.caesar_encrypt(message, key)
    # message is going to be a plain text string, i.e., "Hello World"
    # key is always going to be a string that is a number, i.e., "1"
    encrypted_message = message.split("").map do |letter| 
      (letter.ord - key.to_i).chr
    end.join("")

    return  encrypted_message
    #return an encrypted string i.e., message jumbled "Jfmmp Xpsme"
  end

  def self.encrypt(type, message, key)
    if type === "1"
      # handle none
      return message
    elsif type === "2"
      # handle caesar
      return self.caesar_encrypt(message, key)

    else
      # handle enigma
      return self.enigma(message, key)

    end
  end
    
  def self.caesar_decrypt(message, key)

    encrypted_message = message.split("").map do |letter| 
      (letter.ord + key.to_i).chr
    end.join("")

    return  encrypted_message
    #return an encrypted string i.e., message jumbled
  end

  def self.decrypt(type, message, key)
    if type === "1"
      # handle none
      return message
    elsif type === "2"
      # handle caesar
      return self.caesar_decrypt(message, key)

    else
      # handle enigma
      return self.enigma(message, key)
    end
  end
    
  def self.entryWheel()
    {
      "1" => ["A", "A"],
      "2" => ["B", "B"],
      "3" => ["C", "C"],
      "4" => ["D", "D"],
      "5" => ["E", "E"],
      "6" => ["F", "F"],
      "7" => ["G", "G"],
      "8" => ["H", "H"],
      "9" => ["I", "I"],
      "10" => ["J", "J"],
      "11" => ["K", "K"],
      "12" => ["L", "L"],
      "13" => ["M", "M"],
      "14" => ["N", "N"],
      "15" => ["O", "O"],
      "16" => ["P", "P"],
      "17" => ["Q", "Q"],
      "18" => ["R", "R"],
      "19" => ["S", "S"],
      "20" => ["T", "T"],
      "21" => ["U", "U"],
      "22" => ["V", "V"],
      "23" =>["W", "W"],
      "24" =>["X", "X"],
      "25" => ["Y", "Y"],
      "26" => ["Z", "Z"]
  }
  end

  def self.reflector 
    {
      '1' => ['A', 'E'],
      '2' => ['B', 'J'],
      '3' => ['C', 'M'],
      '4' => ['D', 'Z'],
      '5' => ['E', 'A'],
      '6' => ['F', 'L'],
      '7' => ['G', 'Y'],
      '8' => ['H', 'X'],
      '9' => ['I', 'V'],
      '10' => ['J', 'B'],
      '11' => ['K', 'W'],
      '12' => ['L', 'F'],
      '13' => ['M', 'C'],
      '14' => ['N', 'R'],
      '15' => ['O', 'Q'],
      '16' => ['P', 'U'],
      '17' => ['Q', 'O'],
      '18' => ['R', 'N'],
      '19' => ['S', 'T'],
      '20' => ['T', 'S'],
      '21' => ['U', 'P'],
      '22' => ['V', 'I'],
      '23' => ['W', 'K'],
      '24' => ['X', 'H'],
      '25' => ['Y', 'G'],
      '26' => ['Z', 'D']
    }
  end

    def self.rotor(rotor_model)

        # rotor model refers to the id of the rotor i.e. 1, 2, 3, 4, 5, or 6
        # input a single character integer type and return a hash

        r_kit = [{
            
            "1" => ["A", "E"],
            "2" => ["B", "K"],
            "3" => ["C", "M"],
            "4" => ["D", "F"],
            "5" => ["E", "L"],
            "6" => ["F", "G"],
            "7" => ["G", "D"],
            "8" => ["H", "Q"],
            "9" => ["I", "V"],
            "10" => ["J", "Z"],
            "11" => ["K", "N"],
            "12" => ["L", "T"],
            "13" => ["M", "O"],
            "14" => ["N", "W"],
            "15" => ["O", "Y"],
            "16" => ["P", "H"],
            "17" => ["Q", "X"],
            "18" => ["R", "U"],
            "19" => ["S", "S"],
            "20" => ["T", "P"],
            "21" => ["U", "A"],
            "22" => ["V", "I"],
            "23" => ["W", "B"],
            "24" => ["X", "R"],
            "25" => ["Y", "C"],
            "26" => ["Z", "J"]
        },
        {
            '1' => ['A', 'A'],
            '2' => ['B', 'J'],
            '3' => ['C', 'D'],
            '4' => ['D', 'K'],
            '5' => ['E', 'S'],
            '6' => ['F', 'I'],
            '7' => ['G', 'R'],
            '8' => ['H', 'U'],
            '9' => ['I', 'X'],
            '10' => ['J', 'B'],
            '11' => ['K', 'L'],
            '12' => ['L', 'H'],
            '13' => ['M', 'W'],
            '14' => ['N', 'T'],
            '15' => ['O', 'M'],
            '16' => ['P', 'C'],
            '17' => ['Q', 'Q'],
            '18' => ['R', 'G'],
            '19' => ['S', 'Z'],
            '20' => ['T', 'N'],
            '21' => ['U', 'P'],
            '22' => ['V', 'Y'],
            '23' => ['W', 'F'],
            '24' => ['X', 'V'],
            '25' => ['Y', 'O'],
            '26' => ['Z', 'E']
        },
        {
            '1' => ['A', 'B'],
            '2' => ['B', 'D'],
            '3' => ['C', 'F'],
            '4' => ['D', 'H'],
            '5' => ['E', 'J'],
            '6' => ['F', 'L'],
            '7' => ['G', 'C'],
            '8' => ['H', 'P'],
            '9' => ['I', 'R'],
            '10' => ['J', 'T'],
            '11' => ['K', 'X'],
            '12' => ['L', 'V'],
            '13' => ['M', 'Z'],
            '14' => ['N', 'N'],
            '15' => ['O', 'Y'],
            '16' => ['P', 'E'],
            '17' => ['Q', 'I'],
            '18' => ['R', 'W'],
            '19' => ['S', 'G'],
            '20' => ['T', 'A'],
            '21' => ['U', 'K'],
            '22' => ['V', 'M'],
            '23' => ['W', 'U'],
            '24' => ['X', 'S'],
            '25' => ['Y', 'Q'],
            '26' => ['Z', 'O']
        },
        {
            '1' => ['A', 'E'],
            '2' => ['B', 'S'],
            '3' => ['C', 'O'],
            '4' => ['D', 'V'],
            '5' => ['E', 'P'],
            '6' => ['F', 'Z'],
            '7' => ['G', 'J'],
            '8' => ['H', 'A'],
            '9' => ['I', 'Y'],
            '10' => ['J', 'Q'],
            '11' => ['K', 'U'],
            '12' => ['L', 'I'],
            '13' => ['M', 'R'],
            '14' => ['N', 'H'],
            '15' => ['O', 'X'],
            '16' => ['P', 'L'],
            '17' => ['Q', 'N'],
            '18' => ['R', 'F'],
            '19' => ['S', 'T'],
            '20' => ['T', 'G'],
            '21' => ['U', 'K'],
            '22' => ['V', 'D'],
            '23' => ['W', 'C'],
            '24' => ['X', 'M'],
            '25' => ['Y', 'W'],
            '26' => ['Z', 'B']
        },
        {
            '1' => ['A', 'V'],
            '2' => ['B', 'Z'],
            '3' => ['C', 'B'],
            '4' => ['D', 'R'],
            '5' => ['E', 'G'],
            '6' => ['F', 'I'],
            '7' => ['G', 'T'],
            '8' => ['H', 'Y'],
            '9' => ['I', 'U'],
            '10' => ['J', 'P'],
            '11' => ['K', 'S'],
            '12' => ['L', 'D'],
            '13' => ['M', 'N'],
            '14' => ['N', 'H'],
            '15' => ['O', 'L'],
            '16' => ['P', 'X'],
            '17' => ['Q', 'A'],
            '18' => ['R', 'W'],
            '19' => ['S', 'M'],
            '20' => ['T', 'J'],
            '21' => ['U', 'Q'],
            '22' => ['V', 'O'],
            '23' => ['W', 'F'],
            '24' => ['X', 'E'],
            '25' => ['Y', 'C'],
            '26' => ['Z', 'K']
        },
        {
            '1' => ['A', 'J'],
            '2' => ['B', 'P'],
            '3' => ['C', 'G'],
            '4' => ['D', 'V'],
            '5' => ['E', 'O'],
            '6' => ['F', 'U'],
            '7' => ['G', 'M'],
            '8' => ['H', 'F'],
            '9' => ['I', 'Y'],
            '10' => ['J', 'Q'],
            '11' => ['K', 'B'],
            '12' => ['L', 'E'],
            '13' => ['M', 'N'],
            '14' => ['N', 'H'],
            '15' => ['O', 'Z'],
            '16' => ['P', 'R'],
            '17' => ['Q', 'D'],
            '18' => ['R', 'K'],
            '19' => ['S', 'A'],
            '20' => ['T', 'S'],
            '21' => ['U', 'X'],
            '22' => ['V', 'L'],
            '23' => ['W', 'I'],
            '24' => ['X', 'C'],
            '25' => ['Y', 'T'],
            '26' => ['Z', 'W']
        }]

        return r_kit[rotor_model]

    end

end