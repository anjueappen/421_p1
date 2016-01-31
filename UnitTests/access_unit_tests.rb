=begin
#assert_block
#assert_equal
#assert_no_match
#assert_not_equal
#assert_not_nil
#assert_not_same
#assert_not_send
#assert_nothing_raised
#assert_nothing_thrown
#assert_raise
#assert_raise_with_message
#assert_respond_to
#assert_send
#assert_throw
=end
  
require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class AccessUnitTests < Test::Unit::TestCase

  def test_non_zero_count
    #setup
    sparse_matrix = SparseMatrix.new([[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]])

    #pre
    assert sparse_matrix.real?
    assert_not_nil sparse_matrix.values, "Sparse matrix values stored should not be nil"
    
    #data tests
    assert_equal 4, sparse_matrix.nonZeroCount(), "nonZerocount() method failed."
    assert_equal 4, sparse_matrix.values.size, "Sparse matrix values storage incorrect."
    
    #post


  end

  def test_nonzeros
    #setup
    sparse_matrix = SparseMatrix.new([[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]])

    #pre
    assert_not_nil sparse_matrix.values, "Sparse matrix values stored should not be nil"

    #data tests
    assert_equal [1,2,3,4], sparse_matrix.nonzeros(), "nonzeros() method failed."

    #post

  end

  def test_row_count
    #setup
    sparse_matrix = SparseMatrix.new([[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]])

    #pre        
    assert_not_nil sparse_matrix.val_row, "Sparse matrix row values stored should not be nil"

    #data tests
    assert_equal 4, sparse_matrix.row_count(), "row_count() method failed."

    #post

  end

  def test_column_count
    #setup
    sparse_matrix = SparseMatrix.new([[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]])

    #pre        
    assert_not_nil sparse_matrix.val_col, "Sparse matrix column values stored should not be nil"

    #data tests
    assert_equal 4, sparse_matrix.column_count(), "column_count() method failed."

    #post

  end

  def test_collect

  end

  def test_index
    #setup
    sparse_matrix = SparseMatrix.new([[1,0], [0,2], [1,0]])

    #pre        
    assert_not_nil sparse_matrix.values, "Sparse matrix row values stored should not be nil"

    #data tests
    assert_equal [1,1], sparse_matrix.index(2), "Testing index() method for unique value failed."
    assert_equal [[0,0], [2,0]], sparse_matrix.index(1), "Testing index() method for value that occurs more than once in the matrix failed."

    #post

  end

  def test_first_minor

  end

  def test_cofactor
    #setup
    sparse_matrix = SparseMatrix.new([[1,2,3], [0,4,5], [1,0,6]])

    #pre        
    assert sparse_matrix.square?, "Matrix must be square to find cofactor."

    #data tests
    # reference: http://www.mathwords.com/c/cofactor_matrix.htm
    assert_equal Matrix[[24,5,-4], [-12,3,2], [-2,-5,4]], sparse_matrix.cofactor(), "cofactor() method failed."

    #post

  end




end #end class

