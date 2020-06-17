class Encryption < ApplicationRecord
    has_many :messages

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

      end


    end
    

    def self.rotor(rotor_model)

        # rotor model refers to the id of the rotor i.e. 1, 2, 3, 4, 5, or 6
        # input a single character integer type and return a hash

        # 1: {
        #     1: ["A", "E"],
        #     2: ["B", "K"],
        #     3: ["C", "M"],
        #     4: ["D", "F"],
        #     5: ["E", "L"],
        #     6: ["F", "G"],
        #     7: ["G", "D"],
        #     8: ["H", "Q"],
        #     9: ["I", "V"],
        #     10: ["J", "Z"],
        #     11: ["K", "N"],
        #     12: ["L", "T"],
        #     13: ["M", "O"],
        #     14: ["N", "W"],
        #     15: ["O", "Y"],
        #     16: ["P", "H"],
        #     17: ["Q", "X"],
        #     18: ["R", "U"],
        #     19: ["S", "S"],
        #     20: ["T", "P"],
        #     21: ["U", "A"],
        #     22: ["V", "I"],
        #     23: ["W", "B"],
        #     24: ["X", "R"],
        #     25: ["Y", "C"],
        #     26: ["Z", "J"]
        # }
        # # let id       = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
        # # let rotorI   = "EKMFLGDQVZNTOWYHXUSPAIBRCJ"

        # 2: {
        #     1: ["A", "A"],
        #     2: ["B", "B"],
        #     3: ["C", "C"],
        #     4: ["D", "D"],
        #     5: ["E", "E"],
        #     6: ["F", "F"],
        #     7: ["G", "G"],
        #     8: ["H", "H"],
        #     9: ["I", "I"],
        #     10: ["J", "J"],
        #     11: ["K", "K"],
        #     12: ["L", "L"],
        #     13: ["M", "M"],
        #     14: ["N", "N"],
        #     15: ["O", "O"],
        #     16: ["P", "P"],
        #     17: ["Q", "Q"],
        #     18: ["R", "R"],
        #     19: ["S", "S"],
        #     20: ["T", "T"],
        #     21: ["U", "U"],
        #     22: ["V", "V"],
        #     23: ["W", "W"],
        #     24: ["X", "X"],
        #     25: ["Y", "Y"],
        #     26: ["Z", "Z"]
        # },
        # 3: {
        #     1: ["A", "A"],
        #     2: ["B", "B"],
        #     3: ["C", "C"],
        #     4: ["D", "D"],
        #     5: ["E", "E"],
        #     6: ["F", "F"],
        #     7: ["G", "G"],
        #     8: ["H", "H"],
        #     9: ["I", "I"],
        #     10: ["J", "J"],
        #     11: ["K", "K"],
        #     12: ["L", "L"],
        #     13: ["M", "M"],
        #     14: ["N", "N"],
        #     15: ["O", "O"],
        #     16: ["P", "P"],
        #     17: ["Q", "Q"],
        #     18: ["R", "R"],
        #     19: ["S", "S"],
        #     20: ["T", "T"],
        #     21: ["U", "U"],
        #     22: ["V", "V"],
        #     23: ["W", "W"],
        #     24: ["X", "X"],
        #     25: ["Y", "Y"],
        #     26: ["Z", "Z"]
        # }


    end

end

