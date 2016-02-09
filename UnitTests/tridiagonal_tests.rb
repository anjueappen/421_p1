require 'test/unit'
require '../tridiagonal_matrix.rb'

class TriDiagonalTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.

  def checkTriMatrixAssertions(sm)
    assert sm.is_a?(TridiagonalMatrix), "#{sm.class} must be a Tridiagonal matrix."
    assert !sm.values.empty?, "Hash cannot be empty."
    assert_true @tm.is_tridiagonal?
    assert !sm.mid_diagonal.has_value?(0), "Diagonal only stores non-zero elements."
    assert !sm.upper_diagonal.has_value?(0), "Diagonal only stores non-zero elements."
    assert !sm.lower_diagonal.has_value?(0), "Diagonal only stores non-zero elements."
  end

  def setup
    @tm = TridiagonalMatrix[[6, 5, 0], [3, 8, 6], [0, 2, 7]]

    #pre

    assert_equal 3, @tm.n
    assert_equal [6, 8, 7], @tm.mid_diagonal
    assert_equal [3, 2], @tm.val_row
    assert_equal [5, 6], @tm.val_col

    #invariant
    checkTriMatrixAssertions @tm

  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    #invariant
    checkTriMatrixAssertions(@tm)
  end

  def test_init_diagonal
    @tm = TriDiagonalMatrix.diagonal([5, 6], [6, 8, 7], [3, 2])

    #post
    assert_equal 3, @tm.n
    assert_equal [6, 8, 7], @tm.mid_diagonal
    assert_equal [3, 2], @tm.val_row
    assert_equal [5, 6], @tm.val_col
  end

  def test_init_diagonal_improper_lengths
    begin
      @tm = TridiagonalMatrix.diagonals([5, 6, 5], [6, 8, 7], [3, 2])
    rescue Exception => e
      if e.is_a? ImproperDiagonalsError
        pass
      else
        fail "Incorect Exception Raised"
      end
    end
  end

  def test_init_diagonal_chars
    @tm = TridiagonalMatrix.diagonals(['a', 'b'], ['c', 'd', 'e'], ['f', 'g'])

    #post
    assert_equal 3, @tm.n
    assert_equal ['a', 'd', 'g'], @tm.mid_diagonal
    assert_equal ['b', 'e'], @tm.val_row
    assert_equal ['c', 'f'], @tm.val_col
  end


  def test_extend_diagonal_integers
    @tm.extend_diagonal(2, 3, 4)

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 2], @tm.mid_diagonal
    assert_equal [3, 2, 3], @tm.val_row
    assert_equal [5, 6, 4], @tm.val_col
  end


  def test_extend_diagonal_floats
    @tm.extend_diagonal(2.01, 3.01, 4.01)

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 2.01], @tm.mid_diagonal
    assert_equal [3, 2, 3.01], @tm.val_row
    assert_equal [5, 6, 4.01], @tm.val_col
  end

  def test_extend_diagonal_chars
    @tm.extend_diagonal('a', 'b', 'c')

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 'a'], @tm.mid_diagonal
    assert_equal [3, 2, 'b'], @tm.val_row
    assert_equal [5, 6, 'c'], @tm.val_col

  end

  def test_thomas_algorithm
    x = @tm.solve_thomas([4, 4, 3])

    #invariant
    assert_true @tm.is_a? TridiagonalMatrix
    assert_true @tm.is_tridiagonal?
    assert_equal 3, @tm.row_count
    assert_equal 3, @tm.col_count

    #post
    assert_equal [42/53, -8/53, 25/53], x
  end

  def test_thomas_algorithm_insufficient_length
    begin
      @tm.solve_thomas([1])
    rescue Exception => e
      if e.is_a? InsufficientVectorLength
        pass "Correct exception raised"
      else
        fail "Incorrect excpetion raised"
      end
    end
  end

  def test_isTridiagonal_2x2
    @tm = TridiagonalMatrix[[1, 2], [3, 4]]
    assert_false @tm.is_tridiagonal?
    assert_false @tm.is_sparse?

  end
end
