require 'matrix'
require 'forwardable'

class SparseMatrix 
	extend Forwardable

=begin
Do we want attr_readers and writers at this point?
Don't see need for them yet, therefore not adding right now.
=end

  @values
  @val_row
  @val_col
  @max_degree_of_sparsity = 0.5

  attr_reader :full_matrix, :values, :val_row, :val_col
=begin
INITIALIZATION METHODS - may change on what we choose to support
=end
  def initialize(*rows)
    @full_matrix = Matrix.rows(rows, false)
    # stub values below, TODO: code actual functionality with compress_store
    @values = []
  	@val_col = []
  	@val_row = []
    #compress_store(@full_matrix)
  end

  # methods that will be delegated to Matrix class go here!
  def_delegators :full_matrix, :square?, :real?,
  	:row_count, :column_count, :index, :empty?,
  	:diagonal?, :zero?, :unitary?, :permutation?,
		:+, :-, :determinant, :inverse

  def SparseMatrix.[](*rows)
  	#stub
  	SparseMatrix.new(*rows)	#delegate to initialize
  end

  def SparseMatrix.zero(row,col)
  	#stub
  	@full_matrix = Matrix.zero(row,col)
  	# stub values below, TODO: code actual functionality with compress_store
    @values = []
  	@val_col = []
  	@val_row = []
  end

  def SparseMatrix.diagonal(*elements)
  	#stub
  	@full_matrix = Matrix.diagonal(*elements)
  	# stub values below, TODO: code actual functionality with compress_store
    @values = []
  	@val_col = []
  	@val_row = []
  end

  def SparseMatrix.identity(col)
  	#stub
  	@full_matrix = Matrix.identity(col)
  	# stub values below, TODO: code actual functionality with compress_store
    @values = []
  	@val_col = []
  	@val_row = []
  end

  def rows(rows)
    #this method will overwrite existing rows
    if not rows.kind_of?(Array) or not rows[0].kind_of?(Array)
      raise Exception.new("Parameter must be Array of Arrays.")
    end
    @full_matrix = Matrix.rows(rows, false)
    store(rows)
  end

  def columns(columns)
    #this method will overwrite existing rows
    if not rows.kind_of?(Array) or not columns[0].kind_of?(Array)
      raise Exception.new("Parameter must be Array of Arrays.")
    end
    @full_matrix = Matrix.columns(columns)
    store(@full_matrix.rows)
  end

  def compress_store(matrix)
  	# MICHELLE'S NOTE: This function throws an error when matrix.rows is called because it's a protected function... not sure why though. maybe it's getting confused with the base Matrix class having a function called rows too?
    if not matrix.is_a? Matrix
      raise Exception.new("Parameter must be a Matrix instance")
    end
    i = 0
    for row in 0 ..matrix.rows.length
      for column in 0..row.length
        if matrix.rows[row][column] != 0
          @values[i] = matrix.rows[row][column]
          @val_row[i] = row
          @val_col[i] = column 
          i = i+1  
        end
      end
    end
  end

  def cofactor
  	#stub
  end

  def nonzero_count
  	#stub
  end

  def nonzeros
  	#stub
  end

  def first_minor(row, col)
  	#stub
  end

  def sparse?
  	#stub
  end

  def sparsity
  	#The fraction of non-zero elements over the total number of elements
  end

  def full
  	#stub
  end

  def increase_all_values_by(number)
	# waiting on design decision.
	#will not stay here. just need it to eliminate errors in tests
	#stub
  end
  
  # currently need these to have tests which fail but do not have errors
  # can't call operators from matrix class at the moment due to storage of sparse matrix
  # could delegate + and - but would need something to convert the matrix to full first
  
 
  def *(numeric_arg)
  #stub
  end
  
  def /(numeric_arg)
  #stub
  end
  
  def**(numeric_arg)
  #stub
  end

end
