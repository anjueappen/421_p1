
require '../sparse_matrix.rb'

class InitializationUnitTests < Test::Unit::TestCase


  def test_initialize_square_brackets_integers

    #execution
    sparse_matrix = SparseMatrix[[1,0], [0,2]]

    #post
    require 'test/unit'
    assert_true sparse_matrix.is_a? Matrix
    assert_equal [1, 2], sparse_matrix.values
    assert_equal [0, 1], sparse_matrix.val_row
    assert_equal [0, 1], sparse_matrix.val_col
  end

  def test_initialize_square_brackets_floats

    sparse_matrix = SparseMatrix[[1.00, 0.00], [0.00, 2.00]] #these should be coerced into integers

    #post
    assert_true sparse_matrix.is_a? Matrix
    assert_equal [1, 2], sparse_matrix.values
    assert_equal [0, 1], sparse_matrix.val_row
    assert_equal [0, 1], sparse_matrix.val_col
  end

  def test_initialize_square_brackets_chars

    sparse_matrix = SparseMatrix[['a', 0], ['c', 0]] #these should be allowed to iniitalize

    #post
    assert_true sparse_matrix.is_a? Matrix
    assert_equal ['a', 'c'], sparse_matrix.values
    assert_equal [0, 1], sparse_matrix.val_row
    assert_equal [0, 0], sparse_matrix.val_col
  end

  def test_initialize_val_row
    rows = [[1,0], [0,2]]
    sparse_matrix = SparseMatrix.rows  rows

    #post
    assert_true sparse_matrix.is_a? Matrix
    assert_equal [1, 2], sparse_matrix.values
    assert_equal [0, 1], sparse_matrix.val_row
    assert_equal [0, 1], sparse_matrix.val_col
  end

  def test_initialize_val_row_floats
    rows = [[1.00,0], [0,2.00]]
    sparse_matrix = SparseMatrix.rows  rows

    #post
    assert_true sparse_matrix.is_a? Matrix
    assert_equal [1, 2], sparse_matrix.values
    assert_equal [0, 1], sparse_matrix.val_row
    assert_equal [0, 1], sparse_matrix.val_col
  end

  def test_initialize_val_row_chars
    rows = [['d',0], [0,'a']]
    sparse_matrix = SparseMatrix.rows  rows

    #post
    assert_true sparse_matrix.is_a? Matrix
    assert_equal ['d', 'a'], sparse_matrix.values
    assert_equal  [0, 1], sparse_matrix.val_row
    assert_equal  [0, 1], sparse_matrix.val_col
  end

  def test_initialize_scalar
    sparse_matrix = SparseMatrix.scalar  3, 2

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [2, 2, 2], sparse_matrix.values
    assert_equal  [0, 1, 2], sparse_matrix.val_row
    assert_equal  [0, 1, 2], sparse_matrix.val_col
  end

  def test_initialize_scalar_chars
    sparse_matrix = SparseMatrix.scalar  'a', 2

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  ['a', 'a', 'a'], sparse_matrix.values
    assert_equal  [0, 1, 2], sparse_matrix.val_row
    assert_equal  [0, 1, 2], sparse_matrix.val_col
  end

  def test_initialize_scalar_float
    sparse_matrix = SparseMatrix.scalar  3.00, 2

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [2, 2, 2], sparse_matrix.values
    assert_equal  [0, 1, 2], sparse_matrix.val_row
    assert_equal  [0, 1, 2], sparse_matrix.val_col
  end

  def test_initialize_columns
    sparse_matrix = SparseMatrix.columns  [[1, 0, 1], [0, 2, 0]]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [1, 1, 2], sparse_matrix.values
    assert_equal  [0, 2, 1], sparse_matrix.val_row
    assert_equal  [0, 0, 1], sparse_matrix.val_col
  end


  def test_initialize_columns_floats
    sparse_matrix = SparseMatrix.columns  [[1.00, 0.00, 1.00], [0.00, 2.01, 0.00]]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [1.00, 1.00, 2.01], sparse_matrix.values
    assert_equal  [0, 2, 1], sparse_matrix.val_row
    assert_equal  [0, 0, 1], sparse_matrix.val_col
  end

  def test_initialize_columns_chars
    sparse_matrix = SparseMatrix.columns  [['a', 0], [0, 0]]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  ['a'], sparse_matrix.values
    assert_equal  [0], sparse_matrix.val_row
    assert_equal  [0], sparse_matrix.val_col
  end

  def test_initialize_diagonal
    sparse_matrix = SparseMatrix.diagonal  [-9, 8, 3, 2, 1]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [-9, 8, 3, 2, 1], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_diagonal_float
    sparse_matrix = SparseMatrix.diagonal  [-9.01, 8.01, 3,01, 2.01, 1,01]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [-9.01, 8.01, 3,01, 2.01, 1,01], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_diagonal_chars
    sparse_matrix = SparseMatrix.diagonal  ['a', 'b', 'c']

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  ['a', 'b', 'c'], sparse_matrix.values
    assert_equal  [0, 1, 2], sparse_matrix.val_row
    assert_equal  [0, 1, 2], sparse_matrix.val_col
  end

  def test_initialize_identity
    sparse_matrix = SparseMatrix.identity  5

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [1, 1, 1, 1, 1], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_identity_float
    sparse_matrix = SparseMatrix.identity  5.00

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [1, 1, 1, 1, 1], sparse_matrix.values
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_row
    assert_equal  [0, 1, 2, 3, 4], sparse_matrix.val_col
  end

  def test_initialize_identity_char
    begin
      SparseMatrix.identity  'a'
    rescue Exception => e
      if e.is_a? TypeError
        pass  "Error thrown for char"
      else
        fail "Wrong exception thrown"
      end
    end
  end

  def test_initialize_zero
    sparse_matrix = SparseMatrix.zero  5

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [], sparse_matrix.values
    assert_equal  [], sparse_matrix.val_row
    assert_equal  [], sparse_matrix.val_col
  end

  def test_initialize_zero_float
    sparse_matrix = SparseMatrix.zero  5.00

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [], sparse_matrix.values
    assert_equal  [], sparse_matrix.val_row
    assert_equal  [], sparse_matrix.val_col
  end


  def test_initialize_zero_char
    begin
      SparseMatrix.zero  'a'
    rescue Exception => e
      if e.is_a? TypeError
        pass  "Error thrown for char"
      else
        fail "Wrong exception thrown"
      end
    end
  end


  def test_compressed_format
    sparse_matrix = SparseMatrix.compressed_format  [4, 1], [0, 2], [0, 0]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [4, 1], sparse_matrix.values
    assert_equal  [0, 2], sparse_matrix.val_row
    assert_equal  [0, 0], sparse_matrix.val_col
  end


  def test_compressed_format_chars
    sparse_matrix = SparseMatrix.compressed_format  ['a', 'b'], [0, 2], [0, 0]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  ['a', 'b'], sparse_matrix.values
    assert_equal  [0, 2], sparse_matrix.val_row
    assert_equal  [0, 0], sparse_matrix.val_col
  end

  def test_compressed_format_floats
    sparse_matrix = SparseMatrix.compressed_format  [5.01, 5.01], [0, 2], [0, 0]

    #post
    assert_true  sparse_matrix.is_a? Matrix
    assert_equal  [5.01, 5.01], sparse_matrix.values
    assert_equal  [0, 2], sparse_matrix.val_row
    assert_equal  [0, 0], sparse_matrix.val_col
  end
end
