require 'matrix'

class SparseMatrix

=begin
Do we want attr_readers and writers at this point?
Don't see need for them yet, therefore not adding right now.
=end

  @values = Array.new
  @val_row = Array.new
  @val_col = Array.new
  @max_degree_of_sparsity = 0.5

  attr_reader :full_matrix, :values, :val_row, :val_col
=begin
INITIALIZATION METHODS - may change on what we choose to support
=end

	
  def initialize(*rows)
    @full_matrix = Matrix.rows(rows, false)
    # stub values below, TODO: code actual functionality with compress_store
    @values = Array.new
  	@val_col = Array.new
  	@val_row = Array.new
    compress_store(@full_matrix)
  end

  def method_missing(method, *args)
  	# TODO: the call for @full_matrix should be replaced with a function that generates the full matrix from our compressed storage! 
  	if @full_matrix.respond_to?(method)
  		@full_matrix.send(method, *args)
  	else
  		super
  	end
  end

  def SparseMatrix.[](*rows)
  	#stub
  	#SparseMatrix.new(*rows)	#delegate to initialize
		@values = Array.new
  	@val_col = Array.new
  	@val_row = Array.new
		@full_matrix = Matrix.rows(rows, false)
		#self.send(:initialize)[rows]
		compress_store(@full_matrix)
  end

  def SparseMatrix.zero(size)
  	#stub
  	@full_matrix = Matrix.zero(size)
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

  def SparseMatrix.compress_store(matrix)
  	# implemented work around for comment below
		# MICHELLE'S NOTE: This function throws an error when matrix.rows is called because it's a protected function... not sure why though. maybe it's getting confused with the base Matrix class having a function called rows too?
    # todo make sure that original dimesions are saved
		if not matrix.is_a? Matrix
      raise Exception.new("Parameter must be a Matrix instance")
    end
    if matrix.empty?
			raise Exception.new("Matrix can't be empty")
		end
		#i = 0
    for row in 0 ..matrix.send(:rows).length
			found_first_non_zero = false  # keep track if first non-zero row element was found. todo - what if row of zeros?
			for column in 0..matrix.column_count
        if matrix.send(:rows)[row][column] != 0
          @values.push(matrix.send(:rows)[row][column]) # add non-zero values
					@val_col.push(column) # add col of each non-zero value														
					if(!found_first_non_zero)# check if it's the first non-zero value in row
						@val_row.push(@values.index(matrix.send(:rows)[row][column]))
						found_first_non_zero = true
					end
					#@values[i] = matrix.rows[row][column]
          #@val_row[i] = row
          #@val_col[i] = column 
          #i = i+1  
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
	#stub
  end
 
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
