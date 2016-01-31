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
    assert_equal 4, sparse_matrix.row_count()

    #post

  end


end #end class

