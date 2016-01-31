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
end

def testSubtractionNumericFloat
end

def testSubtractionVectorInt
end

def testSubtractionVectorFloat
end

def testSubtractionMatrixInt
end

def testSubtractionMatrixFloat
end

# Multiplication
def testMultiplicationNumericInt
end

def testMultiplicationNumericFloat
end

def testMultiplicationVectorInt
end

def testMultiplicationVectorFloat
end

def testMultiplicationMatrixInt
end

def testMultiplicationMatrixFloat
end

# Division
def testDivisionNumericInt
end

def testDivisonNumericFloat
end

def testDivisionVectorInt
end

def testDivisionVectorFloat
end

def testDivisionMatrixInt
end

def testDivisionMatrixFloat
end

# Exponentiation

def testExponentiationNumericInt
end

def testExponentiationNumericFloat
end


# Matrix Equality

end

=begin
need to test @+() and @-() before deciding how to test them.

put equality tests here as well?
=end


=begin

todo:
	try a "non sparse matrix test" just to see our performance differences?
 
we are using ints, floats and chars
	- number
	- vector
	- matrix

different tests for ints and floats.  what is a good tolerance for floats?

=end