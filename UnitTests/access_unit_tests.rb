require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

#invariant to add
# Object should remain the same after these methods are called

class AccessUnitTests < Test::Unit::TestCase

  def setup
    @sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
		@hash_sm = {[0,0]=>1, [1,1]=>2, [2,0]=>3,[3,3]=>4}
		
		@zero_matrix = SparseMatrix.zero(2)
    @hash_zero = {}
    
		@sm_w_duplicates = SparseMatrix[[1,0], [0,2], [1,0]]
    @hash_duplicates = {[0,0]=>1, [1,1]=>2, [2,0]=>1}
		
		@empty_matrix = SparseMatrix[[]]

    @diag_sm = SparseMatrix.diagonal(1,2,3,4)
    @hash_diag = {[0,0]=>1, [1,1]=>2, [2,2]=>3, [3,3]=>4}

    #pre
    # Must be SparseMatrix objects
    assert @sparse_matrix.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert @sm_w_duplicates.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert @diag_sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."

    # Must be real
    assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert @sm_w_duplicates.real?, "SparseMatrix should be real."
    assert @diag_sm.real?, "SparseMatrix should be real."

    # Hashes should equal what's stored in the SparseMatrix values
		assert @hash_sm.eql?(@sparse_matrix.values), "Hashes must be equal"
		assert @hash_duplicates.eql?(@sm_w_duplicates.values), "Hashes must be equal"
    assert @hash_diag.eql?(@diag_sm.values), "Hashes must be equal."
		assert @zero_matrix.values.empty?, "zero sparse matrix does not have empty value hash"
		assert @empty_matrix.values.empty?, "empty sparse matrix does not have empty value hash"

    # Hash only stores non-zero elements
    assert !@sparse_matrix.values.has_value?(0), "Hash only stores non-zero elements."
    assert !@sm_w_duplicates.values.has_value?(0), "Hash only stores non-zero elements."
    assert !@diag_sm.values.has_value?(0), "Hash only stores non-zero elements."

	end

  def test_non_zero_count
    assert_equal 4, @sparse_matrix.nonzero_count(), "nonzero_count() method on a sparse matrix failed."
    assert_equal 4, @sparse_matrix.values.size, "SparseMatrix values storage incorrect."
    assert_equal 0, @zero_matrix.nonzero_count(), "nonzero_count() method on a zero matrix failed"
    assert_equal 0, @zero_matrix.values.size, "SparseMatrix values storage incorrect."
    assert_equal 3, @sm_w_duplicates.nonzero_count(), "nonzero_count() method on a zero matrix failed"
    assert_equal 3, @sm_w_duplicates.values.size, "SparseMatrix values storage incorrect."

    #post
    assert_operator @sparse_matrix.nonzero_count, :>=, 0, "nonzero_count() method should return a positive integer."
    assert_operator @zero_matrix.nonzero_count, :>=, 0, "nonzero_count() method should return a positive integer."
    assert_operator @sm_w_duplicates.nonzero_count, :>=, 0, "nonzero_count() method should return a positive integer."
  end

  def test_nonzeros
    assert_not_equal 0, @sparse_matrix.values.size, "SparseMatrix values stored should contain elements."
		assert @hash_sm.eql?(@sparse_matrix.nonzeros()), "nonzeros() method failed."
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
    assert_operator @zero_matrix.row_count(), :>, 0, "Result of row_count must be greater than 0."
  end

  def test_column_count
    assert_equal 4, @sparse_matrix.column_count(), "column_count() method failed."
    assert_equal 2, @zero_matrix.column_count(), "column_count() method failed on a zero matrix."

    #post
    assert_operator @sparse_matrix.column_count(), :>, 0, "Result of column_count must be greater than 0."
    assert_equal 2, @zero_matrix.column_count(), "column_count() method failed on a zero matrix."
  end

  def test_collect
    collect_result = @sparse_matrix.collect{|e| e}

    assert_equal @sparse_matrix.full(), collect_result.full(), "These matrices should be equal."
  end

  def test_index
    assert_equal [1,1], @sm_w_duplicates.index(2), "Testing index() method for unique value failed."
    assert_equal [0,0], @sm_w_duplicates.index(1), "Testing index() method for value that occurs more than once in the matrix failed."
    assert_equal nil, @sm_w_duplicates.index(3), "Testing index(n) method for result when n does not exist in the matrix failed."

    #post
    assert (@sm_w_duplicates.index(1)[0].is_a?(Integer) and @sm_w_duplicates.index(1)[1].is_a?(Integer)), "Indices returned should be an integer."
    assert_operator @sm_w_duplicates.index(1)[0], :>=, 0, "Indices returned should be positive."
    assert_operator @sm_w_duplicates.index(1)[1], :>=, 0, "Indices returned should be positive."
    assert_nil @sm_w_duplicates.index(3), "Result returned should be nil for elements that don't exist in the matrix."
  end

  def test_first_minor
    #setup
    # [ 1 0 0 0 ]
    # [ 0 2 0 0 ]
    # [ 3 0 0 0 ]
    # [ 0 0 0 4 ]
    i = 0
    j = 0

    #pre
    assert_operator i, :<, @sparse_matrix.row_count, "Row specified must be less than the number of rows in the matrix."
    assert_operator j, :<, @sparse_matrix.column_count, "Column specified must be less than the number of columns in the matrix."
    assert_operator i, :>=, 0, "Row specified must be greater than or equal to 0."
    assert_operator j, :>=, 0, "Column specified must be greater than or equal to 0."

    #data tests
    result_sm = @sparse_matrix.first_minor(i,j)
    
		assert_equal Matrix[[2,0,0],[0,0,0],[0,0,4]], result_sm.full(), "first_minor() function failed."

    #post
    assert result_sm.is_a?(SparseMatrix), "Result must also be a SparseMatrix"
    assert result_sm.real?, "Result must be real"
    assert_equal @sparse_matrix.row_count - 1, result_sm.row_count, "Row count should be decremented by 1."
    assert_equal @sparse_matrix.column_count - 1, result_sm.column_count, "Column count should be decremented by 1."
  end

  def test_cofactor
    #setup
    i = 0
    j = 0

    #pre        
    assert @diag_sm.square?, "Matrix must be square to find cofactor."
		assert !@diag_sm.empty?, "Can't find cofactor of empty matrix. Not defined."
    assert_operator i, :<, @sparse_matrix.row_count, "Row specified must be less than the number of rows in the matrix."
    assert_operator j, :<, @sparse_matrix.column_count, "Column specified must be less than the number of columns in the matrix."
    assert_operator i, :>=, 0, "Row specified must be greater than or equal to 0."
    assert_operator j, :>=, 0, "Column specified must be greater than or equal to 0."

    # check cofactors of all indices
    # for i in 0..3 
    #   for j in 0..3 
    #     puts i.to_s.concat(',').concat(j.to_s).concat(" : ")
    #     .concat(@diag_sm.cofactor(i,j).to_s)
    #   end
    # end

    assert_equal 24, @diag_sm.cofactor(0,0), "cofactor() method failed."
    assert_equal 12, @diag_sm.cofactor(1,1), "cofactor() method failed."
    assert_equal 8, @diag_sm.cofactor(2,2), "cofactor() method failed."
    assert_equal 6, @diag_sm.cofactor(3,3), "cofactor() method failed."

    result = @diag_sm.cofactor(0,0)
    
    #post
    assert result.is_a?(Integer), "Cofactor result must be an integer."

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
    assert_equal "SparseMatrix[[1, 0, 0, 0], [0, 2, 0, 0], [3, 0, 0, 0], [0, 0, 0, 4]]",
    string_rep, "to_s() method should be working."
  end

end

