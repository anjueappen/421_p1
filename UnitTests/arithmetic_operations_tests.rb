require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

=begin
	are we keeping Matrix.scalar?
	need invariants
=end

class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	# Addition
	def test_increase_all_values_by_int 
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5,6,4],[6,4,4],[4,4,5]]
		
		#pre
		assert sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil sparse_matrix.values, "SparseMatrix values stored should not be nil."
		#assert values not char?
		
		#data tests
		assert_equal sparse_matrix.increase_all_values_by(4), increased_values_matrix, "Matrix values were not correctly increased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
	end

	def test_increase_all_values_by_float
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5.45,6.45,4.45],[6.45,4.45,4.45],[4.45,4.45,5.45]]
		
		#pre
		assert sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil sparse_matrix.values, "SparseMatrix values stored should not be nil."
		# assert values not char?
		
		#data tests
		assert_equal sparse_matrix.increase_all_values_by(4.45), increased_values_matrix, "Matrix values were not correctly increased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
	end
	
	# this test currently is meant to throw exception
	def test_addition_numeric_int
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
		#pre
		assert sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil sparse_matrix.values, "SparseMatrix values stored should not be nil."
		#assert values not char?
		#value is_a Matrix
		# assert_true @sparse_matrix.is_a? Matrix
		
		#data tests
		#sparse_matrix Matrix.+(4)
		#assert_raise(Matrix.ErrOperationNotDefined)  
		
		#post
		
	end
	
	#this test is currently meant to throw exception
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
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		expected_after_addition = SparseMatrix[[1,1,3],[0,0,3],[3,0,0],[0,3,0]]
		
		#pre
		assert_equal sparse_matrix1.row_count, sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		#can't be coerced into full matrix, so can't delegate currently
		assert_equal sparse_matrix1+(sparse_matrix2), expected_after_addition, "Matrix addition not working correctly"
		
		#post

	end

	def test_addition_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.02,0,0],[0,1.08,0]]
		sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.06,0,0],[0,2.14,0]]
		expected_after_addition = SparseMatrix[[1.08,1.16,3.14],[0,0,3.04],[3.08,0,0],[0,3.24,0]]
		
		#pre
		assert_equal sparse_matrix1.row_count, sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		#can't be coerced into full matrix, so can't delegate currently
		assert_equal sparse_matrix1+(sparse_matrix2), expected_after_addition, "Matrix addition not working correctly"
		
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
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		expected_after_subtraction = SparseMatrix[[1,-1,3],[0,0,-1],[1,0,0],[0,-1,0]]
		
		#pre
		assert_equal sparse_matrix1.row_count, sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		#can't be coerced into full matrix, so can't delegate currently
		assert_equal sparse_matrix1-(sparse_matrix2), expected_after_subtraction, "Matrix subtraction not working correctly"
		
		#post
		
	end

	def test_subtraction_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		expected_after_subtraction = SparseMatrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		
		#pre
		assert_equal sparse_matrix1.row_count, sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		#can't be coerced into full matrix, so can't delegate currently
		assert_equal sparse_matrix1+(sparse_matrix2), expected_after_subtraction, "Matrix subtraction not working correctly"
		
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
	
	worry about really big and really small numbers for floats
	
we are using ints, floats and chars
	- number
	- vector
	- matrix

different tests for ints and floats.  what is a good tolerance for floats?

=end