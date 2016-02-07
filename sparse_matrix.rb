require 'matrix'

class SparseMatrix

  @max_degree_of_sparsity = 0.5

  attr_reader :full_matrix, :values, :val_row, :val_col

=begin
INITIALIZATION METHODS
=end
  def initialize(*rows)
    @full_matrix = Matrix.rows(rows, false)
    @values = Array.new
    @val_row = Array.new
    @val_col = Array.new
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
  	SparseMatrix.new(*rows)
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

  def SparseMatrix.rows(rows)
    if not rows.kind_of?(Array) or not rows[0].kind_of?(Array)
      raise Exception.new("Parameter must be Array of Arrays.")
    end
    SparseMatrix.new(*rows)
  end

  def columns(columns)
    #this method will overwrite existing rows
    if not rows.kind_of?(Array) or not columns[0].kind_of?(Array)
      raise Exception.new("Parameter must be Array of Arrays.")
    end
    @full_matrix = Matrix.columns(columns)
    store(@full_matrix.rows)
  end

  def SparseMatrix.scalar(n, value)
    @full_matrix = Matrix.send(:scalar, n, value)
    compress_store(@full_matrix)
  end

  def compress_store(matrix)
    # TODO make sure that original dimesions are saved? for column_count and row_count.
		if not matrix.is_a? Matrix
      raise Exception.new("Parameter must be a Matrix instance")
    end
    if matrix.empty?
			raise Exception.new("Matrix can't be empty")
		end
    for row in 0 ..matrix.row_count-1
			found_first_non_zero = false  # keep track if first non-zero row element was found. todo - what if row of zeros?
			for column in 0..matrix.column_count-1
        element = matrix.send(:element, row, column)
        if element != 0 and !element.nil?
          @values.push(element) # add non-zero values
					@val_col.push(column) # add col of each non-zero value														
					if(!found_first_non_zero)# check if it's the first non-zero value in row
						@val_row.push(@values.index(element))
						found_first_non_zero = true
					end
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
