require 'test/unit'
require_relative '../sparse_matrix.rb'
require 'matrix'

class MatrixAugmentationTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]

    #test-specific pre conditions
    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals([1, 2], @sparse_matrix.values)
    assertEquals([0, 1], @sparse_matrix.val_row)
    assertEquals([0, 1], @sparse_matrix.val_col)
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_add_integer
    row = 3
    column = 3
    @sparse_matrix.putNonZero(5, row, column)

    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals([1, 2, 5], @sparse_matrix.values)
    assertEquals([0, 1, 3], @sparse_matrix.val_row)
    assertEquals([0, 1, 3], @sparse_matrix.val_col)
  end

  def test_add_char
    row = 3
    column = 3
    @sparse_matrix.putNonZero('a', row, column)

    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals([1, 2, 'a'], @sparse_matrix.values)
    assertEquals([0, 1, 3], @sparse_matrix.val_row)
    assertEquals([0, 1, 3], @sparse_matrix.val_col)
  end

  def test_add_flaot
    row = 3
    column = 3
    @sparse_matrix.putNonZero('a', row, column)

    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals([1, 2, 'a'], @sparse_matrix.values)
    assertEquals([0, 1, 3], @sparse_matrix.val_row)
    assertEquals([0, 1, 3], @sparse_matrix.val_col)
  end

  def test_overwrite
    row = 1
    column =  1
    @sparse_matrix.putNonZero(5, row, column)

    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals([1, 5], @sparse_matrix.values)
    assertEquals([0, 1], @sparse_matrix.val_row)
    assertEquals([0, 1], @sparse_matrix.val_col)
  end
end