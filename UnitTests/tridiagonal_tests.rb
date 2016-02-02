require 'test/unit'

class TriDiagonalTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = TriDiagonalMatrix[[6, 5, 0], [3, 8, 6], [0, 2, 7]]

    #pre
    assert_equal 3, @sparse_matrix.row_count
    assert_equal 3, @sparse_matrix.col_count
    assert_equal [6, 5, 3, 8, 6, 2, 7], @sparse_matrix.values
    assert_equal [0, 0, 2, 2, 2, 3, 3], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2], @sparse_matrix.val_col

    #invariant
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?

  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  def test_init_diagonal
    @sparse_matrix = TriDiagonalMatrix.diagonal([5,6], [6, 8, 7], [3, 2])

    #post
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?
    assert_equal 3, @sparse_matrix.row_count
    assert_equal 3, @sparse_matrix.col_count
    assert_equal [6, 5, 3, 8, 6, 2, 7], @sparse_matrix.values
    assert_equal [0, 0, 1, 1, 1, 2, 2], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2], @sparse_matrix.val_col
  end

  def test_init_diagonal_improper_lengths
    begin
      @sparse_matrix = SparseMatrix.diagonal([5, 6, 5], [6, 8, 7], [3, 2])
    rescue Exception => e
      if e.is_a? ImproperDiagonalsError
        pass
      else
        fail "Incorect Exception Raised"
      end
    end
  end

  def test_init_diagonal_chars
    @sparse_matrix = SparseMatrix.diagonal(['a', 'b'], ['c', 'd', 'e'], ['f', 'g'])

    #post
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?
    assert_equal 3, @sparse_matrix.row_count
    assert_equal 3, @sparse_matrix.col_count
    assert_equal ['c', 'a', 'f', 'd', 'b', 'g', '3'], @sparse_matrix.values
    assert_equal [0, 0, 1, 1, 1, 2, 2], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2], @sparse_matrix.val_col
  end


  def test_extend_diagonal_integers
    @sparse_matrix.extend_diagonal(2, 3, 4)

    #invariant
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?

    #post
    assert_equal 4, @sparse_matrix.row_count
    assert_equal 4, @sparse_matrix.col_count
    assert_equal [6, 5, 3, 8, 6, 2, 7, 2, 3, 4], @sparse_matrix.values
    assert_equal [0, 0, 2, 2, 2, 3, 3, 2, 3, 3], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2, 3, 3, 2], @sparse_matrix.val_col
  end


  def test_extend_diagonal_floats
    @sparse_matrix.extend_diagonal(2.01, 3.01, 4.01)

    #invariant
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?

    #post
    assert_equal 4, @sparse_matrix.row_count
    assert_equal 4, @sparse_matrix.col_count
    assert_equal [6, 5, 3, 8, 6, 2, 7, 2.01, 3.01, 4.01], @sparse_matrix.values
    assert_equal [0, 0, 2, 2, 2, 3, 3, 2, 3, 3], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2, 3, 3, 2], @sparse_matrix.val_col
  end

  def test_extend_diagonal_chars
    @sparse_matrix.extend_diagonal('a', 'b', 'c')

    #invariant
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?

    #post
    assert_equal 4, @sparse_matrix.row_count
    assert_equal 4, @sparse_matrix.col_count
    assert_equal [6, 5, 3, 8, 6, 2, 7, 'a', 'b', 'c'], @sparse_matrix.values
    assert_equal [0, 0, 2, 2, 2, 3, 3, 2, 3, 3], @sparse_matrix.val_row
    assert_equal [0, 1, 0, 1, 2, 1, 2, 3, 3, 2], @sparse_matrix.val_col

  end

  def test_thomas_algorithm
    x = @sparse_matrix.solve_thomas([4, 4, 3])

    #invariant
    assert_true @sparse_matrix.is_a? TriDiagonalMatrix
    assert_true @sparse_matrix.is_tridiagonal?
    assert_equal 3, @sparse_matrix.row_count
    assert_equal 3, @sparse_matrix.col_count

    #post
    assert_equal [42/53, -8/53, 25/53], x
  end

  def test_thomas_algorithm_insufficient_length
    begin
      @sparse_matrix.solve_thomas([1])
    rescue Exception => e
      if e.is_a? InsufficientVectorLength
        pass "Correct exception raised"
      else
        fail "Incorrect excpetion raised"
      end
    end
  end

  def test_isTridiagonal_2x2
    @sparse_matrix = TriDiagonalMatrix[[1, 2], [3, 4]]
    assert_false @sparse_matrix.is_tridiagonal?
    assert_false @sparse_matrix.is_sparse?

  end
end
