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

=begin
ways to intialize:
sparse_matrix = SparseMatrix[[1.00, 0.00], [0.00, 2.00]]
sparse_matrix = SparseMatrix.new([[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]])

=end


class ArithmeticOperationsUnitTests < Test::Unit::TestCase

	# Addition
	def testAdditionNumericInt

		#pre
		SparseMatrix.new([1 2 0][2 0 0][0 0 1])
		
		#post
	end

	def testAdditionNumericFloat
		SparseMatrix.new([1 2 0][2 0 0][0 0 1])
		
		#pre
		
		
		#post
		
	end

	def testAdditionVectorInt
		#pre
		
		#post
	end

	def testAdditionVectorFloat
		#pre
		
		#post
	end

	def testAdditionMatrixInt
		
		#pre
		#dimensions must correspond
		
		#post

	end

	def testAdditionMatrixFloat
		#pre
		# dimensions must correspond
		
		#post
	end

	# Subraction
	def testSubtractionNumericInt
		#pre
		
		#post
	end

	def testSubtractionNumericFloat
		#pre
		
		#post
	end

	def testSubtractionVectorInt
		#pre
		
		#post
	end

	def testSubtractionVectorFloat
		#pre
		
		#post 	
	end

	def testSubtractionMatrixInt
		#pre
		
		#post
	end

	def testSubtractionMatrixFloat
		#pre
		
		#post
	end

	# Multiplication
	def testMultiplicationNumericInt
		#pre
		
		#post
	end

	def testMultiplicationNumericFloat
		#pre
		
		#post
	end

	def testMultiplicationVectorInt
		#pre
		
		#post
	end

	def testMultiplicationVectorFloat
		#pre
		
		#post
	end

	def testMultiplicationMatrixInt
		#pre
		
		#post
	end

	def testMultiplicationMatrixFloat
		#pre
		
		#post
	end

	# Division
	def testDivisionNumericInt
		#pre
		
		#post
	end

	def testDivisonNumericFloat
		#pre
		
		#post
	end

	def testDivisionVectorInt
		#pre
		
		#post
	end

	def testDivisionVectorFloat
		#pre
		
		#post
	end

	def testDivisionMatrixInt
		#pre
		
		#post
	end

	def testDivisionMatrixFloat
		#pre
		
		#post
	end

	
	# Exponentiation
	def testExponentiationNumericInt
		#pre
		
		#post
	end

	def testExponentiationNumericFloat
		#pre
		
		#post

	end


	# Matrix Equality
	def testMatrixEquality
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