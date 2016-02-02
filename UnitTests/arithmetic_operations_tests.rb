require 'test/unit'
require 'minitest/unit'
require '../sparse_matrix.rb'
require 'matrix'

=begin
	are we keeping Matrix.scalar?
	need invariants
=end

class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	#invariant
	#assert !@sparse_matrix.empty?
	# original matrix not changed - assert_same?
	
	# Addition
	def test_increase_all_values_by_int 
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		@expected_matrix = Matrix[[5,6,4],[6,4,4],[4,4,5]]
		@value = 4
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Integer), "Value is not an integer"
		
		#data tests
		@actual_matrix = @sparse_matrix.increase_all_values_by(@value)
		assert_equal @actual_matrix.full(), @expected_matrix, "Matrix values were not increased correctly."
		
		#post
		# are we going to delete the matrix used to add the scalar?
	end

	def test_increase_all_values_by_float
		#setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		@expected_matrix = Matrix[[5.45,6.45,4.45],[6.45,4.45,4.45],[4.45,4.45,5.45]]
		@value = 4.55
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Float), "Value is not a float"
		
		#data tests
		@actual_matrix = @sparse_matrix.increase_all_values_by(@value)
		assert_in_delta @actual_matrix.full(), @expected_matrix, 0.01, "Matrix values were not increased correctly."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
	end
	
	def test_addition_numeric_int
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		@value_to_add = 4
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_add.is_a? Integer), "Value is not an integer"
		
		#data tests  
		begin
			@sparse_matrix+(@value_to_add)
		rescue Exception => e
			if e.is_a? ErrOperationNotDefined
				pass "Correct exception raised"
			else
				fail "Incorrect excpetion raised"
			end
		end
		
		#post
		
	end
	
	def test_addition_numeric_float
		# setup
		@sparse_matrix = SparseMatrix[[1.20,2.20,0],[2.40,0,0],[0,0,1.04]]
		@value_to_add = 4.55
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_add.is_a? Float), "Value is not a float"
		
		#data tests  
		begin
			@sparse_matrix+(@value_to_add)
		rescue Exception => e
			if e.is_a? ErrOperationNotDefined
				pass "Correct exception raised"
			else
				fail "Incorrect excpetion raised"
			end
		end
		
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
		@result_matrix = @sparse_matrix1+(@sparse_matrix2)
		assert_equal @result_matrix.full(), Matrix[[5],[1],[0],[4]], "Vector addition failed"
		
	end

	def test_addition_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.04]]  #4x1
		@sparse_matrix2 = SparseMatrix[[1.01],[1.02],[0],[0]]  #4x1
				
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		@result_matrix =  @sparse_matrix1+(@sparse_matrix2)
		assert_in_delta @result_matrix.full(), Matrix[[5.05],[1.02],[0],[4.04]], 0.01, "Vector addition failed"
		
		
		#post
		
		
	end

	def test_addition_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		@sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		@expected_matrix = Matrix[[1,1,3],[0,0,3],[3,0,0],[0,3,0]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		@result_matrix = @sparse_matrix1+(@sparse_matrix2)
		assert_equal @result_matrix.full(), expected_matrix, "Integer matrix addition not working correctly"
		
		#post

	end

	def test_addition_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.02,0,0],[0,1.08,0]]
		@sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.06,0,0],[0,2.14,0]]
		@expected_matrix = Matrix[[1.08,1.16,3.14],[0,0,3.04],[3.08,0,0],[0,3.24,0]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		@result_matrix = @sparse_matrix1+(@sparse_matrix2)
		assert_in_delta @result_matrix.full(), expected_matrix, 0.01, "Float matrix addition not working correctly"
		
		#post
		
	end

	# Subraction
	def test_decrease_all_values_by_int
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0,0],[2,1,0,0],[1,0,1,0]]
		@expected_matrix = Matrix[[0,1,-1,-1],[1,0,-1,-1],[0,-1,0,-1]]
		@value = -1
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Integer), "Value is not an integer"
		
		#data tests
		@actual_matrix = @sparse_matrix.increase_all_values_by(@value)
		assert_equal @actual_matrix.full(), @expected_matrix, "Matrix values were not correctly decreased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
	end

	def test_decrease_all_values_by_float
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1],[1,2,0,0]]
		@expected_matrix = Matrix[[-0.5,0.5,-1.5],[0.5,-1.5,-1.5],[-1.5,-1.5,-0.5],[-0.5,0.5,-1.5,-1.5]]
		@value = -1.50
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Float), "Value is not a float"
		
		#data tests
		@actual_matrix = @sparse_matrix.increase_all_values_by(@value)
		assert_in_delta @actual_matrix.full(), @expected_matrix, 0.01, "Matrix values were not correctly decreased."
		
		#post
		# are we going to delete the matrix used to add the scalar?
		
		
	end

	def test_subtraction_numeric_int
		# setup
		@sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		@value_to_subtract = 4
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_subtract.is_a? Integer), "Value is not an integer"
		
		#data tests  
		begin
			@sparse_matrix-(@value_to_subtract)
		rescue Exception => e
			if e.is_a? ErrOperationNotDefined
				pass "Correct exception raised"
			else
				fail "Incorrect excpetion raised"
			end
		end
		
		#post
	end

	def test_subtraction_numeric_float
		# setup
		@sparse_matrix = SparseMatrix[[1.20,2.20,0],[2.40,0,0],[0,0,1.04]]
		@value_to_subtract = 4.55
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_subtract.is_a? Float), "Value is not a float"
		
		#data tests  
		begin
			@sparse_matrix-(@value_to_subtract)
		rescue Exception => e
			if e.is_a? ErrOperationNotDefined
				pass "Correct exception raised"
			else
				fail "Incorrect excpetion raised"
			end
		end
		
		#post
	end

	def test_subtraction_vector_int
		#setup
		@sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
		@sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  # 4x1
		@expected_matrix = Matrix[[3],[-1],[0],[4]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		@actual_matrix = @sparse_matrix1-(@sparse_matrix2)
		assert_equal @actual_matrix.full(), @expected_matrix, "Integer vector subtraction failed"
		
		#post
		
	end

	def test_subtraction_vector_float
		#setup
		@sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.02]]  #4x1
		@sparse_matrix2 = SparseMatrix[[4.01],[0],[0],[1.01]]  #4x1
		@expected_matrix = Matrix[[0.03],[0],[0],[3.01]]
		
		#pre
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		@actual_matrix =  @sparse_matrix1-(@sparse_matrix2)
		assert_in_delta @actual_matrix.full(), @expected_matrix, 0.01, "Float vector subtraction failed"
		
		#post

	end

	def test_subtraction_matrix_int
		#setup
		@sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		@sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		@expected = Matrix[[1,-1,3],[0,0,-1],[1,0,0],[0,-1,0]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		@actual_matrix = @sparse_matrix1-(@sparse_matrix2)
		assert_equal @actual_matrix.full(), @expected_matrix, "Integer matrix subtraction not working correctly"
		
		#post
		
	end

	def test_subtraction_matrix_float
		#setup
		@sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		@sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		@expected = Matrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		
		#pre
		assert @sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert @sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal @sparse_matrix1.row_count, @sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal @sparse_matrix1.column_count, @sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		@actual_matrix = @sparse_matrix1-(@sparse_matrix2)
		assert_in_delta @actual_matrix.full(), @expected_matrix, 0.01, "Float matrix subtraction not working correctly"
		
		#post
		
	end

	# Multiplication
	def test_multiplication_numeric_int
		#setup
		@sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		@value = 4
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Integer), "Value is not an integer"
		
		#data tests
		@actual_matrix =  @sparse_matrix*(@value)
		assert_equal @actual_matrix.values, Matrix[4,12,4,8], "Multiplication by integer - values vector incorrect"
		assert_equal @actual_matrix.full(), Matrix[[4,0,12],[0,0,4],[0,8,0]], "Multiplication of matrix by integer failed."
		
		#post
		 # same number of zeroes in new and old matrix
		 # old matrix did not change
		 # col and row vectors did not change
		
	end

	def test_multiplication_numeric_float
		#setup
		@sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		@value = 1.5
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Float), "Value is not a float"
		
		#data tests
		@actual_matrix =  @sparse_matrix*(@value)
		assert_equal @actual_matrix.values, [1.5,4.5,1.5,3], "Multiplication by float - values vector incorrect"
		assert_in_delta @actual_matrix.full(), Matrix[[1.5,0,4.5],[0,0,1.5],[0.3,0]], 0.01, "Multiplication of matrix by float failed."
		
		#post
		# same number of zeroes in new and old matrix
		# old matrix did not change
		# col and row vectors did not change
		 
	end

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
		@expected_matrix = @sparse_matrix1*(@sparse_matrix2)
		assert_equal @expected_matrix.values, [9,4,3], "Multiplication by vector(integer) - values vector incorrect "
		assert_equal @expected_matrix.full(), Matrix[[9],[4],[3]], "Multiplication of matrix by vector(integer) failed."
		
		#post
		# same number of zeroes in new and old matrix
		# old matrix did not change
		# col and row vectors did not change
	end

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
		@expected_matrix = @sparse_matrix1*(@sparse_matrix2)
		assert_in_delta @expected_matrix.values, [5.6101, 2.0604, 2.0503], 0.01, "Multiplication by vector(float) - values vector incorrect"
		assert_in_delta @expected_matrix.full(), Matrix[[5.6101],[2.0604],[2.0503]], 0.01, "Multiplication of matrix by vector(float) failed."
		
		#post
		# same number of zeroes in new and old matrix
		# old matrix did not change
		# col and row vectors did not change
		
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
		@actual_matrix = @sparse_matrix1*(@sparse_matrix2)
		assert_equal @actual_matrix.values,[3], "Multiplication by matrix(integer) - values vector incorrect"
		assert_equal @actual_matrix.full(),Matrix[[3,0],[0,0],[0,0]], "Multiplication of matrix by matrix(integer) failed."
		
		#post
		
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
		@actual_matrix = @sparse_matrix1*(@sparse_matrix2)
		assert_in_delta @actual_matrix.values,[3.0603], 0.01, "Multiplication by matrix(float) - values vector incorrect"
		assert_in_delta @actual_matrix.full(),Matrix[[3.0603,0],[0,0],[0,0]], 0.01, "Multiplication of matrix by matrix(float) failed."
		
		#post
		
		
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
		assert (@divisor.is_a? Integer), "Divisor is not an integer"
		assert_not_equal(0, @divisor, "divisor cannot be zero")
		
		#data tests
		@result_matrix = @sparse_matrix/(@divisor)
		assert_equal @result_matrix.values, Matrix[1,0.5,2,2], "Values vector incorrect after integer divsion"
		assert_in_delta @result_matrix.full(), [[1,0.5,0,0],[1.5,0,0,0],[0,2,2,0]], 0.01, "Integer divsion incorrect"
		
		#post
		# see multiplication_numeric_int
		
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
		assert (@divisor.is_a? Float), "Divisor is not a float"
		assert_not_equal(0, @divisor, "divisor cannot be zero")
		
		#data tests
		@result_matrix =  @sparse_matrix/(@divisor)
		assert_in_delta @result_matrix.values, Matrix[1,0.48,1.22,1.80,1.76], 0.01, "Values vector incorrect after float divsion"
		assert_in_delta @result_matrix.full(), Matrix[[1,0.48,0,0],[1.22,0,0,0],[0,1.80,1.76,0]], 0.01, "Float divsion incorrect"
		
		#post
		# see multiplication_numeric_float
		
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
		@result_matrix = @sparse_matrix1/(@sparse_matrix2)
		assert_in_delta @result_matrix.full(), Matrix[[0.5,0],[-0.10,0.6],[-0.5,1]], 0.01, "Integer matrix division failed"
		
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
		@result_matrix = @sparse_matrix1/(@sparse_matrix2)
		assert_in_delta @result_matrix.full(), Matrix[[0.49,0.01],[-0.474,0.774],[-0.317,0.967]], 0.01, "Float matrix division failed"
		
		#post
		
	end

	# Exponentiation
	def test_exponentiation_zero
		#setup
		@sparse_matrix = SparseMatrix[[0,2],[1,0]]
		@exponent = 0
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert @sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		@actual_matrix = @sparse_matrix**(@exponent)
		assert_equal @actual_matrix.full(), Matrix.identity(@sparse_matrix.row_count), "Matrix eponentiation failed"
		
		#post
		# same as matrix multiplication
	end
	
	def test_exponentiation_numeric_int
		#setup
		@sparse_matrix = SparseMatrix[[0,2,1],[1,0,0],[0,3,0]]
		@exponent = 2
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert @sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		@actual_matrix = @sparse_matrix**(@exponent)
		assert_equal @actual_matrix.full(), Matrix[[2,3,0],[0,2,1],[3,0,0]], "Integer matrix eponentiation failed"
		
		#post
		# same as matrix multiplication
	end
	
	def test_negative_exponentiation_int
		#setup
		@sparse_matrix = SparseMatrix[[0,1,1],[1,0,0],[0,1,0]]
		@exponent = -2
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert @sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		@actual_matrix = @sparse_matrix**(@exponent)
		assert_equal @actual_matrix.full(), Matrix[[0,0,1],[1,0,-1],[-1,1,1]], "Integer matrix eponentiation failed"
		
		#post
		# same as matrix multiplication
		
	end
	
	# todo won't store this here. just to remind me to do it
	def test_matrix_inverse
		#setup
		sparse_matrix = SparseMatrix[[2,4],[7,9]]
		
		#pre
		assert @sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil @sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix.square?, "Matrix is not square"
		assert !sparse_matrix.singular?, "Cannot take inverse - matrix is singular"
		
		#data tests
		@result_matrix = @sparse_matrix.inverse
		assert_in_delta @result_matrix, Matrix[[-0.9,0.4],[0.7,-0.2]], 0.01, "Matrix inversion failed"
		
		#post
		
	end
	
end
