=begin
ECE421 Project 1

Michelle Mabuyo, Kirsten Svidal, Anju Eappen	
=end 

require './sparse_matrix.rb'
require './tridiagonal_matrix.rb'

# INITIALIZING SPARSE MATRICES
# many different ways
puts "INITIALIZING..."
sm = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
zero_sm = SparseMatrix.zero(3,3)
diag_sm = SparseMatrix.diagonal(1,2,3,4)
identity_sm = SparseMatrix.identity(3)
scalar_sm = SparseMatrix.scalar(3,2)
rows_sm = SparseMatrix.rows([[1,0,0],[0,0,2],[0,3,0]])
columns_sm = SparseMatrix.columns([[1,0,0],[0,0,2],[0,3,0]])
compressed_sm = SparseMatrix.compressed_format({[0,0]=>1,[1,0]=>2,[1,1]=>3,[2,2]=>1},3,3)
small_square_sm = SparseMatrix[[2,2],[0,0]]

matrix = Matrix[[1,3,2,0], [1,2,1,1], [3,2,0,0], [0,0,0,4]]

# SPARSITY ATTRIBUTES
puts "SPARSITY ATTRIBUTES"
puts sm.sparse? 	#yes
puts sm.sparsity 	#0.25 
puts sm.nonzero_count #4
puts sm.nonzeros  #{[0,0]=>1, [1,1]=>2, [2,0]=>3, [3,3]=>4}
puts sm.full  		#Matrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
sm.putNonZero(4,0,1) #Matrix[[1,4,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]
puts sm.full

# ARITHMETIC OPERATIONS
# full() is called for printing purposes
puts "ARITHMETIC OPERATIONS"
# Sparse matrices with sparse matrices
puts (sm+diag_sm).full
puts (sm-diag_sm).full
puts (sm*diag_sm).full
puts (sm/diag_sm).full

# Sparse matrices with matrices
puts (sm+matrix).full
puts (sm-matrix).full
puts (sm*matrix).full
puts (sm/matrix).full

# Sparse matrices with a number
puts (sm.increase_all_values_by(2)).full
puts (sm.decrease_all_values_by(2)).full
puts (sm*2).full
puts (sm/2).full 
puts (sm**2).full

# illegal operations - dimensions do not agree
#puts (diag_sm*identity_sm) # ErrDimensionMismatch
begin
	diag_sm*identity_sm
rescue Exception => e
	if (e.message == "ErrDimensionMismatch")
		puts "ErrDimensionMismatch"
	end
else
	fail 'No Exception thrown'
end

#puts (identity_sm+small_square_sm) # ErrDimensionMismatch
begin
	identity_sm+small_square_sm
rescue Exception => e
	if (e.message == "ErrDimensionMismatch")
		puts "ErrDimensionMismatch"
	end
else
	fail 'No Exception thrown'
end

# MATRIX FUNCTIONS
puts sm.transpose.full
puts sm.trace

# NOTE: Matrix functions that are not specified in this file can still be used, they will just be delegated to the Matrix class.

