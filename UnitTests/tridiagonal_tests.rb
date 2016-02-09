require 'test/unit'
require '../tridiagonal_matrix.rb'

class TriDiagonalTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.

  def checkTriMatrixAssertions(tm)
    assert tm.is_a?(TridiagonalMatrix), "#{tm.class} must be a Tridiagonal matrix."
    assert_true tm.tridiagonal?
    assert !tm.mid_diagonal.include?(0), "Diagonal only stores non-zero elements."
    assert !tm.upper_diagonal.include?(0), "Diagonal only stores non-zero elements."
    assert !tm.lower_diagonal.include?(0), "Diagonal only stores non-zero elements."
  end

  def setup
    @tm = TridiagonalMatrix[[6, 5, 0], [3, 8, 6], [0, 2, 7]]

    #pre
    assert_equal 3, @tm.n
    assert_equal [6, 8, 7], @tm.mid_diagonal
    assert_equal [3, 2], @tm.lower_diagonal
    assert_equal [5, 6], @tm.upper_diagonal

    #invariant
    checkTriMatrixAssertions @tm
  end

  def test_init_empty
    #data
    @tm = TridiagonalMatrix.diagonals([], [], [])

    #post
    assert_equal 0, @tm.n
    assert_equal [], @tm.mid_diagonal
    assert_equal [], @tm.lower_diagonal
    assert_equal [], @tm.upper_diagonal
  end

  def test_init_diagonal

    #data
    @tm = TridiagonalMatrix.diagonals([5, 6], [6, 8, 7], [3, 2])

    #post
    assert_equal 3, @tm.n
    assert_equal [6, 8, 7], @tm.mid_diagonal
    assert_equal [3, 2], @tm.lower_diagonal
    assert_equal [5, 6], @tm.upper_diagonal
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
    assert_equal ['c', 'd', 'e'], @tm.mid_diagonal
    assert_equal ['a', 'b'], @tm.upper_diagonal
    assert_equal ['f', 'g'], @tm.lower_diagonal
  end


  def test_extend_diagonal_integers
    @tm.extend_diagonal(2, 3, 4)

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 3], @tm.mid_diagonal
    assert_equal [3, 2, 4], @tm.lower_diagonal
    assert_equal [5, 6, 2], @tm.upper_diagonal
  end


  def test_extend_diagonal_floats
    @tm.extend_diagonal(2.01, 3.01, 4.01)

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 3.01], @tm.mid_diagonal
    assert_equal [3, 2, 4.01], @tm.lower_diagonal
    assert_equal [5, 6, 2.01], @tm.upper_diagonal
  end

  def test_extend_diagonal_chars
    @tm.extend_diagonal('a', 'b', 'c')

    #post
    assert_equal 4, @tm.n
    assert_equal [6, 8, 7, 'b'], @tm.mid_diagonal
    assert_equal [3, 2, 'c'], @tm.lower_diagonal
    assert_equal [5, 6, 'a'], @tm.upper_diagonal

    #invariant
    checkTriMatrixAssertions(@tm)

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
    assert_true @tm.tridiagonal?
    assert_false @tm.sparse?

  end


  def test_full
    #data
    assert_equal Matrix[[6, 5, 0], [3, 8, 6], [0, 2, 7]], @tm.full(), "Incorrect Matrix conversion from Tridiagonal Matrix."

    #invariant
    checkTriMatrixAssertions @tm
  end

  def test_full_empty
    #setup
    @tm = TridiagonalMatrix.diagonals([], [], [])

    #data
    assert_equal Matrix.empty(0), @tm.full(), "Incorrect Matrix conversion from Tridiagonal Matrix."

    #invariant
    checkTriMatrixAssertions @tm
  end


  #tests to add: full, compress_store, for normal emxpty, zero, diagonal
  #test to ensure other matrix initializations aren't allowed .zero... and so on
end
