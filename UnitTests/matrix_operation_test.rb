require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'


class SparseMatrixOperationTests < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]
		@hash_sm = {[0,0]=>1, [1,1]=>2}
		
    #pre
    assert @sparse_matrix.is_a? SparseMatrix
		assert @sparse_matrix.real?, "SparseMatrix must be real."
		assert @hash_sm.eql?(@sparse_matrix.values), "Hashes must be equal"		
		
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_det_not_square
    #setup
    sparse_matrix1 = SparseMatrix[[1,0]]
		hash_sm1 = {[0,0]=>1}
		
		#pre
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal"	
		
    #invariant
    assert_true sparse_matrix1.is_a? SparseMatrix
		assert sparse_matrix1.real?, "SparseMatrix must be real."
		
    begin
      sparse_matrix1.det
    rescue Exception => e
    else
          assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
          fail 'No Exception thrown'
    end
		
		#invariant
    assert_true sparse_matrix1.is_a? SparseMatrix
		assert sparse_matrix1.real?, "SparseMatrix must be real."
		
  end

  def test_det_ints
    assert_equal 2, @sparse_matrix.det

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
		assert @sparse_matrix.real?, "SparseMatrix must be real."
		assert @hash_sm.eql?(@sparse_matrix.values), "Hashes must be equal"
		
  end


  def test_det_chars
    sparse_matrix_char = SparseMatrix[['a', 0], [0, 'b']]
		hash_sm_char = {[0,0]=>'a',[1,1]=>'b'}
		
		#invariant
    assert_true sparse_matrix_char.is_a? SparseMatrix
    assert hash_sm_char.eql?(sparse_matrix_char.values), "Hashes must be equal"
		
    begin
      sparse_matrix_char.det
    rescue Exception => e
      assert_true (e.is_a? NoMethodError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end
		
		#invariant
    assert_true sparse_matrix_char.is_a? SparseMatrix
    assert hash_sm_char.eql?(sparse_matrix_char.values), "Hashes must be equal"
		
  end

  def test_det_empty
    sparse_matrix_empty = SparseMatrix[[], []]

    #invariant
    assert_true sparse_matrix_empty.is_a? SparseMatrix
		assert (sparse_matrix_empty.values.empty?), "sparse matrix does not have empty values hash"

    begin
      sparse_matrix_empty.det
    #invariant
    rescue Exception => e
      assert_true (e.is_a? Matrix::ErrDimensionMismatch), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end
		
		#invariant
    assert_true sparse_matrix_empty.is_a? SparseMatrix
		assert (sparse_matrix_empty.values.empty?), "sparse matrix does not have empty values hash"
		
  end

  def test_rank_ints
    #post
    assert_equal 2, @sparse_matrix.rank

    #invariant
    assert_true @sparse_matrix.is_a? SparseMatrix
		assert @hash_sm.eql?(@sparse_matrix.values), "Hashes must be equal"
		
  end

  def test_rank_chars
    sparse_matrix_char = SparseMatrix[['a', 0], [0, 'b']]
		hash_sm_char = {[0,0]=>'a', [1,1]=>'b'}
		
    #invariant
    assert_true sparse_matrix_char.is_a? SparseMatrix
    assert hash_sm_char.eql?(sparse_matrix_char.values), "Hashes must be equal"

    begin
      sparse_matrix_char.rank
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    else
      fail 'No Exception thrown'
    end

    #invariant
    assert_true sparse_matrix_char.is_a? SparseMatrix
    assert hash_sm_char.eql?(sparse_matrix_char.values), "Hashes must be equal"
		
  end

  def test_rank_empty
    sparse_matrix_empty = SparseMatrix[[], []]

    #invariant
    assert_true sparse_matrix_empty.is_a? SparseMatrix
		assert (sparse_matrix_empty.values.empty?), "sparse matrix does not have empty values hash"

    #post
    assert_equal 0, sparse_matrix_empty.rank
		
  end

  def test_transpose_ints
    transpose = @sparse_matrix.transpose
		# transpose is [[1,0],[0,2]]
		hash_transpose = {[0,0]=>1, [1,1]=>2}
    
		# todo - feel like this isn't the correct way to check if the hash is correct?
		
		#post
		assert_true transpose.is_a? SparseMatrix
		assert transpose.real?, "SparseMatrix must be real."
		assert hash_transpose.eql?(transpose.values), "Hashes must be equal"
		
  end

  def test_transpose_chars
    sparse_matrix_char = SparseMatrix[['a', 0], [0, 'b']]
		hash_char = {[0,0]=>'a', [1,1]=>'b'}

		# todo - feel like this isn't the correct way to check if the hash is correct?
    transpose = sparse_matrix_char.transpose
		#hash_transpose = {[]=>, []=>}
		
    #post
    assert_true transpose.is_a? SparseMatrix
		assert hash_transpose.eql?(transpose.values), "Hashes must be equal"
		
  end

  def test_transpose_empty
    @sparse_matrix = SparseMatrix[[], []]

    transpose = @sparse_matrix.transpose

    #post
    assert_true transpose.is_a? SparseMatrix
    assert_equal [], transpose.values
    assert_equal [], transpose.val_row
    assert_equal [], transpose.val_col
  end

  def test_trace_ints
    assert_equal 3, @sparse_matrix.trace
  end

  def test_trace_chars
    begin
      @sparse_matrix.trace
    rescue Exception => e
      assert_true (e.is_a? TypeError), "Incorrect exception thrown: #{e}"
    end
  end

  def test_trace_empty
    sparse_matrix_trace_empty = SparseMatrix[[], []]

    #invariant
    assert_true sparse_matrix_trace_empty.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

    trace = sparse_matrix_trace_empty.trace

    #post
    assert_equal trace, 0

    #invariant
    assert_true sparse_matrix_trace_empty.is_a? SparseMatrix
    assert_equal [], @sparse_matrix.values
    assert_equal [], @sparse_matrix.val_row
    assert_equal [], @sparse_matrix.val_col

  end
end