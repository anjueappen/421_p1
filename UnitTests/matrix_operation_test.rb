require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class SparseMatrixOperationTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]

    #pre
    assert @sparse_matrix.is_a? SparseMatrix
    assert_equal [1, 2], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_det_not_square
    #setup
    @sparse_matrix = SparseMatrix[[1,0]]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix

    #pre
    assert_equal [1], @sparse_matrix.values
    assert_equal [0], @sparse_matrix.val_row
    assert_equal [0], @sparse_matrix.val_col

    begin
      @sparse_matrix.det
    rescue Exception => e
    else
          assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
          fail 'No Exception thrown'
    end
  end

  def test_det_ints
    assert_equal 2, @sparse_matrix.det

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [1, 2], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end


  def test_det_chars
    @sparse_matrix = SparseMatrix[['a', 0], [0, 'b']]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col


    begin
      @sparse_matrix.det
    rescue Exception => e
      assert_true (e.is_a? NoMethodError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_det_empty
    @sparse_matrix = SparseMatrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    begin
      @sparse_matrix.det
    #invariant
    rescue Exception => e
      assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col
  end

  def test_rank_ints
    #post
    assert_equal 2, @sparse_matrix.rank

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [1, 2], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_rank_chars
    @sparse_matrix = SparseMatrix[['a', 0], [0, 'b']]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col


    begin
      @sparse_matrix.rank
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_rank_empty
    @sparse_matrix = SparseMatrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    #post
    assert_equal 0, @sparse_matrix.rank
  end

  def test_transpose_ints
    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? SparseMatrix
    assert_equal [1, 2], transpose.values
    assert_equal [0, 1], transpose.val_row
    assert_equal [0, 1], transpose.val_col
  end

  def test_transpose_chars
    @sparse_matrix = SparseMatrix[['a', 0], [0, 'b']]



    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? SparseMatrix
    assert_equal ['a', 'b'], transpose.values
    assert_equal [0, 1], transpose.val_row
    assert_equal [0, 1], transpose.val_col
  end

  def test_transpose_empty
    @sparse_matrix = SparseMatrix[[], []]

    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? SparseMatrix
    assert_equal [], transpose.values
    assert_equal [], transpose.val_row
    assert_equal [], transpose.val_col
  end

  def test_trace_ints
    assert_equal 3, @sparse_matrix.trace
  end

  def test_trace_chars
    begin
      @sparse_matrix.trace
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    end
  end

  def test_trace_empty
    @sparse_matrix = SparseMatrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    trace = @sparse_matrix.trace

    #post
    assert_equal trace, 0

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

  end
end