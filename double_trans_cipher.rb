module DoubleTranspositionCipher
  def self.encrypt(document, key)
    # TODO: FILL THIS IN!
    ## Suggested steps for double transposition cipher
    # 1. find number of rows/cols such that matrix is almost square
    # 2. break plaintext into evenly sized blocks
    # 3. sort rows in predictibly random way using key as seed
    # 4. sort columns of each row in predictibly random way
    # 5. return joined cyphertext
    cols = Math.sqrt(document.length).ceil
    rows = (document.length.to_f / cols).ceil

    matrix = document.chars.each_slice(cols).to_a
    matrix[-1] += [" "] * (cols - matrix[-1].size)

    rng = Random.new(key)
    row_order = (0...rows).to_a.shuffle(random: rng)
    col_order = (0...cols).to_a.shuffle(random: rng)

    reorder_matrix = row_order.map { |i| matrix[i] }
    reorder_matrix = reorder_matrix.transpose
    reorder_matrix = col_order.map { |i| reorder_matrix[i] }

    reorder_matrix.transpose.flatten.join

  end

  def self.decrypt(ciphertext, key)
    # TODO: FILL THIS IN!
    cols = Math.sqrt(ciphertext.length).ceil
    rows = (ciphertext.length.to_f / cols).ceil

    matrix = ciphertext.chars.each_slice(cols).to_a
    reorder_matrix = matrix.transpose

    rng = Random.new(key)
    row_order = (0...rows).to_a.shuffle(random: rng)
    col_order = (0...cols).to_a.shuffle(random: rng)

    row_inverse = row_order.each_with_index.sort_by { |val, _| val }.map { |_, idx| idx }
    col_inverse = col_order.each_with_index.sort_by { |val, _| val }.map { |_, idx| idx }

    reorder_matrix = col_inverse.map { |i| reorder_matrix[i] }
    reorder_matrix = reorder_matrix.transpose
    reorder_matrix = row_inverse.map { |i| reorder_matrix[i] }

    reorder_matrix.flatten.join.rstrip

  end
end
