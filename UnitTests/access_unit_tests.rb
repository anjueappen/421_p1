
require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class AccessUnitTests < Test::Unit::TestCase
  def setup
    @sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
    @zero_matrix = SparseMatrix.zero(2,2)

    #pre
    assert @sparse_matrix.real?, "SparseMatrix shouldbe real."
    assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
    assert_not_nil @sparse_matrix.val_col, "SparseMatrix val_col stored should not be nil"

  end

  def test_non_zero_count
    #setup
    #pre
    #data tests
    assert_equal 4, @sparse_matrix.nonzero_count(), "nonzero_count() method on a sparse matrix failed."
    assert_equal 4, @sparse_matrix.values.size, "SparseMatrix values storage incorrect."
    assert_equal 0, @zero_matrix.nonzero_count(), "nonzero_count() method on a zero matrix failed"
    assert_equal 0, @zero_matrix.values.size, "SparseMatrix values storage incorrect."

    #post: no change
  end

  def test_nonzeros
    #setup
    #pre
    #data tests
    assert_not_equal 0, @sparse_matrix.values.size, "SparseMatrix values stored should contain elements."
    assert_equal [1,2,3,4], @sparse_matrix.nonzeros(), "nonzeros() method failed."
    assert_equal 0, @zero_matrix.values.size, "SparseMatrix values stored should not contain elements for a zero matrix."

    #post: no change

  end

  def test_row_count
    #setup
    #pre
    #data tests
    assert_equal 4, @sparse_matrix.row_count(), "row_count() method failed."

    #post: no change

  end

  def test_column_count
    #setup
    #pre        
    #data tests
    assert_equal 4, @sparse_matrix.column_count(), "column_count() method failed."

    #post: no change

  end

  def test_collect
    # TODO: not sure how to test block argument that collect will take for pre-conditions (i.e. valid operation on elements in the matrix)
    #setup
    @sparse_matrix = SparseMatrix[[0,1,0],[2,0,0]]

    #pre
    assert !@sparse_matrix.empty?

    #data tests

    #post
  end

  def test_index
    #setup
    sm = SparseMatrix[[1,0], [0,2], [1,0]]

    #pre        
    assert sm.real?
    assert_not_nil sm.values, "Sparse matrix row values stored should not be nil"

    #data tests
    assert_equal [1,1], sm.index(2), "Testing index() method for unique value failed."
    assert_equal [0,0], sm.index(1), "Testing index() method for value that occurs more than once in the matrix failed."
    assert_equal nil, sm.index(3), "Testing index(n) method for result when n does not exist in the matrix failed."

    #post: no change

  end

  def test_first_minor
    #setup
    sm = SparseMatrix[[0,1,0], [0,1,0], [0,1,0]]
    i = 0
    j = 0
    # [ 0 1 0 ]
    # [ 0 1 0 ]
    # [ 0 1 0 ]

    #pre
    assert_operator i, :<, sm.row_count, "Row specified must be less than the number of rows in the matrix."
    assert_operator j, :<, sm.column_count, "Column specified must be less than the number of columns in the matrix."
    assert_operator i, :>=, 0, "Row specified must be greater than or equal to 0."
    assert_operator j, :>=, 0, "Column specified must be greater than or equal to 0."

    #data tests
    assert_equal Matrix[[1,0],[1,0]], sm.first_minor(i,j), "first_minor() function failed."

    #post: no change

  end

  def test_cofactor
    # TODO: sm must be a sparse matrix, so can't use example from link
    #setup
    sm = SparseMatrix[[1,2,3], [0,4,5], [1,0,6]]

    #pre        
    assert @sparse_matrix.square?, "Matrix must be square to find cofactor."

    #data tests
    # reference: http://www.mathwords.com/c/cofactor_matrix.htm
    assert_equal Matrix[[24,5,-4], [-12,3,2], [-2,-5,4]], @sparse_matrix.cofactor(), "cofactor() method failed."

    #post

  end

  def test_full
    #TODO
    #setup

    #pre

    #data tests

    #post
  end

  def test_to_s
    #TODO
    #setup

    #pre

    #data tests

    #post
  end

end #end class

