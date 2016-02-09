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
    assert !sm.empty?
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
		assert_equal expected_matrix, actual_matrix.full(), "Matrix values were not increased correctly."
		
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
		 
		value = 4.45
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix.increase_all_values_by(value)
		for row in 0..actual_matrix.row_count-1
			for col in 0..actual_matrix.column_count-1
				assert_in_delta  actual_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
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
			assert_true (e.message == "ErrOperationNotDefined"), "Incorrect exception thrown: #{e}"
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
		assert (value_to_add.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests  
		begin
			sparse_matrix+(value_to_add)
		rescue Exception => e
			assert_true (e.message == "ErrOperationNotDefined"), "Incorrect exception thrown: #{e}"
		else
			fail 'No Exception thrown'
		end
	
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	

	# def test_addition_vector_float
	# 	#setup
	# 	sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[4.04]]  #4x1
	# 	hash_sm1 = {[0,0]=>4.04,[3,0]=>4.04}
		
	# 	sparse_matrix2 = SparseMatrix[[1.01],[1.02],[0],[0]]  #4x1
	# 	hash_sm2 = {[0,0]=>1.01,[1,0]=>1.02}
		
	# 	sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
	# 	sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
	# 	expected_matrix = Matrix[[5.05],[1.02],[0],[4.04]]
	# 	hash_expected = {[0,0]=>5.05, [1,0]=>1.02, [3,0]=>4.04}
		
	# 	#pre
	# 	assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
	# 	assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# 	#data tests
	# 	result_matrix =  sparse_matrix1+(sparse_matrix2)
	# 	for row in 0..result_matrix.row_count-1
	# 		for col in 0..result_matrix.column_count-1
	# 			assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
	# 		end
	# 	end
		
	# 	#post
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
	# 	assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# end

	def test_addition_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		hash_sm1 = {[0,0]=>1,[0,2]=>3, [1,2]=>1, [2,0]=>2, [3,1]=>1} 
		sparse_matrix2 = SparseMatrix[[0,1,0],[0,2,0],[1,0,0],[0,-2,-1]]
		hash_sm2 = {[0,1]=>1,[1,1]=>2, [2,0]=>1, [3,1]=>-2, [3,2]=>-1}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1, 1, 3], [0, 2, 1], [3, 0, 0], [0, -1, -1]]
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
		assert_equal  expected_matrix, result_matrix.full(), "Integer matrix addition not working correctly"
		
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
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
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

	def test_add_sparse_and_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		hash_sm1 = {[0,0]=>1,[0,2]=>3, [1,2]=>1, [2,0]=>2, [3,1]=>1} 
		
		matrix = Matrix[[0,1,0],[0,2,0],[1,0,0],[0,-2,-1]]
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1, 1, 3], [0, 2, 1], [3, 0, 0], [0, -1, -1]]
		hash_expected = {[0,0]=>1,[0,1]=>1, [0,2]=>3, [1,1]=>2, [1,2]=>1, [2,0]=>3, [3,1]=>-1, [3,2]=>-1}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  matrix.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  matrix.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		#data tests
		result_matrix = sparse_matrix1+(matrix)
		assert_equal  expected_matrix, result_matrix.full(), "Integer matrix addition not working correctly"
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
	end

	def test_add_sparse_and_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[-1.08,0,3.14],[0,0,1.00],[2.02,0,0],[0,1.08,0]]
		hash_sm1 = {[0,0]=>-1.08, [0,2]=>3.14, [1,2]=>1.00, [2,0]=>2.02, [3,1]=>1.08}
		
		matrix = Matrix[[0,1.16,0],[0,0,2.04],[1.06,0,0],[0,2.14,0]]
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[-1.08,1.16,3.14],[0.00,0.00,3.04],[3.08,0.00,0.00],[0.00,3.22,0.00]]
		hash_expected = {[0,0]=>-1.08, [0,1]=>1.16, [0,2]=>3.14, [1,2]=>3.04, [2,0]=>3.08, [3,1]=>3.22}
		
		#pre
		assert_equal  sparse_matrix1.row_count,  matrix.row_count, "Incompatible dimension (row) for matrix addition"
		assert_equal  sparse_matrix1.column_count,  matrix.column_count, "Incompatible dimension (column) for matrix addition"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		#data tests
		result_matrix =  sparse_matrix1+(matrix)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  expected_matrix.row(row)[col], result_matrix.full().row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
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
		hash_expected = {[0,0]=>-0.5, [0,1]=>0.5, [0,2]=>-1.5, [1,0]=>0.5, [1,1]=>-1.5,[1,2]=>-1.5, [2,0]=>-1.5, [2,1]=>-1.5, [2,2]=>-0.5, [3,0]=>-0.5, [3,1]=>0.5, [3,2]=>-1.5}
		
		value = -1.50
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix.increase_all_values_by(value)
		for row in 0..actual_matrix.row_count-1
			for col in 0..actual_matrix.column_count-1
				assert_in_delta  actual_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	def test_subtraction_numeric_int
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		hash_sm = {[0,0]=>1, [0,1]=>2, [1,0]=>2, [2,2]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		value_to_subtract = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value_to_subtract.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests  
		begin
			 sparse_matrix-(value_to_subtract)
		rescue Exception => e
			assert_true (e.message == "ErrOperationNotDefined"), "Incorrect exception thrown: #{e}"
		else
				fail 'No Exception thrown'
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	def test_subtraction_numeric_float
		# setup
		sparse_matrix = SparseMatrix[[1.20,2.20,0],[2.40,0,0],[0,0,1.04]]
		hash_sm = {[0,0]=>1.20, [0,1]=>2.20, [1,0]=>2.40, [2,2]=>1.04}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		value_to_subtract = 4.55
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value_to_subtract.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#data tests  
		begin
			 sparse_matrix-(value_to_subtract)
		rescue Exception => e
			assert_true (e.message == "ErrOperationNotDefined"), "Incorrect exception thrown: #{e}"
		else
			fail 'No Exception thrown'
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	# def test_subtraction_vector_int
	# 	#setup
	# 	sparse_matrix1 = SparseMatrix[[4],[0],[0],[4]]  #4x1
	# 	hash_sm1 = {[0,0]=>4, [3,0]=>4}
	# 	sparse_matrix2 = SparseMatrix[[1],[1],[0],[0]]  # 4x1
	# 	hash_sm2 = {[0,0]=>1,[1,0]=>1}
		 
	# 	sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
	# 	sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
	# 	expected_matrix = Matrix[[3],[-1],[0],[4]]
	# 	hash_expected = {[0,0]=>3, [1,0]=>-1, [2,0]=>4}
		
	# 	#pre
	# 	assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
	# 	assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# 	#data tests
	# 	actual_matrix =  sparse_matrix1-(sparse_matrix2)
	# 	assert_equal  actual_matrix.full(),  expected_matrix, "Integer vector subtraction failed"
		
	# 	#post
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
	# 	assert hash_expected.eql?(actual_matrix.values), "Hashes must equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# end

	# def test_subtraction_vector_float
	# 	#setup
	# 	sparse_matrix1 = SparseMatrix[[4.04],[0],[0],[-4.02]]  #4x1
	# 	hash_sm1 = {[0,0]=>4.04,[3,0]=>-4.02}
		 
	# 	sparse_matrix2 = SparseMatrix[[4.01],[0],[0],[1.01]]  #4x1
	# 	hash_sm2 = {[0,0]=>4.01,[3,0]=>1.01}
		 
	# 	sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
	# 	sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
	# 	expected_matrix = Matrix[[0.03],[0],[0],[-5.03]]
	# 	hash_expected = {[0,0]=>0.03, [3,0]=>-5.03}
		
	# 	#pre
	# 	assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix addition"
	# 	assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix addition"
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# 	#data tests
	# 	result_matrix =   sparse_matrix1-(sparse_matrix2)
	# 	for row in 0..result_matrix.row_count-1
	# 		for col in 0..result_matrix.column_count-1
	# 			assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
	# 		end
	# 	end
		
	# 	#post
	# 	assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
	# 	assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
	# 	assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
	# 	#invariant
	# 	checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	# 	checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	# end

	def test_subtraction_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		hash_sm1 = {[0,0]=>1,[0,2]=>3, [1,2]=>1, [2,0]=>2, [3,1]=>1} 
		 
		sparse_matrix2 = SparseMatrix[[0,1,0],[0,2,0],[1,0,0],[0,-2,-1]]
		hash_sm2 = {[0,1]=>1,[1,1]=>2, [2,0]=>1, [3,1]=>-2, [3,2]=>-1}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 
		expected = Matrix[[1,-1,3],[0,-2,1],[1,0,0],[0,3,1]]
		hash_expected = {[0,0]=>1,[0,1]=>-1,[0,2]=>3,[1,1]=>-2,[1,2]=>1,[2,0]=>1,[3,1]=>3,[3,2]=>1}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		actual_matrix =  sparse_matrix1-(sparse_matrix2)
		assert_equal  expected, actual_matrix.full(), "Integer matrix subtraction not working correctly"
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_subtraction_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		hash_sm1 = {[0,0]=>1.08, [0,2]=>3.14, [1,2]=>1.00, [2,0]=>2.06, [3,1]=>2.14}
		
		sparse_matrix2 = SparseMatrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		hash_sm2 = {[0,1]=>1.16,[1,2]=>2.04,[2,0]=>1.02,[3,1]=>1.08}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		 
		expected = Matrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		hash_expected = {[0,0]=>1.08, [0,1]=>-1.16, [0,2]=>3.14, [1,2]=>-1.04, [2,0]=>1.04, [3,1]=>1.06}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  sparse_matrix2.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.column_count, "Incompatible dimension (column) for matrix subtraction"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1-(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected.row(row)[col], 0.01, "Matrix values were not increased correctly."
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

	def test_sub_sparse_and_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3],[0,0,1],[2,0,0],[0,1,0]]
		hash_sm1 = {[0,0]=>1,[0,2]=>3, [1,2]=>1, [2,0]=>2, [3,1]=>1} 
		 
		matrix = Matrix[[0,1,0],[0,2,0],[1,0,0],[0,-2,-1]]
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 
		expected = Matrix[[1,-1,3],[0,-2,1],[1,0,0],[0,3,1]]
		hash_expected = {[0,0]=>1,[0,1]=>-1,[0,2]=>3,[1,1]=>-2,[1,2]=>1,[2,0]=>1,[3,1]=>3,[3,2]=>1}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  matrix.real?, "Matrix should be real."
		assert_not_nil  matrix, "Matrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  matrix.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  matrix.column_count, "Incompatible dimension (column) for matrix subtraction"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		#data tests
		actual_matrix =  sparse_matrix1-(matrix)
		assert_equal  expected, actual_matrix.full(), "Integer matrix subtraction not working correctly"
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
	end

	def test_sub_sparse_and_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.08,0,3.14],[0,0,1.00],[2.06,0,0],[0,2.14,0]]
		hash_sm1 = {[0,0]=>1.08, [0,2]=>3.14, [1,2]=>1.00, [2,0]=>2.06, [3,1]=>2.14}
		
		matrix = Matrix[[0,1.16,0],[0,0,2.04],[1.02,0,0],[0,1.08,0]]
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		 
		expected = Matrix[[1.08,-1.16,3.14],[0,0,-1.04],[1.04,0,0],[0,1.06,0]]
		hash_expected = {[0,0]=>1.08, [0,1]=>-1.16, [0,2]=>3.14, [1,2]=>-1.04, [2,0]=>1.04, [3,1]=>1.06}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  matrix.real?, "Matrix should be real."
		assert_not_nil  matrix, "Matrix values stored should not be nil."
		assert_equal  sparse_matrix1.row_count,  matrix.row_count, "Incompatible dimension (row) for matrix subtraction"
		assert_equal  sparse_matrix1.column_count,  matrix.column_count, "Incompatible dimension (column) for matrix subtraction"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		#data tests
		result_matrix =  sparse_matrix1-(matrix)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
	end
	
	# Multiplication
	def test_multiplication_numeric_int
		#setup
		sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		hash_sm = {[0,0]=>1,[0,2]=>3,[1,2]=>1,[2,1]=>2}
		
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		hash_expected = {[0,0]=>4,[0,2]=>12,[1,2]=>4,[2,1]=>8}
		
		value = 4
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =   sparse_matrix*value
		assert_equal  result_matrix.full(), Matrix[[4,0,12],[0,0,4],[0,8,0]], "Multiplication of matrix by integer failed."
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_multiplication_numeric_zero
		#setup
		sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		hash_sm = {[0,0]=>1,[0,2]=>3,[1,2]=>1,[2,1]=>2}
		
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		value = 0
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Integer), "Value is not an integer"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
				
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =   sparse_matrix*(value)
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert (result_matrix.values.empty?), "hash not empty"
		assert_equal  result_matrix.full(), Matrix.zero(sparse_matrix.row_count,sparse_matrix.column_count), "Multiplication of matrix by 0 failed."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_multiplication_numeric_float
		#setup
		sparse_matrix = SparseMatrix[[1,0,3],[0,0,1],[0,2,0]]
		hash_sm = {[0,0]=>1,[0,2]=>3,[1,2]=>1,[2,1]=>2}
		
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1.5,0,4.5],[0,0,1.5],[0,3,0]]
		hash_expected = {[0,0]=>1.5,[0,2]=>4.5,[1,2]=>1.5,[2,1]=>3}
		
		value = 1.5
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (value.is_a? Float), "Value is not a float"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =   sparse_matrix*(value)
		for i in 0..result_matrix.row_count-1
			for j in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01,  "Multiplication of matrix by float failed."
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		 
	end

=begin
	def test_multiplication_vector_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0,3,4],[0,0,0,2],[1,0,0,1]] #3x4
		hash_sm1 = {[0,0]=>1,[0,2]=>3,[0,3]=>4,[1,3]=>2,[2,0]=>1,[2,3]=>1}
		
		sparse_matrix2 = SparseMatrix[[1],[0],[0],[2]] #4x1
		hash_sm2 = {[0,0]=>1,[3,0]=>2}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[9],[4],[3]]
		hash_expected = {[0,0]=>9,[1,0]=>4,[2,0]=>3}
			
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#data tests
		result_matrix =  sparse_matrix1*(sparse_matrix2)
		assert_equal  result_matrix.full(), Matrix[[9],[4],[3]], "Multiplication of matrix by vector(integer) failed."
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_multiplication_vector_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.01,0,3.03,4.50],[0,0,0,2.02],[1.01,0,0,1.01]]  #3x4
		hash_sm1 = {[0,0]=>1.01,[0,2]=>3.03,[0,3]=>4.50,[1,3]=>2.02,[2,0]=>1.01,[2,3]=>1.01}
		
		sparse_matrix2 = SparseMatrix[[1.01],[0],[0],[1.02]] #4x1
		hash_sm2 = {[0,0]=>1.01,[3,0]=>1.02}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[5.6101],[2.0604],[2.0503]]
		hash_expected = {[0,0]=>5.6101,[1,0]=>2.0604,[2,0]=>2.0503}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1*(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Multiplication of matrix by vector(float) failed."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end
=end
	def test_multiplication_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[0,0,1,0],[0,2,0,2],[0,1,0,2]]  #3x4
		hash_sm1 = {[0,2]=>1,[1,1]=>2,[1,3]=>2,[2,1]=>1,[2,3]=>2}
		
		sparse_matrix2 = SparseMatrix[[0,1],[0,0],[3,0],[0,0]]  #4x2
		hash_sm2 = {[0,1]=>1,[2,0]=>3}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[3,0],[0,0],[0,0]]
		hash_expected = {[0,0]=>3}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		# data tests
		result_matrix =  sparse_matrix1*(sparse_matrix2)
		assert_equal  result_matrix.full(),Matrix[[3,0],[0,0],[0,0]], "Multiplication of matrix by matrix(integer) failed."
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
	
	end


	def test_multiplication_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[0,0,1.01,0],[0,2.05,0,2.50],[0,1.20,0,2.02]]  #3x4
		hash_sm1 = {[0,2]=>1.01, [1,1]=>2.05, [1,3]=>2.50, [2,1]=>1.20, [2,3]=>2.02}
		
		sparse_matrix2 = SparseMatrix[[0,1.04],[0,0],[3.03,0],[0,0]]  #4x2
		hash_sm2 = {[0,1]=>1.04,[2,0]=>3.03}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[3.0603,0],[0,0],[0,0]]
		hash_expected = {[0,0]=>3.0603}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  sparse_matrix2.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1*(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
			
	end

	def test_multiplication_sparse_and_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[0,0,1,0],[0,2,0,2],[0,1,0,2]]  #3x4
		hash_sm1 = {[0,2]=>1,[1,1]=>2,[1,3]=>2,[2,1]=>1,[2,3]=>2}
		
		matrix = Matrix[[0,1],[0,0],[3,0],[0,0]]  #4x2
		
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[3,0],[0,0],[0,0]]
		hash_expected = {[0,0]=>3}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  matrix.real?, "Matrix should be real."
		assert_not_nil  matrix, "Matrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  matrix.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		# data tests
		result_matrix =  sparse_matrix1*(matrix)
		assert_equal  result_matrix.full(),Matrix[[3,0],[0,0],[0,0]], "Multiplication of matrix by matrix(integer) failed."
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  matrix.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
	
	end


	def test_multiplication_sparse_and_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[0,0,1.01,0],[0,2.05,0,2.50],[0,1.20,0,2.02]]  #3x4
		hash_sm1 = {[0,2]=>1.01, [1,1]=>2.05, [1,3]=>2.50, [2,1]=>1.20, [2,3]=>2.02}
		
		matrix = Matrix[[0,1.04],[0,0],[3.03,0],[0,0]]  #4x2
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[3.0603,0],[0,0],[0,0]]
		hash_expected = {[0,0]=>3.0603}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  matrix.real?, "Matrix should be real."
		assert_not_nil  matrix, "Matrix values stored should not be nil."
		assert_equal  sparse_matrix1.column_count,  matrix.row_count, "incompatible dimensions for matrix multiplication"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		
		#data tests
		result_matrix =  sparse_matrix1*(matrix)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."

		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count, matrix.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
			
	end
	
	# Division
	def test_division_numeric_int
		#setup
		sparse_matrix = SparseMatrix[[2,1,0,0],[3,0,0,0],[0,4,4,0]]
		hash_sm = {[0,0]=>2, [0,1]=>1, [1,0]=>3, [2,1]=>4, [2,2]=>4}
		
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1,0.5,0,0],[1.5,0,0,0],[0,2,2,0]]
		hash_expected = {[0,0]=>1,[0,1]=>0.5,[1,0]=>1.5,[2,1]=>2,[2,2]=>2}
		
		divisor = 2
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert  divisor.real?, "Divisor should be real."
		assert_not_nil  divisor,  "Divisor should not be nil."  # can't do comparision
		assert (divisor.is_a? Integer), "Divisor is not an integer"
		assert_not_equal 0,  divisor, "divisor cannot be zero"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =  sparse_matrix/divisor
		for i in 0..result_matrix.row_count-1
			for j in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01, "Float divsion incorrect"
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end

	def test_division_numeric_float
		#setup
		sparse_matrix = SparseMatrix[[2.50,1.20,0,0],[3.05,0,0,0],[0,4.50,4.40,0]]
		hash_sm = {[0,0]=>2.50,[0,1]=>1.20,[1,0]=>3.05,[2,1]=>4.50,[2,2]=>4.40}
		
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[1,0.48,0,0],[1.22,0,0,0],[0,1.80,1.76,0]]
		hash_expected = {[0,0]=>1,[0,1]=>0.48,[1,0]=>1.22,[2,1]=>1.80,[2,2]=>1.76}
		
		divisor = 2.50
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert  divisor.real?, "Divisor should be real."
		#assert_not_nil  divisor,  "Divisor should not be nil."  # can't do comparision
		assert (divisor.is_a? Float), "Divisor is not a float"
		assert_not_equal(0,  divisor, "divisor cannot be zero")
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =   sparse_matrix/(divisor)
		for i in 0..result_matrix.row_count-1
			for j in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j],  expected_matrix.row(i)[j], 0.01, "Float divsion incorrect"
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must be equal"
		
		#invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_division_matrix_int
		#setup
		sparse_matrix1 = SparseMatrix[[1,0],[4,0],[0,7]]
		hash_sm1 = {[0,0]=>1, [1,0]=>4, [2,1]=>7}
		
		sparse_matrix2 = SparseMatrix[[2,0],[0,9]]
		hash_sm2 = {[0,0]=>2,[1,1]=>9}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[0.5,0],[2,0],[0,0.77778]]
		hash_expected = {[0,0]=>0.5, [1,0]=>2, [2,1]=>0.77778}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1/(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
	end

	def test_division_matrix_float
		#setup
		sparse_matrix1 = SparseMatrix[[1.10,0],[4.50,0],[0,0]]
		hash_sm1 = {[0,0]=>1.10, [1,0]=>4.50}
		
		sparse_matrix2 = SparseMatrix[[2.10,0],[0,9.10]]
		hash_sm2 = {[0,0]=>2.10,[1,1]=>9.10}
		
		sparse_clone1 =  sparse_matrix1.clone()  # used to check that matrix used in operation was not changed
		sparse_clone2 =  sparse_matrix2.clone()  # used to check that matrix used in operation was not changed
		expected_matrix = Matrix[[0.5238,0],[2.1429,0],[0,0]]
		hash_expected = {[0,0]=>0.5238,[1,0]=>2.1429}
		
		#pre
		assert  sparse_matrix1.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix1.values, "SparseMatrix values stored should not be nil."
		assert  sparse_matrix2.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix2.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix2.square?, "Cannot didvide - divisor matrix is not square"
		assert !sparse_matrix2.singular?, "Cannot divide - divisor matrix is singular"
		assert_equal sparse_matrix1.column_count, sparse_matrix2.row_count, "Incompatible dimensions for matrix division"
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		
		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
		
		#data tests
		result_matrix =  sparse_matrix1/(sparse_matrix2)
		for row in 0..result_matrix.row_count-1
			for col in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(row)[col],  expected_matrix.row(row)[col], 0.01, "Matrix values were not increased correctly."
			end
		end
		
		#post
		assert hash_sm1.eql?(sparse_matrix1.values), "Hashes must be equal."
		assert hash_sm2.eql?(sparse_matrix2.values), "Hashes must be equal."
		assert hash_expected.eql?(result_matrix.values), "Hashes must equal."
		assert_equal  expected_matrix.row_count,  sparse_matrix1.row_count, "Matrix multiplication dimension error (row)"
		assert_equal  expected_matrix.column_count,  sparse_matrix2.column_count, "Matrix multiplication dimension error (column)"

		#invariant
		checkMatrixAssertions(sparse_matrix1, sparse_clone1)
		checkMatrixAssertions(sparse_matrix2, sparse_clone2)
				
	end

	# Exponentiation
	def test_exponentiation_zero
		#setup
		sparse_matrix = SparseMatrix[[0,2],[1,0]]
		hash_sm = {[0,1]=>2,[1,0]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		#[[1,0],[0,1]]
		hash_expected = {[0,0]=>1,[1,1]=>1}
		
		exponent = 0
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix**(exponent)
		assert_equal  actual_matrix.full(), Matrix.identity(sparse_matrix.row_count), "Matrix eponentiation failed"
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must be equal"
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_exponentiation_numeric_int
		#setup
		sparse_matrix = SparseMatrix[[0,2,1],[1,0,0],[0,3,0]]
		hash_sm = {[0,1]=>2, [0,2]=>1, [1,0]=>1, [2,1]=>3}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		hash_expected = {[0,0]=>2,[0,1]=>3,[1,1]=>2,[1,2]=>1,[2,0]=>3}
		
		exponent = 2
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix**(exponent)
		assert_equal  actual_matrix.full(), Matrix[[2,3,0],[0,2,1],[3,0,0]], "Integer matrix eponentiation failed"
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert hash_expected.eql?(actual_matrix.values), "Hashes must be equal"
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_negative_exponentiation_int
		#setup
		sparse_matrix = SparseMatrix[[0,1,1],[1,0,0],[0,1,0]]
		hash_sm = {[0,1]=>1,[0,2]=>1,[1,0]=>1,[2,1]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		hash_expected = {[0,2]=>1, [1,0]=>1, [1,2]=>-1, [2,0]=>-1, [2,1]=>1, [2,2]=>1}
		exponent = -2
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert (exponent.is_a? Integer), "Exponent is not an integer"
		assert  sparse_matrix.square?, "Matrix is not square"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		actual_matrix =  sparse_matrix**(exponent)
		assert_equal  actual_matrix.full(), Matrix[[0,0,1],[1,0,-1],[-1,1,1]], "Integer matrix eponentiation failed"
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert_equal hash_expected, actual_matrix.values, "Hashes must be equal"
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
	def test_matrix_inverse
		#setup
		sparse_matrix = SparseMatrix[[2,0],[0,1]]
		hash_sm = {[0,0]=>2,[1,1]=>1}
		sparse_clone =  sparse_matrix.clone()  # used to check that matrix used in operation was not changed
		
		expected_matrix = Matrix[[0.5,0],[0,1]]
		hash_expected = {[0,0]=>0.5,[1,1]=>1}
		
		#pre
		assert  sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil  sparse_matrix.values, "SparseMatrix values stored should not be nil."
		assert sparse_matrix.square?, "Matrix is not square"
		assert !sparse_matrix.singular?, "Cannot take inverse - matrix is singular"
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
		#data tests
		result_matrix =  sparse_matrix.inverse
		for i in 0..result_matrix.row_count-1
			for j in 0..result_matrix.column_count-1
				assert_in_delta  result_matrix.full().row(i)[j], expected_matrix.row(i)[j], 0.01, "Matrix inversion failed"
			end
		end
		
		#post
		assert hash_sm.eql?(sparse_matrix.values), "Hashes must be equal."
		assert_equal hash_expected, result_matrix.values, "Hashes must be equal"
		
		# invariant
		checkMatrixAssertions(sparse_matrix, sparse_clone)
		
	end
	
end
