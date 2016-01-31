require 'test/unit'
require_relative '../sparse_matrix.rb'
require 'matrix'

class MatrixAugmentationTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]

    #pre
    assert_true sparse_matrix.is_a? Matrix 
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
  def test_add_integer
    row = 3
    column = 3
    @sparse_matrix.putNonZero 5, row, column 

    #post
    assert_true sparse_matrix.is_a? Matrix 
    assert_equal [1, 2, 5], @sparse_matrix.values 
    assert_equal [0, 1, 3], @sparse_matrix.val_row 
    assert_equal [0, 1, 3], @sparse_matrix.val_col 
  end

  def test_add_char
    row = 3
    column = 3
    @sparse_matrix.putNonZero 'a', row, column 

    #post
    assert_true sparse_matrix.is_a? Matrix 
    assert_equal [1, 2, 'a'], @sparse_matrix.values 
    assert_equal [0, 1, 3], @sparse_matrix.val_row 
    assert_equal [0, 1, 3], @sparse_matrix.val_col 
  end

  def test_add_float
    row = 3
    column = 3
    @sparse_matrix.putNonZero 'a', row, column 

    #post
    assert_true sparse_matrix.is_a? Matrix 
    assert_equal [1, 2, 'a'], @sparse_matrix.values 
    assert_equal [0, 1, 3], @sparse_matrix.val_row 
    assert_equal [0, 1, 3], @sparse_matrix.val_col 
  end

  def test_overwrite
    row = 1
    column =  1
    @sparse_matrix.putNonZero 5, row, column 

    #post
    assert_true sparse_matrix.is_a? Matrix 
    assert_equal [1, 5], @sparse_matrix.values 
    assert_equal [0, 1], @sparse_matrix.val_row 
    assert_equal [0, 1], @sparse_matrix.val_col 
  end
end