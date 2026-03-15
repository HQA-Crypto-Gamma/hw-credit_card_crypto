# frozen_string_literal: true

# Create a namespace for substitution ciphers
module SubstitutionCipher
  # Create a module for Caesar cipher
  module Caesar
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using caesar cipher
      json_string = document.to_json
      encrypted_list = json_string.bytes.map do |byte|
        (byte + key).chr
      end
      encrypted_list.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using caesar cipher
      decrypted_list = document.bytes.map do |char|
        (char - key).chr
      end
      decrypted_list.join
    end
  end

  # Create a module for permutation cipher
  module Permutation
    # Encrypts document using key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.encrypt(document, key)
      # TODO: encrypt string using a permutation cipher
      random_key = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: random_key)
      json_string = document.to_json
      encrypted_list = json_string.bytes.map do |byte|
        lookup_table[byte].chr
      end
      encrypted_list.join
    end

    # Decrypts String document using integer key
    # Arguments:
    #   document: String
    #   key: Fixnum (integer)
    # Returns: String
    def self.decrypt(document, key)
      # TODO: decrypt string using a permutation cipher
      random_key = Random.new(key)
      lookup_table = (0..127).to_a.shuffle(random: random_key)
      inverse = Array.new(128)
      lookup_table.each_with_index do |value, index|
        inverse[value] = index
      end
      decrypted_list = document.bytes.map do |char|
        inverse[char].chr
      end
      decrypted_list.join
    end
  end
end
