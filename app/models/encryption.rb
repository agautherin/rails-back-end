class Encryption < ApplicationRecord
    has_many :messages



    def self.enigma_encrypt(message, key)
      rotor_pos_arr = parseKey(key) # arrary of rotor Positions [2, 1, 1]
      
      # Hello
        message_array = message.split('').upcase!.map do |letter|
        # 'H'
            lc_key = useEntryWheel(letter, true)
            lc1 = useRotor(lc_key, rotor_pos_arr[2], 2, true)
            lc2 = useRotor(lc1, rotor_pos_arr[1], 1, true)
            lc3 = useRotor(lc2, rotor_pos_arr[0], 0, true)
            reflector = useReflector()
            lc4 = useRotor(lc3, rotor_pos_arr[0], 0, false)
            lc5 = useRotor(lc4, rotor_pos_arr[1], 1, false)
            lc6 = useRotor(lc5, rotor_pos_arr[2], 2, false)
            new_letter = useEntryWheel(letter, false)

            rotor_pos_arr[2] += 1
            
            return new_letter  
        end

        # reflector

      end


    end

    

    def useEntryWheel(letter, isEntry)
      wheel = entryWheel
      if isEntry
        wheel.each do |k, v|
          if v[1] == letter
            return k
          end
        end
      else
        if v[0] == letter
          return k
        end
      end
    end



    def useRotor(lc_key, pos, rotorNum, isEntry)
      # lc = "8", pos=2, 2, isENtry = true
      offset = pos - 1 # 1
      rotor_position = (lc_key.to_i + offset).to_s # 9
      rotor = self.rotor(rotorNum) # get specific rotor
      letter_couple = rotor[rotor_position]

      if isEntry
        return letter_couple[1]
      else
        return letter_couple[0]
      end

    end

    def parseKey(key)
      key.split('rotor')
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


        return self.enigma_encrypt(message, key)
        # handle enigma

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
        return self.enigma_decrypt(message, key)
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
          '1': ['A', 'E'],
          '2': ['B', 'J'],
          '3': ['C', 'M'],
          '4': ['D', 'Z'],
          '5': ['E', 'A'],
          '6': ['F', 'L'],
          '7': ['G', 'Y'],
          '8': ['H', 'X'],
          '9': ['I', 'V'],
          '10': ['J', 'B'],
          '11': ['K', 'W'],
          '12': ['L', 'F'],
          '13': ['M', 'C'],
          '14': ['N', 'R'],
          '15': ['O', 'Q'],
          '16': ['P', 'U'],
          '17': ['Q', 'O'],
          '18': ['R', 'N'],
          '19': ['S', 'T'],
          '20': ['T', 'S'],
          '21': ['U', 'P'],
          '22': ['V', 'I'],
          '23': ['W', 'K'],
          '24': ['X', 'H'],
          '25': ['Y', 'G'],
          '26': ['Z', 'D']
      }
  end

    def self.rotor(rotor_model)

        # rotor model refers to the id of the rotor i.e. 1, 2, 3, 4, 5, or 6
        # input a single character integer type and return a hash

        r_kit = [{
            "1": ["A", "E"],
            "2": ["B", "K"],
            "3": ["C", "M"],
            "4": ["D", "F"],
            "5": ["E", "L"],
            "6": ["F", "G"],
            "7": ["G", "D"],
            "8": ["H", "Q"],
            "9": ["I", "V"],
            "10": ["J", "Z"],
            "11": ["K", "N"],
            "12": ["L", "T"],
            "13": ["M", "O"],
            "14": ["N", "W"],
            "15": ["O", "Y"],
            "16": ["P", "H"],
            "17": ["Q", "X"],
            "18": ["R", "U"],
            "19": ["S", "S"],
            "20": ["T", "P"],
            "21": ["U", "A"],
            "22": ["V", "I"],
            "23": ["W", "B"],
            "24": ["X", "R"],
            "25": ["Y", "C"],
            "26": ["Z", "J"]
        },
        {
            '1': ['A', 'A'],
            '2': ['B', 'J'],
            '3': ['C', 'D'],
            '4': ['D', 'K'],
            '5': ['E', 'S'],
            '6': ['F', 'I'],
            '7': ['G', 'R'],
            '8': ['H', 'U'],
            '9': ['I', 'X'],
            '10': ['J', 'B'],
            '11': ['K', 'L'],
            '12': ['L', 'H'],
            '13': ['M', 'W'],
            '14': ['N', 'T'],
            '15': ['O', 'M'],
            '16': ['P', 'C'],
            '17': ['Q', 'Q'],
            '18': ['R', 'G'],
            '19': ['S', 'Z'],
            '20': ['T', 'N'],
            '21': ['U', 'P'],
            '22': ['V', 'Y'],
            '23': ['W', 'F'],
            '24': ['X', 'V'],
            '25': ['Y', 'O'],
            '26': ['Z', 'E']
        },
        {
            '1': ['A', 'B'],
            '2': ['B', 'D'],
            '3': ['C', 'F'],
            '4': ['D', 'H'],
            '5': ['E', 'J'],
            '6': ['F', 'L'],
            '7': ['G', 'C'],
            '8': ['H', 'P'],
            '9': ['I', 'R'],
            '10': ['J', 'T'],
            '11': ['K', 'X'],
            '12': ['L', 'V'],
            '13': ['M', 'Z'],
            '14': ['N', 'N'],
            '15': ['O', 'Y'],
            '16': ['P', 'E'],
            '17': ['Q', 'I'],
            '18': ['R', 'W'],
            '19': ['S', 'G'],
            '20': ['T', 'A'],
            '21': ['U', 'K'],
            '22': ['V', 'M'],
            '23': ['W', 'U'],
            '24': ['X', 'S'],
            '25': ['Y', 'Q'],
            '26': ['Z', 'O']
        },
        {
            '1': ['A', 'E'],
            '2': ['B', 'S'],
            '3': ['C', 'O'],
            '4': ['D', 'V'],
            '5': ['E', 'P'],
            '6': ['F', 'Z'],
            '7': ['G', 'J'],
            '8': ['H', 'A'],
            '9': ['I', 'Y'],
            '10': ['J', 'Q'],
            '11': ['K', 'U'],
            '12': ['L', 'I'],
            '13': ['M', 'R'],
            '14': ['N', 'H'],
            '15': ['O', 'X'],
            '16': ['P', 'L'],
            '17': ['Q', 'N'],
            '18': ['R', 'F'],
            '19': ['S', 'T'],
            '20': ['T', 'G'],
            '21': ['U', 'K'],
            '22': ['V', 'D'],
            '23': ['W', 'C'],
            '24': ['X', 'M'],
            '25': ['Y', 'W'],
            '26': ['Z', 'B']
        },
        {
            '1': ['A', 'V'],
            '2': ['B', 'Z'],
            '3': ['C', 'B'],
            '4': ['D', 'R'],
            '5': ['E', 'G'],
            '6': ['F', 'I'],
            '7': ['G', 'T'],
            '8': ['H', 'Y'],
            '9': ['I', 'U'],
            '10': ['J', 'P'],
            '11': ['K', 'S'],
            '12': ['L', 'D'],
            '13': ['M', 'N'],
            '14': ['N', 'H'],
            '15': ['O', 'L'],
            '16': ['P', 'X'],
            '17': ['Q', 'A'],
            '18': ['R', 'W'],
            '19': ['S', 'M'],
            '20': ['T', 'J'],
            '21': ['U', 'Q'],
            '22': ['V', 'O'],
            '23': ['W', 'F'],
            '24': ['X', 'E'],
            '25': ['Y', 'C'],
            '26': ['Z', 'K']
        },
        {
            '1': ['A', 'J'],
            '2': ['B', 'P'],
            '3': ['C', 'G'],
            '4': ['D', 'V'],
            '5': ['E', 'O'],
            '6': ['F', 'U'],
            '7': ['G', 'M'],
            '8': ['H', 'F'],
            '9': ['I', 'Y'],
            '10': ['J', 'Q'],
            '11': ['K', 'B'],
            '12': ['L', 'E'],
            '13': ['M', 'N'],
            '14': ['N', 'H'],
            '15': ['O', 'Z'],
            '16': ['P', 'R'],
            '17': ['Q', 'D'],
            '18': ['R', 'K'],
            '19': ['S', 'A'],
            '20': ['T', 'S'],
            '21': ['U', 'X'],
            '22': ['V', 'L'],
            '23': ['W', 'I'],
            '24': ['X', 'C'],
            '25': ['Y', 'T'],
            '26': ['Z', 'W']
        }]

        return r_kit[rotor_model]

    end

end



# alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
# rotor = 'EJMZALYXVBWFCRQUONTSPIKHGD'

# hash = {}
# arr = []

# i = 0
# count = 0

# alpha_arr = alphabet.split('')
# rotor_arr = rotor.split('')

# while i < alpha_arr.length do 
#   arr << "'#{count += 1}': ['#{alpha_arr[i]}', '#{rotor_arr[i]}'],"

#   i += 1
# end

# puts arr
