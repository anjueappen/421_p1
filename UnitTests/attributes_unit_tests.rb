=begin
@sparse?
@diagonal?
@empty?
@orthogonal?
@permutation?
@square? 
@zero?
@symmetric?
@unitary?	
@sparsity()
=end

require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class AttributesUnitTests < Test::Unit::TestCase
	def setup
		@max_degree_of_sparsity = 0.5	# to be considered a sparse matrix
		#invariants for all methods
		@sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
		@zero_matrix = SparseMatrix.zero(2)
		@identity_matrix = SparseMatrix.identity(2)
		@symmetric_matrix = SparseMatrix[[1,0,0], [0,0,1], [0,1,0]]
		@sparse_diag_matrix = SparseMatrix.diagonal(1,2,3,4)
		@empty_matrix = SparseMatrix[[]]


		#pre
		# matrices must be real
		assert @sparse_matrix.real?, "SparseMatrix must be real."
		assert @zero_matrix.real?, "Zero SparseMatrix must be real."
		assert @identity_matrix.real?, "Identity SparseMatrix must be real."
		assert @symmetric_matrix.real?, "Symmetric SparseMatrix must be real."
		assert @sparse_diag_matrix.real?, "Diagonal SparseMatrix must be real."

		#post: no change in state for all methods
	end

	def teardown
		# Nothing to teardown
	end

	def test_sparse?
		#setup
		matrix = SparseMatrix[[1,2,3,4],[5,6,7,8]]

		assert @sparse_matrix.sparse?, "SparseMatrix should be sparse."
		assert !matrix.sparse?, "Matrix should not be sparse anymore, possibly because of matrix manipulations."
	end

	def test_diagonal?
		assert sparse_diag_matrix.diagonal?, "This should be a diagonal matrix."
		assert !@sparse_matrix.diagonal?, "This should not be a diagonal matrix."
	end

	def test_empty?
		assert !@sparse_matrix .empty?, "Matrix should not be empty."
		assert !@zero_matrix.empty?, "Zero matrix should not be empty."
		assert @empty_matrix.empty?, "Empty matrix should be empty."
	end

	def test_orthogonal?
		assert @identity_matrix.orthogonal?, "Matrix should be orthogonal."
		assert !@sparse_matrix.orthogonal?, "Matrix should not be orthogonal."
	end

	def test_permutation?
		assert @identity_matrix.permutation?, "Identity matrix should be a permutation matrix."
		assert @sparse_matrix.permutation?, "Should not be a permutation matrix."
	end

	def test_square?
		#setup
    nonsquare_sm = SparseMatrix[[1,0,0],[0,1,0]]

		assert @sparse_matrix.square?, "Matrix should be square."
		assert !nonsquare_sm, "Matrix should not be square."
	end

	def test_zero?
		assert @zero_matrix.zero?, "Zero matrix should be zero."
		assert !@sparse_matrix.zero?, "Sparse matrix should not be zero."
	end

	def test_symmetric?
		assert @symmetric_matrix.symmetric?, "Matrix should be symmetric."
		assert @sparse_matrix.symmetric?, "Matrix should not be symmetric."
	end

	def test_unitary?
		assert @identity_matrix.unitary?, "Identity matrix should be unitary."
		assert !@sparse_matrix.unitary, "Sparse matrix should not be unitary."
	end

	def test_sparsity
		sparsity = @sparse_matrix.sparsity()
		assert_equal 0.25, sparsity, "Sparsity is the fraction of nonzero elements over the total number of elements."

		#post
		assert_operator sparsity, :>=, 0, "Sparsity should be greater than 0."
		assert_operator sparsity, :<=, @max_degree_of_sparsity, "Sparsity should be less than the maximum degree of sparsity to be considered a sparse matrix." 
	end
end

