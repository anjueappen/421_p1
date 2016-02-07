
require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class AccessUnitTests < Test::Unit::TestCase
  def setup
    @sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
    @zero_matrix = SparseMatrix.zero(2)
    @sm_w_duplicates = SparseMatrix[[1,0], [0,2], [1,0]]
    @empty_matrix = SparseMatrix[[]]

    #pre
    assert @sparse_matrix.real?, "SparseMatrix should be real."
    assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
    assert_not_nil @sparse_matrix.val_col, "SparseMatrix val_col stored should not be nil"
  end

  def test_non_zero_count
    assert_equal 4, @sparse_matrix.nonzero_count(), "nonzero_count() method on a sparse matrix failed."
    assert_equal 4, @sparse_matrix.values.size, "SparseMatrix values storage incorrect."
    assert_equal 0, @zero_matrix.nonzero_count(), "nonzero_count() method on a zero matrix failed"
    assert_equal 0, @zero_matrix.values.size, "SparseMatrix values storage incorrect."

    #post
    assert_operator @sparse_matrix.nonzero_count, :>=, 0, "nonzero_count() method should return an integer."
  end

  def test_nonzeros
    assert_not_equal 0, @sparse_matrix.values.size, "SparseMatrix values stored should contain elements."
    assert_equal [1,2,3,4], @sparse_matrix.nonzeros(), "nonzeros() method failed."
    assert_equal 0, @zero_matrix.values.size, "SparseMatrix values stored should not contain elements for a zero matrix."

    #post
    assert !@sparse_matrix.nonzeros().empty?, "Result of nonzeros should not be empty if sparse_matrix is not a zero matrix."
    assert @zero_matrix.nonzeros().empty?, "Result of nonzeros should  be empty if sparse_matrix is a zero matrix."
  end

  def test_row_count
    assert_equal 4, @sparse_matrix.row_count(), "row_count() method failed."
    assert_equal 2, @zero_matrix.row_count(), "row_count() method failed on a zero matrix."
    
    #post
    assert_operator @sparse_matrix.row_count(), :>, 0, "Result of row_count must be greater than 0."
  end

  def test_column_count
    assert_equal 4, @sparse_matrix.column_count(), "column_count() method failed."
    assert_equal 2, @zero_matrix.row_count(), "column_count() method failed on a zero matrix."

    #post
    assert_operator @sparse_matrix.column_count(), :>, 0, "Result of column_count must be greater than 0."
  end

  def test_collect
    collect_result = @sparse_matrix.collect{|e| e}

    assert_equal collect_result, @sparse_matrix.full(), "These matrices should be equal."
  end

  def test_index
    assert_equal [1,1], @sm_w_duplicates.index(2), "Testing index() method for unique value failed."
    assert_equal [0,0], @sm_w_duplicates.index(1), "Testing index() method for value that occurs more than once in the matrix failed."
    assert_equal nil, @sm_w_duplicates.index(3), "Testing index(n) method for result when n does not exist in the matrix failed."

    #post
    assert_operator @sm_w_duplicates.index(1)[0], :>=, 0, "Indices returned should be positive."
    assert_operator @sm_w_duplicates.index(1)[1], :>=, 0, "Indices returned should be positive."
    assert_nil @sm_w_duplicates.index(3), "Result returned should be nil for elements that don't exist in the matrix."
  end

  def test_first_minor
    #setup
    # [ 0 1 0 ]
    # [ 0 1 0 ]
    # [ 0 1 0 ]
    sm = SparseMatrix[[0,1,0], [0,1,0], [0,1,0]]
    i = 0
    j = 0

    #pre
    assert_operator i, :<, sm.row_count, "Row specified must be less than the number of rows in the matrix."
    assert_operator j, :<, sm.column_count, "Column specified must be less than the number of columns in the matrix."
    assert_operator i, :>=, 0, "Row specified must be greater than or equal to 0."
    assert_operator j, :>=, 0, "Column specified must be greater than or equal to 0."

    #data tests
    new_sm = sm.first_minor(i,j)
    assert_equal Matrix[[1,0],[1,0]], new_sm, "first_minor() function failed."

    #post
    assert new_sm.is_a? SparseMatrix
    assert new_sm.real?
    assert_equal sm.row_count - 1, new_sm, "Row count should be decremented by 1."
    assert_equal sm.column_count - 1, new_sm, "Column count should be decremented by 1."
  end

  def test_cofactor
    sm = SparseMatrix[[1,0,0,0], [0,2,0,0], [0,0,3,0],[0,0,0,4]]

    #pre        
    assert @sparse_matrix.square?, "Matrix must be square to find cofactor."
    
    cofactor_matrix = @sparse_matrix.cofactor()
    assert_equal Matrix[[24,0,0,0], [0,12,0,0], [0,0,8,0],[0,0,0,6]], cofactor_matrix, "cofactor() method failed."

    #post 
    #size of original matrix must be equal to size of cofactor matrix
    assert_equal @sparse_matrix.column_count, cofactor_matrix.column_count, "Column counts of both matrices must be equal."
    assert_equal @sparse_matrix.row_count, cofactor_matrix.row_count, "Row counts of both matrices must be equal."
    assert cofactor_matrix.real?
  end

  def test_full
    assert_equal Matrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]], @sparse_matrix.full(), "Full matrix should be properly constructed from the SparseMatrix representation."

    assert_equal Matrix[[1,0], [0,2], [1,0]], @sm_w_duplicates.full(), "Full matrix should be properly constructed from the SparseMatrix representation."

    assert_equal Matrix[[0,0,0], [0,0,0], [0,0,0]], SparseMatrix.zero(3).full(), "Full matrix should be properly constructed from the SparseMatrix representation."
  end

  def test_full_empty
    assert_equal Matrix[[]], @empty_matrix.full(), "Empty matrix should be properly constructed from the SparseMatrix representation."
  end

  def test_to_s
    string_rep = @sparse_matrix.to_s
    assert_equal "[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]",
    string_rep, "to_s() method should be working."
  end

end

