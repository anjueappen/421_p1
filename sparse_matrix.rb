require 'matrix'

class SparseMatrix

  attr_reader :full_matrix, :values,
              :row_count, :column_count, :size

# INITIALIZATION METHODS

  def initialize(*data)
    @values = {}
    @max_degree_of_sparsity = 0.5

    method = data[0]
    data.shift()

    if method.is_a?(String)
      @values, @row_count, @column_count = data
      return
    end

    @values, @row_count, @column_count = compress_store(Matrix.send(method, *data))
    @size = @row_count * @column_count

  end

  def method_missing(method, *args, &block)
    full_m = self.full()
    if full_m.respond_to?(method)
      if method.to_s.eql?('collect')
        result = full_m.send(method, &block)
      else
        result = full_m.send(method, *args)
      end
      if result.is_a?(Matrix)
        values, row_count, column_count = compress_store(result)
        return SparseMatrix.new("compressed", values, row_count, column_count)
      else
        return result
      end
    else
      super
    end
  end

  def SparseMatrix.[](*rows)
    SparseMatrix.new(:[], *rows)
  end

  def SparseMatrix.zero(rows, cols=rows)
    SparseMatrix.new(:zero, rows, cols)
  end

  def SparseMatrix.diagonal(*elements)
    SparseMatrix.new(:diagonal, *elements)
  end

  def SparseMatrix.identity(n)
    SparseMatrix.new(:identity, n)
  end

  def SparseMatrix.scalar(n, value)
    SparseMatrix.new(:scalar, n, value)
  end

  def SparseMatrix.rows(rows)
    if not rows.kind_of?(Array) or not rows[0].kind_of?(Array)
      raise Exception.new('Parameter must be Array of Arrays.')
    end
    SparseMatrix.new(:rows, rows)
  end

  def SparseMatrix.columns(columns)
    #this method will overwrite existing rows
    if not columns.kind_of?(Array) or not columns[0].kind_of?(Array)
      raise Exception.new('Parameter must be Array of Arrays.')
    end
    SparseMatrix.new(:columns, columns)
  end

  def SparseMatrix.compressed_format(values, row_count, column_count)
    SparseMatrix.new('compressed', values, row_count, column_count)
  end

  def compress_store(matrix)
    # returns values hash, row_count and column_count
    # storage of these values must be done manually in initialize if you want to do stuff with it.
    if not matrix.is_a? Matrix
      raise Exception.new('Parameter must be a Matrix instance')
    end

    if matrix.empty?
      return {}, 0, 0 #empty hash
    end

    values = {}
    #store in hash
    matrix.each_with_index do |element, row, column|
      if element != 0
        values[[row, column]] = element
      end
    end

    puts values
    return values, matrix.row_count, matrix.column_count
  end

  def to_s
    return self.full().send(:to_s).sub! 'Matrix', 'SparseMatrix'
  end

  def nonzero_count
    return @values.size
  end

  def nonzeros
    return @values
  end

  def unitary?
    return self.full.send(:unitary?)
  end

  def sparse?
    return self.sparsity < @max_degree_of_sparsity
  end

  def sparsity
    #The fraction of non-zero elements over the total number of elements
    return @values.size.to_f / @size.to_f
  end

  def full
    # full() returns a Matrix object

    #handle empty matrices
    if @values.empty? and @size == 0
      return Matrix[[]]
    end

    full_m = Array.new(@row_count) { |m| Array.new(@column_count) { |n| 0 }}  # throwing error 'no implicit conversion from nil to integer'

    if @values.empty?
      return Matrix.zero(@row_count,@column_count)
    end

    @values.each_pair { |index, element|
      full_m[index[0]][index[1]] = element
    }

    return Matrix.rows(full_m)
  end

  def increase_all_values_by(number)
    if number.zero?
      return self
    end
    new_values = {}
    for i in 0..self.row_count-1
    	for j in 0..self.column_count-1
    		if @values.has_key?([i,j])
    			new_element = @values[[i,j]] + number
    			if new_element != 0
    				new_values[[i,j]] = new_element
    			end
    		else
    			new_values[[i,j]] = number
    		end
    	end
    end
   	SparseMatrix.compressed_format(new_values, self.row_count, self.column_count)
  end

  def decrease_all_values_by(number)
    if number.zero?
      return self
    end
    new_values = {}
    for i in 0..self.row_count-1
    	for j in 0..self.column_count-1
    		if @values.has_key?([i,j])
    			new_element = @values[[i,j]] - number
    			if new_element != 0
    				new_values[[i,j]] = new_element
    			end
    		else
    			new_values[[i,j]] = number
    		end
    	end
    end
   	SparseMatrix.compressed_format(new_values, self.row_count, self.column_count)
  end

  def -(arg)
    case(arg)

      when Numeric
				raise Exception.new("ErrOperationNotDefined")
      when Vector
      	raise NotImplementedError
      when Matrix
				full_m = self.full()
      	result_m = full_m.send(:-, arg)
      	if result_m.is_a?(Matrix)
        	values, row_count, column_count = compress_store(result)
        	return SparseMatrix.compressed_format(values, row_count, column_count)
        end
      when SparseMatrix
				new_sm = {}
      	for i in 0..self.row_count-1
      		for j in 0..self.column_count-1
      			if self.values.has_key?([i,j]) and arg.values.has_key?([i,j])
      				new_sm[[i,j]] = self.values[[i,j]] - arg.values[[i,j]]
      			elsif self.values.has_key?([i,j]) and !arg.values.has_key?([i,j])
      				new_sm[[i,j]] = self.values[[i,j]]
      			elsif !self.values.has_key?([i,j]) and arg.values.has_key?([i,j])
      				new_sm[[i,j]] = -arg.values[[i,j]]
      			end
      		end
      	end
      	return SparseMatrix.compressed_format(new_sm, self.row_count, self.column_count)
      else
        #try to coerce, but fail? or just raise exception?
        raise Exception.new("ErrOperationNotDefined")
    end
  end

  def +(arg)
    case(arg)

      when Numeric
      	raise Exception.new("ErrOperationNotDefined")
      when Vector
      	raise NotImplementedError
      when Matrix
      	full_m = self.full()
      	result_m = full_m.send(:+, arg)
      	if result_m.is_a?(Matrix)
        	values, row_count, column_count = compress_store(result_m)
        	return SparseMatrix.compressed_format(values, row_count, column_count)
        end
      when SparseMatrix
      	new_sm = {}
      	for i in 0..self.row_count-1
      		for j in 0..self.column_count-1
      			if self.values.has_key?([i,j]) and arg.values.has_key?([i,j])
      				new_sm[[i,j]] = self.values[[i,j]] + arg.values[[i,j]]
      			elsif self.values.has_key?([i,j]) and !arg.values.has_key?([i,j])
      				new_sm[[i,j]] = self.values[[i,j]]
      			elsif !self.values.has_key?([i,j]) and arg.values.has_key?([i,j])
      				new_sm[[i,j]] = arg.values[[i,j]]
      			end
      		end
      	end
      	return SparseMatrix.compressed_format(new_sm, self.row_count, self.column_count)
      else
        #try to coerce, but fail? or just raise exception?
        raise Exception.new("ErrOperationNotDefined")
    end
  end

  def *(arg)
    #todo test negative
    case(arg)

      when Numeric
        if arg.zero?
          return SparseMatrix.zero(@row_count, @column_count)
        else
          #new_values = values.each_value {|value| value*arg}
					new_values = {}
					@values.each_pair { |key, value|
						new_values[[key[0], key[1]]] = value*arg
					}
          return SparseMatrix.new("compressed", new_values, @row_count, @column_count)   #only values vector will change
        end

      when Vector
				raise NotImplementedError
				
      when Matrix
				if @column_count != arg.row_count
					raise Exception.new('ErrDimensionMismatch')	
				end
				
      when SparseMatrix
				if @column_count != arg.row_count
					raise Exception.new('ErrDimensionMismatch')
				end
				if self.real? and arg.real?
					full_matrix_self = self.full() 
					full_matrix_arg = arg.full()
					result_matrix = full_matrix_self.send(:*,full_matrix_arg)
					new_values, new_row_count, new_column_count = compress_store(result_matrix)
					return SparseMatrix.new("compressed", new_values, new_row_count, new_column_count)
				end
				
      else
        #try to coerce, but fail? or just raise exception?
    end
  end

  def /(arg)
    case(arg)
      # todo current error with rounding - rounds down and gets zero values for ints.
      #todo test negative
      when Numeric
        # todo think that ruby numeric class will handle divide by zero				
				new_values = {}
					@values.each_pair { |key, value|
						new_values[[key[0], key[1]]] = value/arg.to_f
					}
          return SparseMatrix.new("compressed", new_values, @row_count, @column_count)   #only values vector will change
					
			when Vector
				raise NotImplementedError	
      
			when Matrix
				if @column_count != arg.row_count
					raise Exception.new('ErrDimensionMismatch')
				end	
      when SparseMatrix
				if @column_count != arg.row_count
					raise Exception.new('ErrDimensionMismatch')
				end
				if self.real? and arg.real?
					full_matrix_self = self.full() 
					full_matrix_arg = arg.full()
					result_matrix = full_matrix_self.send(:/,full_matrix_arg)
					new_values, new_row_count, new_column_count = compress_store(result_matrix)
					return SparseMatrix.new("compressed", new_values, new_row_count, new_column_count)
				end
				
      else
        #try to coerce, but fail? or just raise exception?

    end
  end


  def **(arg)
    #todo test negative
    if !arg.is_a? Integer
      # throw exception
      # call multiplication with self arg number of times
    end
  end

  def transpose
    # todo fix transpose
    new_hash = {}
    @values.each_pair { |key, value|
      new_hash[[key[1], key[0]]] = value
    }
    SparseMatrix.compressed_format(new_hash, @row_count, @column_count)
  end

  def trace
    trace = 0
    @values.each_pair { |key, value|
      if !value.is_a? Integer
        raise TypeError
      elsif key[0] == key[1]
        trace += value
      end
    }
    trace
  end

  def putNonZero(value, row, column)
    if value == 0
      raise Exception.new('Value must be non-zero')
    elsif !row.is_a?Integer or !column.is_a?Integer or row < 0  or column < 0
      raise ArgumentError
    end

    if row > @row_count-1
      @row_count = row
    end
    if column > @column_count-1
      @column_count = column
    end

    @values[[row, column]] = value
    if row > @row_count-1
      @row_count = row+1
    end
    if column > @column_count-1
      @column_count = column+1
    end
  end


end
