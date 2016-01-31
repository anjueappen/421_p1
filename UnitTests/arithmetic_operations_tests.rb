require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

=begin
	decide which will be delegated to matrix class and which
	will not be delegated
	
	are we keeping Matrix.scalar?
=end

class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	def increase_all_values_by
		# waiting on design decision.
		#will not stay here.
	end
	
	# Addition
	def test_increase_all_values_by_int 
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5,6,4],[6,4,4],[4,4,5]]
		@increase_by = 4
		
		#pre
		assert sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal sparse_matrix.increase_all_values_by(4), increased_values_matrix, "Matrix values were not correctly increased."
		#post
		
	end

	def test_increase_all_values_by_float
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5.4,6.4,4.4],[6.4,4.4,4.4],[4.4,4.4,5.4]]
		#pre
		
		#data tests
		
		#post
		
	end

	def test_addition_numeric_int
		#setup
		
		#pre
		
		#data tests
		
		#post
	end

	def test_addition_numeric_float
		#setup
		
		#pre
		
		#data tests
		
		#post
	end
	
	def test_addition_vector_int
		#pre
		
		#post
	end

	def test_addition_vector_float
		#pre
		
		#post
	end

	def test_addition_matrix_int
		
		#pre
		#dimensions must correspond
		
		#post

	end

	def test_addition_matrix_float
		#pre
		# dimensions must correspond
		
		#post
	end

	# Subraction
	def test_decrease_all_values_by_int
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
		#pre
		
		#data tests
		
		#post
		
	end

	def test_decrease_all_values_by_float
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
		#pre
		
		#data tests
		
		#post
		
	end


	def test_subtraction_numeric_int
		#pre
		
		#post
	end

	def test_subtraction_numeric_float
		#pre
		
		#post
	end

	def test_subtraction_vector_int
		#pre
		
		#post
	end

	def test_subtraction_vector_float
		#pre
		
		#post 	
	end

	def test_subtraction_matrix_int
		#pre
		
		#post
	end

	def test_subtraction_matrix_float
		#pre
		
		#post
	end

	# Multiplication
	def test_multiplication_numeric_int
		#pre
		
		#post
	end

	def test_multiplication_numeric_float
		#pre
		
		#post
	end

	def test_multiplication_vector_int
		#pre
		
		#post
	end

	def test_multiplication_vector_float
		#pre
		
		#post
	end

	def test_multiplication_matrix_int
		#pre
		
		#post
	end

	def test_multiplication_matrix_float
		#pre
		
		#post
	end

	# Division
	def test_division_numeric_int
		#pre
		
		#post
	end

	def test_divison_numeric_float
		#pre
		
		#post
	end

	def test_division_vector_int
		#pre
		
		#post
	end

	def test_division_vector_float
		#pre
		
		#post
	end

	def test_division_matrix_int
		#pre
		
		#post
	end

	def test_division_matrix_float
		#pre
		
		#post
	end

	
	# Exponentiation
	def test_exponentiation_numeric_int
		#pre
		
		#post
	end

	def test_exponentiation_numeric_float
		#pre
		
		#post

	end


	# Matrix Equality
	def test_matrix_equality
		#pre
		
		#post

	end
end

=begin
need to test @+() and @-() before deciding how to test them.

put equality tests here as well?
=end


=begin

todo:
	try a "non sparse matrix test" just to see our performance differences?
	test cases with 0 - specifically division, multiplication and exponentiation
		
	coerce values? currently assuming values are ok
	
	are we going to allow char addition? if so, how will we treat it?

	implement a sparsity calculator?
	
	operations on only non-zero values?
	
we are using ints, floats and chars
	- number
	- vector
	- matrix

different tests for ints and floats.  what is a good tolerance for floats?

=end