require 'test/unit'

class MatrixOperationTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]

    #pre
    assert_true @sparse_matrix.is_a? Matrix
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
    assert_true @sparse_matrix.is_a? Matrix

    #pre
    assert_equal [1], @sparse_matrix.values
    assert_equal [0], @sparse_matrix.val_row
    assert_equal [0], @sparse_matrix.val_col

    begin
      @sparse_matrix.det
    rescue Exception => e
      if e.is_a? ErrDimensionMismatch
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
  end

  def test_det_ints
    assert_equal 2, @sparse_matrix.det

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [1, 2], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end


  def test_det_chars
    @sparse_matrix = Matrix[['a', 0], [0, 'b']]

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col

    begin
      dt = @sparse_matrix.det
    rescue Exception => e
      if e.is_a? NoMethodError
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_det_empty
    @sparse_matrix = Matrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    begin
      rank = @sparse_matrix.rank
    rescue Exception => e
      if e.is_a? ErrDimensionMismatch
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col
  end

  def test_rank_ints
    #post
    assert_equal 2, @sparse_matrix.rank

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [1, 2], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_rank_chars
    @sparse_matrix = Matrix[['a', 0], [0, 'b']]

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col

    begin
      @sparse_matrix.rank
    rescue Exception => e
      if e.is_a? NoMethodError
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal ['a', 'b'], @sparse_matrix.values
    assert_equal [0, 1], @sparse_matrix.val_row
    assert_equal [0, 1], @sparse_matrix.val_col
  end

  def test_rank_empty
    @sparse_matrix = Matrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    #post
    assert_equal 0, @sparse_matrix.rank
  end

  def test_transpose_ints
    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? Matrix
    assert_equal transpose, @sparse_matrix.transpose
  end

  def test_transpose_chars
    @sparse_matrix = Matrix[['a', 0], [0, 'b']]

    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? Matrix
    assert_equal transpose, @sparse_matrix.transpose
  end

  def test_transpose_empty
    @sparse_matrix = Matrix[[], []]

    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? Matrix
    assert_equal transpose, @sparse_matrix.transpose
  end

  def test_trace_ints
    assert_true 3, @sparse_matrix.trace
  end

  def test_trace_chars
    begin
      @sparse_matrix.trace
    rescue Exception => e
      if e.is_a? TypeError
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
  end

  def test_trace_empty
    @sparse_matrix = Matrix[[], []]

    #invariant
    assert_true @sparse_matrix.is_a? Matrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    begin
      @sparse_matrix.trace
    rescue Exception => e
      if e.is_a? ErrDimensionMismatch
        pass "Correct exception thrown"
      else
        fail "Incorrect exception thrown"
      end
    end
  end
end