# frozen_string_literal: true

# Create a namespace for double transposition cipher
module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    cols, rows = matrix_dimensions(document)
    matrix = build_matrix(document, cols)
    row_order, col_order = permutation_orders(rows, cols, key)
    apply_encrypt_permutation(matrix, row_order, col_order).join
  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    cols, rows = matrix_dimensions(ciphertext)
    matrix = ciphertext.chars.each_slice(cols).to_a
    row_order, col_order = permutation_orders(rows, cols, key)
    apply_decrypt_permutation(matrix, row_order, col_order).join.rstrip
  end

  def self.matrix_dimensions(text)
    cols = Math.sqrt(text.length).ceil
    rows = (text.length.to_f / cols).ceil
    [cols, rows]
  end

  def self.permutation_orders(rows, cols, key)
    rng = Random.new(key)
    row_order = (0...rows).to_a.shuffle(random: rng)
    col_order = (0...cols).to_a.shuffle(random: rng)
    [row_order, col_order]
  end

  def self.build_matrix(text, cols)
    matrix = text.chars.each_slice(cols).to_a
    matrix[-1] += [' '] * (cols - matrix[-1].size)
    matrix
  end

  def self.inverse_order(order)
    order.each_with_index.sort_by { |val, _| val }.map { |_, idx| idx }
  end

  def self.apply_encrypt_permutation(matrix, row_order, col_order)
    reordered = row_order.map { |index| matrix[index] }
    reordered = reordered.transpose
    reordered = col_order.map { |index| reordered[index] }
    reordered.transpose
  end

  def self.apply_decrypt_permutation(matrix, row_order, col_order)
    reordered = matrix.transpose
    reordered = inverse_order(col_order).map { |index| reordered[index] }
    reordered = reordered.transpose
    inverse_order(row_order).map { |index| reordered[index] }
  end
end
