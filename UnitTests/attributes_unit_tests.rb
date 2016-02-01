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
=end

require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

class AttributesUnitTests < Test::Unit::TestCase
	def setup
		#invariants for all methods
		@sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
		@zero_matrix = SparseMatrix.zero(2,2)

		#pre
		assert @sparse_matrix.real?, "SparseMatrix must be real."

		
	end

	def teardown

	end

	def test_sparse?
		#setup
		#pre

		#data tests
		assert @sparse_matrix.sparse?, "SparseMatrix must have sparse attribute."
		
		#post
	end

	def test_diagonal?
		#setup
		sparse_diag_matrix = SparseMatrix.diagonal(1,2,3,4)

		#pre
		assert @sparse_matrix.real?, "SparseMatrix must be real."

		#data tests
		assert sparse_diag_matrix.diagonal?, "This should be a diagonal matrix."
		assert !@sparse_matrix.diagonal?, "This should not be a diagonal matrix."

		#post
	end

	def test_empty?
		#setup
		#pre
		#data tests
		assert !@sparse_matrix.empty?, "Matrix should not be empty."

		#post
	end

	def test_orthogonal?
		#setup
		#pre
		assert @sparse_matrix.square?, "Matrix must be square."

		#data tests
		#post
	end

	def test_permutation?
		#setup
		#pre
		#data tests
		#post
	end

	def test_square?
		#setup
    nonsquare_sm = SparseMatrix[[1,0,0],[0,1,0]]
		#pre
		#data tests
		assert @sparse_matrix.square?, "Matrix should be square."
		assert !nonsquare_sm, "Matrix should not be square."

		#post
	end

	def test_zero?
		#setup
		#pre
		#data tests
		assert @zero_matrix.zero?, "Zero matrix should be zero."
		assert !@sparse_matrix.zero?, "Sparse matrix should not be zero."
		#post
	end

	def test_symmetric?
		#TODO
		#setup
		#pre
		#data tests
		#post
	end

	def test_unitary?
		#TODO
		#setup

		#pre
		#data tests
		#post
	end
end