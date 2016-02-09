require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'


class SparseMatrixOperationTests < Test::Unit::TestCase


  def checkMatrixAssertions(sm)
    assert sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def checkHashAssertions(hash, valueType)
    hash.each_pair { |key, value|
      assert key.is_a?(Array), "Key must be an array."
      assert (key[0].is_a?(Integer) and key[1].is_a?(Integer)), "Keys must be integers."
      assert_operator key[0], :>=, 0, "Keys must be positive."
      assert_operator key[1], :>=, 0, "Keys must be positive."
      assert value.is_a?(valueType), "Values should be Integers."
    }
    assert !hash.has_value?(0), "Only non-zero elements can be stored."
  end

  def test_det_not_square
    #setup
    sm = SparseMatrix[[1,0]]
    hash = {[0,0]=>1}

    #pre
    assert hash.eql?(sm.values), "Hashes must be equal"

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    begin
      sm.det
    rescue Exception => e
      assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end

  def test_det_ints
    #setup
    sm = SparseMatrix[[1,0], [0, 2]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    #data
    assert_equal 2, sm.det

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end


  def test_det_chars
    sm = SparseMatrix[['a', 0], [0, 'b']]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

    begin
      sm.det
    rescue Exception => e
      assert_true (e.is_a? NoMethodError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

  end

  def test_det_empty
    sm = SparseMatrix[[], []]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    begin
      sm.det
    rescue Exception => e
      assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

  end

  def test_rank_ints
    #setup
    sm = SparseMatrix[[1,0], [0, 2]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    #data
    assert_equal 2, sm.rank

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end

  def test_rank_chars
    sm = SparseMatrix[['a', 0], [0, 'b']]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

    begin
      sm.rank
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

  end

  def test_rank_empty
    sm = SparseMatrix[[], []]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    #post
    assert_equal 0, sm.rank

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)


  end

  def test_transpose_ints
    #setup
    sm = SparseMatrix[[1,2], [0, 0]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    #data
    transpose = sm.transpose
    hash_transpose = {[0,0]=>1, [1, 0]=>2}

    #post
    checkMatrixAssertions(transpose)
    assert hash_transpose.eql?(transpose.values), "Hashes must be equal"

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

  end

  def test_transpose_chars
    sm = SparseMatrix[['a', 'b'], [0, 0]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

    # todo - feel like this isn't the correct way to check if the hash is correct?
    transpose = sm.transpose
    hash_transpose = {[0, 0]=> 'a', [1, 0]=> 'b'}

    #post
    assert_true transpose.is_a? SparseMatrix
    assert hash_transpose.eql?(transpose.values), "Hashes must be equal"

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)
  end

  def test_transpose_empty
    sm = SparseMatrix[[], []]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    transpose = sm.transpose
    hash_transpose = {}

    #post
    assert_true transpose.is_a? SparseMatrix
    assert hash_transpose.eql?(transpose.values), "Hashes must be equal"

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end

  def test_trace_ints
    #setup
    sm = SparseMatrix[[1,0], [0, 2]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    #data
    assert_equal 3, sm.trace

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end

  def test_trace_chars
    #setup
    sm = SparseMatrix[['a', 'b'], [0, 0]]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)

    begin
      sm.trace
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    end

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, String)
  end

  def test_trace_empty
    sm = SparseMatrix[[], []]

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)

    trace = sm.trace

    #data
    assert_equal trace, 0

    #invariant
    checkMatrixAssertions(sm)
    checkHashAssertions(sm.values, Integer)
  end
end