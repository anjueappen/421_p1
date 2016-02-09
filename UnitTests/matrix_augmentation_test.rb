require 'test/unit'
require_relative '../sparse_matrix.rb'
require 'matrix'

class SparseMatrixAugmentationTest < Test::Unit::TestCase

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

  def checkMatrixAssertions(sm)
    assert sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !sm.values.empty?, "Hash cannot be empty."
    assert !sm.values.has_value?(0), "Hash only stores non-zero elements."
  end

  def test_add_integer
    #setup
    hash = {[0,0] => 1, [1,1] => 2}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)

    #data
    sm.putNonZero 5, 2, 2

    #post
    assert_equal Matrix[[1,0, 0], [0,2, 0], [0, 0, 5]], sm.full(), "Matrices must be equal."
    assert_equal 3, sm.row_count
    assert_equal 3, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)
  end

  def test_add_char
    #setup
    hash = {[0,0] => 'a', [1,1] => 'b'}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[['a', 0], [0, 'b']], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, String)
    checkMatrixAssertions(sm)

    #data
    sm.putNonZero 'c', 2, 2

    #post
    assert_equal Matrix[['a',0, 0], [0,'b', 0], [0, 0, 'c']], sm.full(), "Matrices must be equal."
    assert_equal 3, sm.row_count
    assert_equal 3, sm.column_count

    #invariant
    checkHashAssertions(hash, String)
    checkMatrixAssertions(sm)
  end

  def test_add_float
    #setup
    hash = {[0,0] => 1.01, [1,1] => 2.01}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1.01, 0], [0, 2.01]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Float)
    checkMatrixAssertions(sm)

    #data
    sm.putNonZero 3.01, 2, 2

    #post
    sm.full()
    Matrix[[1.01,0, 0], [0,2.01, 0], [0, 0, 3.01]]
    assert_equal Matrix[[1.01,0, 0], [0,2.01, 0], [0, 0, 3.01]], sm.full(), "Matrices must be equal."
    assert_equal 3, sm.row_count
    assert_equal 3, sm.column_count

    #invariant
    checkHashAssertions(hash, Float)
    checkMatrixAssertions(sm)
  end

  def test_overwrite
    #setup
    hash = {[0,0] => 1, [1,1] => 2}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1, 0], [0, 2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)

    #data
    sm.putNonZero 5, 0, 0

    #post
    assert_equal Matrix[[5,0], [0,2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)
  end

  def test_put_improper_args
    #setup
    hash = {[0,0] => 1, [1,1] => 2}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)

    begin
      sm.putNonZero 5, 4, 'a'
    rescue Exception => e
      assert_true (e.is_a? ArgumentError), "Incorrect exception raised #{e}"
    else
      fail 'No Exception thrown'
    end

    #post
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)
  end

  def test_add_zero
    #setup
    hash = {[0,0] => 1, [1,1] => 2}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)

    begin
      sm.putNonZero 5, 4, 'a'
    rescue Exception => e
      assert_true (e.is_a? ArgumentError), "Incorrect exception raised #{e}"
    else
      fail 'No Exception thrown'
    end

    #post
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)
  end

  def test_negative_indexes
    #setup
    hash = {[0,0] => 1, [1,1] => 2}
    sm = SparseMatrix.compressed_format(hash, 2, 2)

    #pre
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)

    begin
      sm.putNonZero 5, -1, -1
    rescue Exception => e
      assert_true (e.is_a? ArgumentError), "Incorrect exception raised #{e}"
    else
      fail 'No Exception thrown'
    end

    #post
    assert_equal Matrix[[1,0], [0,2]], sm.full(), "Matrices must be equal."
    assert_equal 2, sm.row_count
    assert_equal 2, sm.column_count

    #invariant
    checkHashAssertions(hash, Integer)
    checkMatrixAssertions(sm)
  end
end
