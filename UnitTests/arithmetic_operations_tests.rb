require 'test/unit'
require 'minitest/unit'
require '../sparse_matrix.rb'
require 'matrix'

# todo assert in all posts that resulting matrix is a sparse matrix
class ArithmeticOperationsUnitTests < Test::Unit::TestCase
	
	def checkHashAssertions(hash, valueType)
    hash.each_pair { |key, value|
      assert key.is_a?(Array), "Key must be an array."
      assert (key[0].is_a?(Integer) and key[1].is_a?(Integer)), "Keys must be integers."
      assert_operator key[0], :>=, 0, "Keys must be positive."
      assert_operator key[1], :>=, 0, "Keys must be positive."
      assert value.is_a?(valueType), "Values should be Integers."
    }
    assert !hash.has_value?(0), "Only non-zero elements can be stored."
  end

  def checkMatrixAssertions(sm, sc)
    assert sm.is_a?(SparseMatrix), "Object must be a SparseMatrix."
    assert !@sm.empty?
		assert !sm.values.empty?, "Hash cannot be empty."
    assert !sm.values.has_value?(0), "Hash only stores non-zero elements."
		assert_equal  sc.full(),  sm.full(), "Original matrix was altered."
  end
	
	# Addition
	def test_increase_all_values_by_int 
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [2,2]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 
		expected_matrix = Matrix[[5,6,4],[6,4,4],[4,4,5]]
		hash_expected = {[0,0]=>5, [0,1]=>6, [0,2]=>4, [1,0]=>6, [1,1]=>4, [1,2]=>4, [2,0]=>4, [2,1]=>4, [2,2]=>5}
		 
		value = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix.increase_all_values_by(value)
		assert_equal  actual_matrix.full(),  expected_matrix, "Matrix values were not increased correctly."
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	def test_increase_all_values_by_float
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [2,2]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 
		expected_matrix = Matrix[[5.45,6.45,4.45],[6.45,4.45,4.45],[4.45,4.45,5.45]]
		hash_expected = {[0,0]=>5.45,[0,1]=>6.45,[0,2]=>4.45,[1,0]=>6.45,[1,1]=>4.45,[1,2]=>4.45,[2,0]=>4.45,[2,1]=>4.45,[2,2]=>5.45}
		 
		value = 4.55
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix.increase_all_values_by(@value)
		for row in 0..actual_matrix.row_count-1
			for col in 0..actual_matrix.column_count-1
				assert_in_delta  actual_matrix.full().rows(row)[col],  expected_matrix.rows(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_addition_numeric_int
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [2,2]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		value_to_add = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value_to_add.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests  
		begin
			sparse_matrix+(value_to_add)
		rescue Exception => e
			assert_true (e.is_a? ErrOperationNotDefined), "Incorrect exception thrown: #{e}"
		else
			fail 'No Exception thrown'
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_addition_numeric_float
		# setup
		sparse_matrix = SparseMatrix[[1.20,2.20,0],[2.40,0,0],[0,0,1.04]]
		hash_sm = {[0,0]=>1.20, [0,1]=>2.20, [1,0]=>2.40, [2,2]=>1.04}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		value_to_add = 4.55
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_add.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests  
		begin
			sparse_matrix+(value_to_add)
		rescue Exception => e
			assert_true (e.is_a? ErrOperationNotDefined), "Incorrect exception thrown: #{e}"
		else
			fail 'No Exception thrown'
		end
	
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_addition_vector_int
		#setup
		sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
		hash_sm1 = {[0,0]=>4, [3,0]=>4}
		sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  #4x1
		hash_sm2 = {[0,0]=>1,[1,0]=>1}
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 
		hash_expected = {[0,0]=>5,[1,0]=>1,[3,0]=>4}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1+(sparse_matrix2)
		assert_equal  result_matrix.full(), Matrix[[5],[1],[0],[4]], "Vector addition failed"
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_addition_vector_float
		#setup
		sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.04]]  #4x1
		hash_sm1 = {[0,0]=>4.04,[3,0]=>4.04}
		
		sparse_matrix2 = SparseMatrix[[1.01],[1.02],[0],[0]]  #4x1
		hash_sm2 = {[0,0]=>1.01,[1,0]=>1.02}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[5.05],[1.02],[0],[4.04]]
		hash_expected = {[0,0]=>5.05, [1,0]=>1.02, [3,0]=>4.04}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1+(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().rows(row)[col],  expected_matrix.rows(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_addition_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		hash_sm1 = {[0,0]=>1,[0,2]=>3, [1,2]=>1, [2,0]=>2, [3,1]=>1} 
		sparse_matrix2 = SparseMatrix[[0,1,0],[0,2,0],[1,0,0],[0,-2,-1]]
		hash_sm2 = {[0,1]=>1,[1,1]=>2, [2,0]=>1, [3,1]=>-2, [3,2]=>-1}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1,1,3],[0,2,1],[3,0,0],[0,-1,-1]]
		hash_expected = {[0,0]=>1,[0,1]=>1, [0,2]=>3, [1,1]=>2, [1,2]=>1, [2,0]=>3, [3,1]=>-1, [3,2]=>-1}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix = sparse_matrix1+(sparse_matrix2)
		assert_equal  result_matrix.full(), expected_matrix, "Integer matrix addition not working correctly"
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_addition_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[-1.08,0,3.14],[0,0,1.00],[2.02,0,0],[0,1.08,0]]
		hash_sm1 = {[0,0]=>-1.08, [0,2]=>3.14, [1,2]=>1.00, [2,0]=>2.02, [3,1]=>1.08}
		
		sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.06,0,0],[0,2.14,0]]
		hash_sm2 = {[0,1]=>1.16,[1,2]=>2.04,[2,0]=>1.06,[3,1]=>2.14}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[-1.08,1.16,3.14],[0,0,3.04],[3.08,0,0],[0,3.24,0]]
		hash_expected = {[0,0]=>-1.08, [0,1]=>1.16, [0,2]=>3.14, [1,2]=>3.04, [2,0]=>3.08, [3,1]=>3.24}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1+(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().rows(row)[col],  expected_matrix.rows(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end
	
	# Subraction
	def test_decrease_all_values_by_int
		# setup
		sparse_matrix = SparseMatrix[[1,2,0,0],[2,1,0,0],[1,0,1,0]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [1,1]=>1, [2,0]=>1, [2,2]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 
		expected_matrix = Matrix[[0,1,-1,-1],[1,0,-1,-1],[0,-1,0,-1]]
		hash_expected = {[0,1]=>1, [0,2]=>-1, [0,3]=>-1, [1,0]=>1, [1,2]=>-1, [1,3]=>-1, [2,1]=>-1, [2,3]=>-1}
		
		value = -1
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =  sparse_matrix.increase_all_values_by(value)
		assert_equal  result_matrix.full(),  expected_matrix, "Matrix values were not correctly decreased."
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)

	end

	def test_decrease_all_values_by_float
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1],[1,2,0]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [2,2]=>1, [3,0]=>1, [3,1]=>2}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		expected_matrix = Matrix[[-0.5,0.5,-1.5],[0.5,-1.5,-1.5],[-1.5,-1.5,-0.5],[-0.5,0.5,-1.5]]
		
		value = -1.50
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Float), "Value is not a float"

		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix.increase_all_values_by(value)
		assert_in_delta  actual_matrix.full(),  expected_matrix, 0.01, "Matrix values were not correctly decreased."
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	def test_subtraction_numeric_int
		# setup
		 sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		 value_to_subtract = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_subtract.is_a? Integer), "Value is not an integer"
		
		#data tests  
		begin
			 sparse_matrix-(@value_to_subtract)
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
		 sparse_matrix = SparseMatrix[[1.20,2.20,0],[2.40,0,0],[0,0,1.04]]
		 value_to_subtract = 4.55
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value_to_subtract.is_a? Float), "Value is not a float"
		
		#data tests  
		begin
			 sparse_matrix-(@value_to_subtract)
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
		 sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
		 sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  # 4x1
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 expected_matrix = Matrix[[3],[-1],[0],[4]]
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		 actual_matrix =  sparse_matrix1-(@sparse_matrix2)
		assert_equal  actual_matrix.full(),  expected_matrix, "Integer vector subtraction failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		
	end

	def test_subtraction_vector_float
		#setup
		 sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.02]]  #4x1
		 sparse_matrix2 = SparseMatrix[[4.01],[0],[0],[1.01]]  #4x1
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 expected_matrix = Matrix[[0.03],[0],[0],[3.01]]
		
		#pre
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
		
		#data tests
		 actual_matrix =   sparse_matrix1-(@sparse_matrix2)
		assert_in_delta  actual_matrix.full(),  expected_matrix, 0.01, "Float vector subtraction failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
	end

	def test_subtraction_matrix_int
		#setup
		 sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		 sparse_matrix2 = SparseMatrix[[0,1,0],[0,0,2],[1,0,0],[0,2,0]]
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 expected = Matrix[[1,-1,3],[0,0,-1],[1,0,0],[0,-1,0]]
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		 actual_matrix =  sparse_matrix1-(@sparse_matrix2)
		assert_equal  actual_matrix.full(),  expected_matrix, "Integer matrix subtraction not working correctly"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		
	end

	def test_subtraction_matrix_float
		#setup
		 sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		 sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 expected = Matrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		
		#data tests
		 actual_matrix =  sparse_matrix1-(@sparse_matrix2)
		assert_in_delta  actual_matrix.full(),  expected_matrix, 0.01, "Float matrix subtraction not working correctly"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		
	end

	# Multiplication
	def test_multiplication_numeric_int
		#setup
		 sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]

		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 value = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Integer), "Value is not an integer"
		
		#data tests
		 actual_matrix =   sparse_matrix*@value
		assert_equal  actual_matrix.column_count, 3, "incorrect column count"
		assert_equal  actual_matrix.row_count, 3 , "incorrect row count"
		assert_equal  actual_matrix.values, [4,12,4,8], "Multiplication by integer - values vector incorrect"
		assert_equal  actual_matrix.full(), Matrix[[4,0,12],[0,0,4],[0,8,0]], "Multiplication of matrix by integer failed."
		
		#post

		#invariant
		assert (@actual_matrix.is_a? SparseMatrix), "failed. resulting matrix is not of class SparseMatrix"
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert_equal  sparse_clone.val_row,  actual_matrix.val_row, "fail. val_row changed"
		assert_equal  sparse_clone.val_col,  actual_matrix.val_col, "fail. val_col changed"
		assert !@sparse_matrix.empty?
		
	end
	
	def test_multiplication_numeric_zero
		#setup
		 sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 value = 0
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Integer), "Value is not an integer"
		
		#data tests
		 actual_matrix =   sparse_matrix*(@value)
		assert_equal  actual_matrix.values,[], "Multiplication by integer - values array incorrect"
		assert_equal  actual_matrix.val_row,[], "Multiplication by integer - val_row array incorrect"
		assert_equal  actual_matrix.val_col,[], "Multiplication by integer - val_col array incorrect"
		
		#invariant
		assert_equal  actual_matrix.full(), Matrix.zero(@sparse_matrix.row_count,@sparse_matrix.column_count), "Multiplication of matrix by 0 failed."
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert !@sparse_matrix.empty?
		
	end
	
	def test_multiplication_numeric_float
		#setup
		 sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 value = 1.5
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@value.is_a? Float), "Value is not a float"
		
		#data tests
		 actual_matrix =   sparse_matrix*(@value)
		 values_reference = [1.5,4.5,1.5,3]
		for i in 0..@actual_matrix.values.length-1
			assert_in_delta  actual_matrix.values[i],  values_reference[i], 0.01, "Multiplication by float - values vector incorrect"
		end
		
		 expected_matrix = Matrix[[1.5,0,4.5],[0,0,1.5],[0,3,0]]
		for i in 0..@sparse_clone.row_count-1
			for j in 0..@sparse_clone.column_count-1
				assert_in_delta  actual_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01,  "Multiplication of matrix by float failed."
			end
		end
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert_equal  sparse_clone.val_row,  actual_matrix.val_row, "fail. val_row changed"
		assert_equal  sparse_clone.val_col,  actual_matrix.val_col, "fail. val_col changed"
		assert !@sparse_matrix.empty?
		 
	end

	def test_multiplication_vector_int
		#setup
		 sparse_matrix1 = SparseMatrix[[1,0,3,4],[0,0,0,2],[1,0,0,1]] #3x4
		 sparse_matrix2 = SparseMatrix[[1],[0],[0],[2]] #4x1
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		 expected_matrix =  sparse_matrix1*(@sparse_matrix2)
		assert_equal  expected_matrix.values, [9,4,3], "Multiplication by vector(integer) - values vector incorrect "
		assert_equal  expected_matrix.full(), Matrix[[9],[4],[3]], "Multiplication of matrix by vector(integer) failed."
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"
		
	end

	def test_multiplication_vector_float
		#setup
		 sparse_matrix1 = SparseMatrix[[1.01,0,3.03,4.50],[0,0,0,2.02],[1.01,0,0,1.01]]  #3x4
		 sparse_matrix2 = SparseMatrix[[1.01],[0],[0],[1.02]] #4x1
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		 expected_matrix =  sparse_matrix1*(@sparse_matrix2)
		assert_in_delta  expected_matrix.values, [5.6101, 2.0604, 2.0503], 0.01, "Multiplication by vector(float) - values vector incorrect"
		assert_in_delta  expected_matrix.full(), Matrix[[5.6101],[2.0604],[2.0503]], 0.01, "Multiplication of matrix by vector(float) failed."
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"
		
	end

	def test_multiplication_matrix_int
		#setup
		 sparse_matrix1 = SparseMatrix[[0,0,1,0],[0,2,0,2],[0,1,0,2]]  #3x4
		 sparse_matrix2 = SparseMatrix[[0,1],[0,0],[3,0],[0,0]]  #4x2
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		# data tests
		 actual_matrix =  sparse_matrix1*(@sparse_matrix2)
		assert_equal  actual_matrix.values,[3], "Multiplication by matrix(integer) - values vector incorrect"
		assert_equal  actual_matrix.full(),Matrix[[3,0],[0,0],[0,0]], "Multiplication of matrix by matrix(integer) failed."
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"
	
	end

	def test_multiplication_matrix_float
		#setup
		 sparse_matrix1 = SparseMatrix[[0,0,1.01,0],[0,2.05,0,2.50],[0,1.20,0,2.02]]  #3x4
		 sparse_matrix2 = SparseMatrix[[0,1.04],[0,0],[3.03,0],[0,0]]  #4x2
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		
		#data tests
		 actual_matrix =  sparse_matrix1*(@sparse_matrix2)
		assert_in_delta  actual_matrix.values,[3.0603], 0.01, "Multiplication by matrix(float) - values vector incorrect"
		assert_in_delta  actual_matrix.full(),Matrix[[3.0603,0],[0,0],[0,0]], 0.01, "Multiplication of matrix by matrix(float) failed."
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"
	
	end

	# Division
	def test_division_numeric_int
		#setup
		 sparse_matrix = SparseMatrix[[2,1,0,0],[3,0,0,0],[0,4,4,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 divisor = 2
		
		#pre
		#assert  sparse_matrix.real?, "SparseMatrix should be real."
		#assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		#assert  divisor.real?, "Divisor should be real."
		#assert_not_nil  divisor,  "Divisor should not be nil."  # can't do comparision
		#assert (@divisor.is_a? Integer), "Divisor is not an integer"
		#assert_not_equal 0,  divisor, "divisor cannot be zero"
		
		#data tests
		 result_matrix =  sparse_matrix/@divisor
		 expected_values = [1,0.5,1.5,2,2]
		for value in 0..@result_matrix.values.length-1
			assert_in_delta  result_matrix.values[value],  expected_values[value], 0.01, "incorrect values array"
		end
		
		 expected_matrix = Matrix[[1,0.5,0,0],[1.5,0,0,0],[0,2,2,0]]
		for i in 0..@sparse_clone.row_count-1
			for j in 0..@sparse_clone.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01, "Integer divsion incorrect"
			end
		end
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert_equal  sparse_clone.val_row,  actual_matrix.val_row, "fail. val_row changed"
		assert_equal  sparse_clone.val_col,  actual_matrix.val_col, "fail. val_col changed"
		assert !@sparse_matrix.empty?
		
	end

	def test_division_numeric_float
		#setup
		 sparse_matrix = SparseMatrix[[2.50,1.20,0,0],[3.05,0,0,0],[0,4.50,4.40,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 divisor = 2.50
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert  divisor.real?, "Divisor should be real."
		#assert_not_nil  divisor,  "Divisor should not be nil."  # can't do comparision
		assert (@divisor.is_a? Float), "Divisor is not a float"
		assert_not_equal(0,  divisor, "divisor cannot be zero")
		
		#data tests
		 result_matrix =   sparse_matrix/(@divisor)
		 expected_values = [1,0.48,1.22,1.80,1.76]
		for i in 0..  result_matrix.values.length-1
			assert_in_delta  result_matrix.values[i],@expected_values[i], 0.01, "Values array incorrect after float divsion"
		end
		
		 expected_matrix = Matrix[[1,0.48,0,0],[1.22,0,0,0],[0,1.80,1.76,0]]
		for i in 0..sparse_clone.row_count-1
			for j in 0..sparse_clone.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01, "Float divsion incorrect"
			end
		end
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert_equal  sparse_clone.val_row,  actual_matrix.val_row, "fail. val_row changed"
		assert_equal  sparse_clone.val_col,  actual_matrix.val_col, "fail. val_col changed"
		assert !@sparse_matrix.empty?
		
	end
	
	def test_division_matrix_int
		#setup
		 sparse_matrix1 = SparseMatrix[[1,0],[4,0],[0,7]]
		 sparse_matrix2 = SparseMatrix[[2,0],[0,9]]
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"
		
		#data tests
		 result_matrix =  sparse_matrix1/(@sparse_matrix2)
		assert_in_delta  result_matrix.full(), Matrix[[0.5,0],[2,0],[0,0.77778]], 0.01, "Integer matrix division failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

	end

	def test_division_matrix_float
		#setup
		 sparse_matrix1 = SparseMatrix[[1.10,0],[4.50,0],[0,0]]
		 sparse_matrix2 = SparseMatrix[[2.10,0],[0,9.10]]
		 sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"
		
		
		#data tests
		 result_matrix =  sparse_matrix1/(@sparse_matrix2)
		assert_in_delta  result_matrix.full(), Matrix[[0.5238,0],[2.1429,0],[0,0]], 0.01, "Float matrix division failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone1,  sparse_matrix1, "Original matrix was altered"
		assert !@sparse_matrix1.empty?
		assert_equal  sparse_clone2,  sparse_matrix2, "Original matrix was altered"
		assert !@sparse_matrix2.empty?
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		
	end

	# Exponentiation
	def test_exponentiation_zero
		#setup
		 sparse_matrix = SparseMatrix[[0,2],[1,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 exponent = 0
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		 actual_matrix =  sparse_matrix**(@exponent)
		assert_equal  actual_matrix.full(), Matrix.identity(@sparse_matrix.row_count), "Matrix eponentiation failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert !@sparse_matrix.empty?
		
	end
	
	def test_exponentiation_numeric_int
		#setup
		 sparse_matrix = SparseMatrix[[0,2,1],[1,0,0],[0,3,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 exponent = 2
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		 actual_matrix =  sparse_matrix**(@exponent)
		assert_equal  actual_matrix.full(), Matrix[[2,3,0],[0,2,1],[3,0,0]], "Integer matrix eponentiation failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert !@sparse_matrix.empty?
		
	end
	
	def test_negative_exponentiation_int
		#setup
		 sparse_matrix = SparseMatrix[[0,1,1],[1,0,0],[0,1,0]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		 exponent = -2
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (@exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		
		#data tests
		 actual_matrix =  sparse_matrix**(@exponent)
		assert_equal  actual_matrix.full(), Matrix[[0,0,1],[1,0,-1],[-1,1,1]], "Integer matrix eponentiation failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert !@sparse_matrix.empty?
		
	end
	
	def test_matrix_inverse
		#setup
		 sparse_matrix = SparseMatrix[[2,0],[0,1]]
		 sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix.square?, "Matrix is not square"
		assert !sparse_matrix.singular?, "Cannot take inverse - matrix is singular"
		
		#data tests
		 result_matrix =  sparse_matrix.inverse
		assert_in_delta  result_matrix, Matrix[[0.5,0],[0,1]], 0.01, "Matrix inversion failed"
		
		#post
		
		#invariant
		assert_equal  sparse_clone.full(),  sparse_matrix.full(), "Original matrix was altered."
		assert !@sparse_matrix.empty?
		
	end
	
end
