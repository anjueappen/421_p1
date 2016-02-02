require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

=begin
	are we keeping Matrix.scalar?
	need invariants
=end

class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	#invariant
	assert !sparse_matrix.empty?
	# original matrix not changed
	
	# Addition
	def test_increase_all_values_by_int 
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5,6,4],[6,4,4],[4,4,5]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix.increase_all_values_by(4), increased_values_matrix, "Matrix values were not correctly increased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
	end

	def test_increase_all_values_by_float
		#setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		increased_values_matrix = SparseMatrix[[5.45,6.45,4.45],[6.45,4.45,4.45],[4.45,4.45,5.45]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix.increase_all_values_by(4.45), increased_values_matrix, "Matrix values were not correctly increased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
	end
	
	# this test currently is meant to throw exception
	def test_addition_numeric_int
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		#assert values not char?
		#value is_a Matrix
		# assert_true @@sparse_matrix.is_a? Matrix
		
		#data tests
		#@sparse_matrix Matrix.+(4)
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
		#setup
		@sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
		@sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  #4x1
				
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		assert_equal sparse_matrix1-(sparse_matrix2).values, [5,1,4]
		assert_equal sparse_matrix1-(sparse_matrix2).val_row, []
		assert_equal sparse_matrix1-(sparse_matrix2).val_col, []
		
	end

	def test_addition_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.04]]  #4x1
		@sparse_matrix2 = SparseMatrix[[1.01],[1.02],[0],[0]]  #4x1
				
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		assert_equal sparse_matrix1-(sparse_matrix2).values, [5.05,1.02,4.04]
		assert_equal sparse_matrix1-(sparse_matrix2).val_row, []
		assert_equal sparse_matrix1-(sparse_matrix2).val_col, []
		
		#post
		assert_equal sparse_matrix1-(sparse_matrix2).row_count, 4
		assert_equal sparse_matrix1-(sparse_matrix2).column_count, 1
		
	end

	def test_addition_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		@sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		expected_after_addition = SparseMatrix[[1,1,3],[0,0,3],[3,0,0],[0,3,0]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		assert_equal @sparse_matrix1+(@sparse_matrix2), expected_after_addition, "Matrix addition not working correctly"
		
		#post

	end

	def test_addition_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.02,0,0],[0,1.08,0]]
		@sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.06,0,0],[0,2.14,0]]
		expected_after_addition = SparseMatrix[[1.08,1.16,3.14],[0,0,3.04],[3.08,0,0],[0,3.24,0]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		#can't be coerced into full matrix, so can't delegate currently
		assert_equal @sparse_matrix1+(@sparse_matrix2), expected_after_addition, "Matrix addition not working correctly"
		
		#post
		
		
	end

	# Subraction
	def test_decrease_all_values_by_int
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0,0],[2,1,0,0],[1,0,1,0]]
		decreased_values_matrix = SparseMatrix[[0,1,-1,-1],[1,0,-1,-1],[0,-1,0,-1]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix.increase_all_values_by(-1), decreased_values_matrix, "Matrix values were not correctly increased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
	end

	def test_decrease_all_values_by_float
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1],[1,2,0,0]]
		decreased_values_matrix = SparseMatrix[[-0.5,0.5,-1.5],[0.5,-1.5,-1.5],[-1.5,-1.5,-0.5],[-0.5,0.5,-1.5,-1.5]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix.increase_all_values_by(-1.50), decreased_values_matrix, "Matrix values were not correctly decreased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
		
	end

	# throw exception
	def test_subtraction_numeric_int
		#pre
		
		#post
	end

	# throw exception
	def test_subtraction_numeric_float
		#pre
		
		#post
	end

	def test_subtraction_vector_int
		#setup
		@sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
		@sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  # 4x1
				
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		assert_equal sparse_matrix1-(sparse_matrix2).values, [3,-1,4]
		assert_equal sparse_matrix1-(sparse_matrix2).val_row, []
		assert_equal sparse_matrix1-(sparse_matrix2).val_col, []
		
		#post
		assert_equal sparse_matrix1-(sparse_matrix2).row_count, 4
		assert_equal sparse_matrix1-(sparse_matrix2).column_count, 1
	end

	def test_subtraction_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.02]]  #4x1
		@sparse_matrix2 = SparseMatrix[[4.01],[0],[0],[1.01]]  #4x1
				
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		assert_equal sparse_matrix1-(sparse_matrix2).values, [0.03,3.01]
		assert_equal sparse_matrix1-(sparse_matrix2).val_row, []
		assert_equal sparse_matrix1-(sparse_matrix2).val_col, []
		
		#post
		assert_equal sparse_matrix1-(sparse_matrix2).row_count, 4
		assert_equal sparse_matrix1-(sparse_matrix2).column_count, 1
	end

	def test_subtraction_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		@sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		expected_after_subtraction = SparseMatrix[[1,-1,3],[0,0,-1],[1,0,0],[0,-1,0]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		assert_equal @sparse_matrix1-(@sparse_matrix2), expected_after_subtraction, "Matrix subtraction not working correctly"
		
		#post
		
	end

	def test_subtraction_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		@sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		expected_after_subtraction = SparseMatrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		assert_equal @sparse_matrix1+(@sparse_matrix2), expected_after_subtraction, "Matrix subtraction not working correctly"
		
		#post
		
	end

	# Multiplication
	def test_multiplication_numeric_int
		#setup
		@sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix*(4).values, [4,12,4,8] 
		
		#post
		  
		
	end

	def test_multiplication_numeric_float
		#setup
		@sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		assert_equal @sparse_matrix*(1.5).values, [1.5,4.5,1.5,3] 
		
		#post
		
	end

	# will return a vector
	def test_multiplication_vector_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,0,3,4],[0,0,0,2],[1,0,0,1]] #3x4
		@sparse_matrix2 = SparseMatrix[[1],[0],[0],[2]] #4x1
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		assert_equal @sparse_matrix1*(sparse_matrix2).values, [9,4,3]
		
		#post
		assert_equal @sparse_matrix1*(sparse_matrix2).row_count, 1
		assert_equal @sparse_matrix1*(sparse_matrix2).column_count, 3
	end

	# will return a vector
	def test_multiplication_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.01,0,3.03,4.50],[0,0,0,2.02],[1.01,0,0,1.01]]  #3x4
		@sparse_matrix2 = SparseMatrix[[1.01],[0],[0],[1.02]] #4x1
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		assert_equal @sparse_matrix1*(sparse_matrix2).values, [5.6101, 2.0604, 2.0503]
		
		#post
		assert_equal @sparse_matrix1*(sparse_matrix2).row_count, 1
		assert_equal @sparse_matrix1*(sparse_matrix2).column_count, 3
		
	end

	def test_multiplication_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[0,0,1,0],[0,2,0,2],[0,1,0,2]]  #3x4
		@sparse_matrix2 = SparseMatrix[[0,1],[0,0],[3,0],[0,0]]  #4x2
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		# data tests
		assert_equal @sparse_matrix1*(sparse_matrix2).values,[3]
		
		#post
		assert_equal @sparse_matrix1*(sparse_matrix2).row_count, 3
		assert_equal @sparse_matrix1*(sparse_matrix2).column_count, 2
	end

	def test_multiplication_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[0,0,1.01,0],[0,2.05,0,2.50],[0,1.20,0,2.02]]  #3x4
		@sparse_matrix2 = SparseMatrix[[0,1.04],[0,0],[3.03,0],[0,0]]  #4x2
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		assert_equal @sparse_matrix1*(sparse_matrix2).values,[3.0603]
		
		#post
		assert_equal @sparse_matrix1*(sparse_matrix2).row_count, 3
		assert_equal @sparse_matrix1*(sparse_matrix2).column_count, 2
		
	end

	# Division
	def test_division_numeric_int
		#setup
		@sparse_matrix = SparseMatrix[[2,1,0,0],[3,0,0,0],[0,4,4,0]]
		@divisor = 2
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert @divisor.real?, "Divisor should be real."
		assert_not_nil @divisor,  "Divisor should not be nil."
		assert_not_equal(0, @divisor, "divisor cannot be zero")
		
		#data tests
		assert_equal @sparse_matrix/(@divisor).full, [[1,0.5,0,0],[1.5,0,0,0],[0,2,2,0]]
		
		#post
		
	end

	def test_divison_numeric_float
		#setup
		@sparse_matrix = SparseMatrix[[2.50,1.20,0,0],[3.05,0,0,0],[0,4.50,4.40,0]]
		@divisor = 2.50
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert @divisor.real?, "Divisor should be real."
		assert_not_nil @divisor,  "Divisor should not be nil."
		assert_not_equal(0, @divisor, "divisor cannot be zero")
		
		#data tests
		assert_equal @sparse_matrix/(@divisor).full, [[1,0.48,0,0],[1.22,0,0,0],[0,1.80,1.76,0]]
		
		#post
		
	end
	
	# no implementation in matrix class - not valid
	def test_division_vector_int
		#setup
		@sparse_matrix1 = SparseMatrix[[],[],[]]
		@sparse_matrix2 = SparseMatrix[]
		
		#pre
		
		#post
	end
	# no implementation in matrix class
	def test_division_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[],[],[]]
		@sparse_matrix2 = SparseMatrix[]
		
		#pre
		
		#post
	end

	def test_division_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,2],[4,5],[6,7]]
		@sparse_matrix2 = SparseMatrix[[2,4],[7,9]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"
		
		#data tests
		assert_equal (@sparse_matrix1/(@sparse_matrix2)).full, [[0.5,0],[-0.10,0.6],[-0.5,1]]
		
		#post
		
	end

	def test_division_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.10,2.10],[4.50,5.10],[6.20,7.50]]
		@sparse_matrix2 = SparseMatrix[[2.10,4.10],[7.10,9.10]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"  ############################## todo when are these initialized?
		
		
		#data tests
		assert_equal (@sparse_matrix1/(@sparse_matrix2)).full, [[0.49,0.01],[-0.474,0.774],[-0.317,0.967]]
		
		#post
		
	end

	
	# Exponentiation
	def test_exponentiation_numeric_int
		#setup
		@sparse_matrix1 = SparseMatrix[[],[],[]]
		
		#pre
		
		#post
	end

	def test_exponentiation_numeric_float
		#setup
		@sparse_matrix1 = SparseMatrix[[],[],[]]
		@sparse_matrix2 = SparseMatrix[]
		
		#pre
		
		#data tests
		
		#post
	end
	
	#todo test case where exponent is zero?
	
	def test_negative_exponentiation_int
		#setup
		@sparse_matrix1 = SparseMatrix[[],[],[]]
		@sparse_matrix2 = SparseMatrix[]
		
		#pre
		
		#data tests
		
		#post
		
	end
	


	# Matrix Equality
	def test_matrix_equality
		#setup
		@sparse_matrix = SparseMatrix[]
		
		#pre
		
		#post

	end
	
	# todo won't store this here. just to remind me to do it
	def test_matrix_inverse
	
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
	

	implement a sparsity calculator?
	
	operations on only non-zero values?
	
	worry about really big and really small numbers for floats
	
	in terms of post - will have to have resulting matrix with different dimensions for * and /
	in terms of invariants, will need to have original matrices untouched because things return new matrices
	
we are using ints, floats and chars
	- number
	- vector
	- matrix

different tests for ints and floats.  what is a good tolerance for floats?
need two tests? worried about tolerance for floats.
what about chars?
do we always have to ask if a method can call things? or has that method?
=end