require 'test/unit'
require '../sparse_matrix.rb'
require 'matrix'

=begin
layout for tests

def testThing(arg1,arg2)
	
	# comment(s) for clarity (brief description of what is being tested)

	# pre conditions
	
	# method usage tests

	#post conditions
	
	end #testThing

	# invariants - for class?
	
=end


class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	# Addition
	def test_addition_numeric_int
		# setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
		#pre
		assert sparse_matrix.real?, "SparseMatrix should be real."
		assert_not_nil sparse_matrix.values, "SparseMatrix values stored should not be nil."
		
		#data tests
		
		#post
		
	end

	def test_addition_numeric_float
		#setup
		sparse_matrix = SparseMatrix[[1,2,0],[2,0,0],[0,0,1]]
		
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
		
we are using ints, floats and chars
	- number
	- vector
	- matrix

different tests for ints and floats.  what is a good tolerance for floats?

=end