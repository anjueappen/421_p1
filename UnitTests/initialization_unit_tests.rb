require 'test/unit'
require '../sparse_matrix.rb'

class InitializationUnitTests < Test::Unit::TestCase


  def test_initialize_square_brackets_integers
    # setup
    a = 1
    b = 2
    c = 3
    d = 4

    simple_sm = SparseMatrix[[a,0], [0,b]]
    duplicates_sm = SparseMatrix[[a,a,0,0],[c,0,0,0],[0,d,d,0]]
    zero_sm = SparseMatrix[[0,0],[0,0]]

    #expected hashes
    hash_simple = {[0,0] => 1, [1,1] => 2}
    hash_duplicates = {[0,0] => 1, [0,1] => 1, [1,0] => 3, [2, 1] => 4, 
      [2,2] => 4}
    hash_zero = {}

    #pre
    assert a.is_a?(Integer), "Elements in matrix must be integers."
    assert b.is_a?(Integer), "Elements in matrix must be integers."
    assert c.is_a?(Integer), "Elements in matrix must be integers."
    assert d.is_a?(Integer), "Elements in matrix must be integers."

    # data tests
    assert_equal Matrix[[1,0], [0,2]], simple_sm.full(), "Matrices must be equal."
    assert_equal Matrix[[1,1,0,0],[3,0,0,0],[0,4,4,0]], duplicates_sm.full(), "Matrices must be equal."
    assert_equal Matrix[[0,0],[0,0]], zero_sm.full(), "Matrices must be equal."

    # Compare expected vs actual result of hashes and Matrix representations
    assert hash_simple.eql?(simple_sm.values), "Hashes must be equal."
    assert hash_duplicates.eql?(duplicates_sm.values), "Hashes must be equal"
    assert hash_zero.eql?(zero_sm.values), "Nothing stored."

    #post
    # Must be sparse matrix classes
    assert simple_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert duplicates_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert zero_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."

    # Must be real
    assert simple_sm.real?, "Real sparse_matrix"
    assert duplicates_sm.real?, "Real sparse_matrix"
    assert zero_sm.real?, "Real sparse_matrix"

    # Hahes cannot be empty for non-zero sparse matrices
    assert !simple_sm.values.empty?, "Hash cannot be empty."
    assert !duplicates_sm.values.empty?, "Hash cannot be empty."
    assert zero_sm.values.empty?, "Hash should be empty for a zero matrix."

    # Hashes should only store non-zero values
    assert !simple_sm.values.has_value?(0), "Hash only stores non-zero elements."
    assert !duplicates_sm.values.has_value?(0), "Hash only stores non-zero elements."

  end

  def test_initialize_square_brackets_floats
    #setup
    a = 1.00
    b = 2.00

    #pre
    assert a.is_a?(Float), "Testing initializing using floats."
    assert b.is_a?(Float), "Testing initializing using floats."

    float_sm = SparseMatrix[[a, 0.00], [0.00, b]]
    #expected hash
    hash_float = {[0,0] => 1.00, [1,1] => 2.00}

    #data
    assert_equal Matrix[[1,0], [0,2]], float_sm.full(), "Matrices must be equal."
    assert hash_float.eql?(float_sm.values), "Hashes must be equal."

    #post
    assert float_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert float_sm.real?, "Real sparse_matrix"
    assert !float_sm.values.empty?, "Hash cannot be empty."
    assert !float_sm.values.has_value?(0), "Hash only stores non-zero elements."

  end

  def test_initialize_square_brackets_chars
    #setup
    a = 'a'
    b = 'b'
    char_sm = SparseMatrix[[a, 0], [b, 0]] #these should be allowed to iniitalize
    hash_char = {[0,0] => 'a', [1,0] => 'b'}   #expected

    #pre
    assert a.is_a?(String), "Character element allowed."
    assert b.is_a?(String), "Character element allowed."

    #data
    assert_equal Matrix[['a',0], ['b',0]], char_sm.full(), "Matrices must be equal."
    assert hash_char.eql?(char_sm.values), "Hashes must be equal."

    #post
    assert char_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !char_sm.values.empty?, "Hash cannot be empty."
    assert !char_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_val_row
    #setup
    rows = [[1,0], [0,2]]
    rows_sm = SparseMatrix.rows(rows)
    hash_rows = {[0,0] => 1, [1,1] => 2}

    #pre : only looking generally at the rows argument, elements in the array are tested in the test_initialize_square_brackets tests.
    assert rows.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[[1,0], [0,2]], rows_sm.full(), "Matrices must be equal."
    assert hash_rows.eql?(rows_sm.values), "Hashes must be equal."

    #post
    assert rows_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert rows_sm.real?, "Real sparse_matrix"
    assert !rows_sm.values.empty?, "Hash cannot be empty."
    assert !rows_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_val_row_floats
    rows = [[1.00,0], [0,2.00]]
    rows_sm = SparseMatrix.rows(rows)
    hash_rows = {[0,0] => 1.00, [1,1] => 2.00}


    #pre : only looking generally at the rows argument, elements in the array are tested in the test_initialize_square_brackets tests.
    assert rows.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[[1.00,0], [0,2.00]], rows_sm.full(), "Matrices must be equal."
    assert hash_rows.eql?(rows_sm.values), "Hashes must be equal."

    #post
    assert rows_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert rows_sm.real?, "Real sparse_matrix"
    assert !rows_sm.values.empty?, "Hash cannot be empty."
    assert !rows_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_val_row_chars
    rows = [['a',0], [0,'b']]
    chars_sm = SparseMatrix.rows(rows)
    hash_chars = {[0,0] => 'a', [1,1] => 'b'}


    #pre : only looking generally at the rows argument, elements in the array are tested in the test_initialize_square_brackets tests.
    assert rows.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[['a',0], [0,'b']], chars_sm.full(), "Matrices must be equal."
    assert hash_chars.eql?(chars_sm.values), "Hashes must be equal."

    #post
    assert chars_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !chars_sm.values.empty?, "Hash cannot be empty."
    assert !chars_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_scalar
    #setup
    n = 3
    v = 2
    scalar_sm = SparseMatrix.scalar(n, v)
    hash_scalar = {[0,0] => 2, [1,1] => 2, [2,2] => 2} #expected

    #pre
    assert n.is_a?(Integer), "n-size of matrix must be an integer."
    assert_operator n, :>, 0, "Size must be greater than 0."
    assert v.is_a?(Integer), "Value inserted into matrix must be an integer."

    #data tests
    assert_equal Matrix[[2, 0, 0], [0, 2, 0], [0, 0, 2]], scalar_sm.full(), "Matrices must be equal."
    assert hash_scalar.eql?(scalar_sm.values), "Hashes must be equal."

    #post
    assert scalar_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert scalar_sm.real?, "Real sparse_matrix"
    assert !scalar_sm.values.empty?, "Hash cannot be empty."
    assert !scalar_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_scalar_chars
   #setup
    n = 3
    v = 'a'
    char_sm = SparseMatrix.scalar(n, v)
    hash_char = {[0,0] => 'a', [1,1] => 'a', [2,2] => 'a'} #expected

    #pre
    assert n.is_a?(Integer), "n-size of matrix must be an integer."
    assert_operator n, :>, 0, "Size must be greater than 0."
    assert v.is_a?(String), "Value inserted into matrix can be a character."

    #data tests
    assert_equal Matrix[['a', 0, 0], [0, 'a', 0], [0, 0, 'a']], char_sm.full(), "Matrices must be equal."
    assert hash_char.eql?(char_sm.values), "Hashes must be equal."

    #post
    assert char_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !char_sm.values.empty?, "Hash cannot be empty."
    assert !char_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_scalar_float
    #setup
    n = 3
    v = 2.00
    scalar_sm = SparseMatrix.scalar(n, v)
    hash_scalar = {[0,0] => 2.00, [1,1] => 2.00, [2,2] => 2.00} #expected

    #pre
    assert n.is_a?(Integer), "n-size of matrix must be an integer."
    assert_operator n, :>, 0, "Size must be greater than 0."
    assert v.is_a?(Float), "Value inserted into matrix can be an float."

    #data tests
    assert_equal Matrix[[2, 0, 0], [0, 2, 0], [0, 0, 2]], scalar_sm.full(), "Matrices must be equal."
    assert hash_scalar.eql?(scalar_sm.values), "Hashes must be equal."

    #post
    assert scalar_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert scalar_sm.real?, "Real sparse_matrix"
    assert !scalar_sm.values.empty?, "Hash cannot be empty."
    assert !scalar_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_columns
    #setup
    columns = [[1, 0, 1], [0, 2, 0]]
    col_sm = SparseMatrix.columns(columns)
    hash_col = {[0,0] => 1, [1,1] => 2, [2,0] => 1}

    #pre    
    assert columns.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[[1,0], [0,2], [1,0]], col_sm.full(), "Matrices must be equal."
    assert hash_col.eql?(col_sm.values), "Hashes must be equal."

    #post
    assert col_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert col_sm.real?, "Real sparse_matrix"
    assert !col_sm.values.empty?, "Hash cannot be empty."
    assert !col_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end


  def test_initialize_columns_floats
    #setup
    columns = [[1.00, 0, 1.00], [0, 2.00, 0]]
    col_sm = SparseMatrix.columns(columns)
    hash_col = {[0,0] => 1.00, [1,1] => 2.00, [2,0] => 1.00}

    #pre    
    assert columns.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[[1.00,0], [0,2.00], [1.00,0]], col_sm.full(), "Matrices must be equal."
    assert hash_col.eql?(col_sm.values), "Hashes must be equal."

    #post
    assert col_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert col_sm.real?, "Real sparse_matrix"
    assert !col_sm.values.empty?, "Hash cannot be empty."
    assert !col_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_columns_chars
    #setup
    columns = [['a', 0, 'a'], [0, 'b', 0]]
    col_sm = SparseMatrix.columns(columns)
    hash_col = {[0,0] => 'a', [1,1] => 'b', [2,0] => 'a'}

    #pre    
    assert columns.is_a?(Array), "Argument must be an array of arrays."

    #data tests
    assert_equal Matrix[['a',0], [0,'b'], ['a',0]], col_sm.full(), "Matrices must be equal."
    assert hash_col.eql?(col_sm.values), "Hashes must be equal."

    #post
    assert col_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !col_sm.values.empty?, "Hash cannot be empty."
    assert !col_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_diagonal
    #setup
    list = -9, 8, 3, 2, 1
    diag_sm = SparseMatrix.diagonal(*list)
    hash_diag = {[0, 0]=>-9, [1, 1]=>8, [2, 2]=>3, [3, 3]=>2, [4, 4]=>1}

    #pre
    list.each { |i|
      assert i.is_a?(Integer), "All elements must be integers."
    }

    #data tests
    assert_equal Matrix[[-9, 0, 0, 0, 0], [0, 8, 0, 0, 0], [0, 0, 3, 0, 0], [0, 0, 0, 2, 0], [0, 0, 0, 0, 1]], diag_sm.full(), "Matrices must be the same."
    assert hash_diag.eql?(diag_sm.values), "Hashes must be the same."

    #post
    assert diag_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert diag_sm.real?, "Real sparse_matrix"
    assert !diag_sm.values.empty?, "Hash cannot be empty."
    assert !diag_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_diagonal_float
    #setup
    list = -9.01, 8.01, 3.01, 2.01, 1.01
    diag_sm = SparseMatrix.diagonal(*list)
    hash_diag = {[0, 0]=>-9.01, [1, 1]=>8.01, [2, 2]=>3.01, [3, 3]=>2.01, [4, 4]=>1.01}

    #pre
    list.each { |i|
      assert i.is_a?(Float), "All elements must be floats."
    }

    #data tests
    assert_equal Matrix[[-9.01, 0, 0, 0, 0], [0, 8.01, 0, 0, 0], [0, 0, 3.01, 0, 0], [0, 0, 0, 2.01, 0], [0, 0, 0, 0, 1.01]], diag_sm.full(), "Matrices must be the same."
    assert hash_diag.eql?(diag_sm.values), "Hashes must be the same."

    #post
    assert diag_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert diag_sm.real?, "Real sparse_matrix"
    assert !diag_sm.values.empty?, "Hash cannot be empty."
    assert !diag_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_diagonal_chars
    #setup
    list = 'a', 'b', 'c'
    diag_sm = SparseMatrix.diagonal(*list)
    hash_diag = {[0, 0]=>'a', [1, 1]=>'b', [2, 2]=>'c'}

    #pre
    list.each { |i|
      assert i.is_a?(String), "All elements must be floats."
    }

    #data tests
    assert_equal Matrix[[-9.01, 0, 0, 0, 0], [0, 8.01, 0, 0, 0], [0, 0, 3.01, 0, 0], [0, 0, 0, 2.01, 0], [0, 0, 0, 0, 1.01]], diag_sm.full(), "Matrices must be the same."
    assert hash_diag.eql?(diag_sm.values), "Hashes must be the same."

    #post
    assert diag_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert diag_sm.real?, "Real sparse_matrix"
    assert !diag_sm.values.empty?, "Hash cannot be empty."
    assert !diag_sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_initialize_identity
    sparse_matrix = SparseMatrix.identity(5)

    #post
    assert_equal  [1, 1, 1, 1, 1], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_identity_float
    sparse_matrix = SparseMatrix.identity(5.00)

    #post
    assert_equal  [1, 1, 1, 1, 1], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_identity_char
    begin
      SparseMatrix.identity  'a'
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Wrong exception thrown #{e}"
    else
      fail 'No Exception thrown'
    end
  end

  def test_initialize_zero
    sparse_matrix = SparseMatrix.zero(5)

    #post
    assert_equal  [], sparse_matrix.values
    assert_equal  [], sparse_matrix.val_row
    assert_equal  [], sparse_matrix.val_col
  end

  def test_initialize_zero_float
    sparse_matrix = SparseMatrix.zero(5.00)

    #post
    assert_equal  [], sparse_matrix.values
    assert_equal  [], sparse_matrix.val_row
    assert_equal  [], sparse_matrix.val_col
  end


  def test_initialize_zero_char
    begin
      SparseMatrix.zero  'a'
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Wrong exception thrown #{e}"
    else
      fail 'No Exception thrown'
    end
  end


  def test_compressed_format
    sparse_matrix = SparseMatrix.compressed_format([4, 1], [0, 0], [0, 2], 3, 2)

    #post
    assert_equal  [4, 1], sparse_matrix.values
    assert_equal  [0, 0], sparse_matrix.val_col
    assert_equal  [0, 2], sparse_matrix.val_row
  end


  def test_compressed_format_chars
    sparse_matrix = SparseMatrix.compressed_format(['a', 'b'], [0, 0], [0, 2], 3, 2)

    #post
    assert_equal  ['a', 'b'], sparse_matrix.values
    assert_equal  [0, 0], sparse_matrix.val_col
    assert_equal  [0, 2], sparse_matrix.val_row
  end

  def test_compressed_format_floats
    sparse_matrix = SparseMatrix.compressed_format([5.01, 5.01], [0, 0], [0, 2], 3, 2)

    #post
    assert_equal  [5.01, 5.01], sparse_matrix.values
    assert_equal  [0, 0], sparse_matrix.val_col
    assert_equal  [0, 2], sparse_matrix.val_row
  end

  def test_compressed_store
    sm = SparseMatrix[[0,0,0],[1,0,1],[0,0,2]]

    assert_equal [1, 1, 2], sm.values, "Incorrect values stored."
    assert_equal [0, 2, 2], sm.val_col, "Incorrect val_col stored."
    assert_equal [nil, 0, 2], sm.val_row, "First row has no non-zero elements so first element should be nil in val_row."
  end
end
