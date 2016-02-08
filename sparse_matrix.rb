require 'matrix'

class SparseMatrix

	attr_reader :full_matrix, :values, :val_row, :val_col,
							:row_count, :column_count, :size

=begin
INITIALIZATION METHODS
=end

	def initialize(*data)
		@values = {}
		@max_degree_of_sparsity = 0.5

		method = data[0]
		data.shift()
		compress_store(Matrix.send(method, *data))

	end

	def method_missing(method, *args, &block)
		full_m = self.full()
		if full_m.respond_to?(method)
			if method.to_s.eql?('collect')
				full_m.send(method, &block)
			else
				full_m.send(method, *args)
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
		SparseMatrix.new(:rows, *rows)
	end

	def SparseMatrix.columns(columns)
		#this method will overwrite existing rows
		if not columns.kind_of?(Array) or not columns[0].kind_of?(Array)
			raise Exception.new('Parameter must be Array of Arrays.')
		end
		SparseMatrix.new(:columns, *columns)
	end
	
	def SparseMatrix.compressed_format(values, row_count, column_count)
		SparseMatrix.new('compressed', values, row_count, column_count)
	end

	def compress_store(matrix)
		if not matrix.is_a? Matrix
			raise Exception.new('Parameter must be a Matrix instance')
		end

		if matrix.empty?
			@row_count = 0
			@column_count = 0
			@size = 0
			return {} #empty hash
			# raise Exception.new('Matrix can't be empty')
		end

		#store in hash
		matrix.each_with_index do |element, row, column|
			if element != 0
				@values[[row, column]] = element
			end
		end

		puts @values

		@row_count = matrix.row_count
		@column_count = matrix.column_count
		@size = @row_count * @column_count

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

	def first_minor(row, col)
		full_m = self.full()
		fm_matrix = full_m.send(:first_minor, row, col)
		values, val_col, val_row = compress_store(fm_matrix)
		return SparseMatrix.compressed_format(values, val_col, val_row, fm_matrix.row_count, fm_matrix.column_count)
	end

	def unitary?
		# all values are 1
		return @values.all? {|x| x == 1}
	end

	def sparse?
		return self.sparsity < @max_degree_of_sparsity
	end

	def sparsity
		#The fraction of non-zero elements over the total number of elements
		return @values.size.to_f / @size.to_f
	end

	def full
		# Strategy: Iterate through values array. Check to see if they are the first element of a new row. Add them to the correct row and column.
		# Strategy: Initialize an array with zeroes. Go through values, find their row and column.
		# The current implementation avoids the use of Array.index() method, which only returns the index of the first element it finds in the array, even if there are duplicate elements.
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
		# multiply number by matrix of ones.
		if number.zero?
			return self
		end
		matrix_to_add = Matrix.empty(self.row_count,self.column_count)
		matrix_to_add = matrix_to_add.collect {|value| number}
		return self+matrix_to_add
		
	end

	def -(arg)
			case(arg)
			
			when Numeric
								
			when Vector
			
			when Matrix
			
			when SparseMatrix
			
			else
				#try to coerce, but fail? or just raise exception?
				
			end
	end
	
	def +(arg)
			case(arg)
			
			when Numeric
								
			when Vector
			
			when Matrix
			
			when SparseMatrix
			
			else
				#try to coerce, but fail? or just raise exception?
				
			end
	end
	
	def *(arg)
			#todo test negative
			case(arg)

			when Numeric
				if arg.zero?
					return SparseMatrix.zero(self.row_count, self.column_count) 
				else
					# todo values used here
					# todo values used here
					new_values = self.values.collect {|value| value*arg}
					return SparseMatrix.compressed_format(new_values, self.val_col, self.val_row, self.row_count, self.column_count)  #only values vector will change
				end
			
			when Vector
				
			when Matrix
			
			when SparseMatrix
			
			else
				#try to coerce, but fail? or just raise exception?
			end
	end

	def /(arg)
			case(arg)
			# todo current error with rounding - rounds down and gets zero values for ints.
			# seems ok for floats
			#todo test negative
			when Numeric
					# todo think that ruby numeric class will handle divide by zero
					# todo values used here
					new_values = self.values.collect {|value| value/arg.to_f}
					return SparseMatrix.compressed_format(new_values, self.val_col, self.val_row, self.row_count, self.column_count)  #only values vector will change
			
			when Vector
			
			when Matrix
			
			when SparseMatrix
			
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
		SparseMatrix.new('compressed', @values, @val_row, @val_col)
	end

	def trace
		trace = 0
		size = @val_row.size

		size.times do |i|
			if @val_col[i] == @val_row[i]
				trace += @values[i]
			end
		end
		trace
	end

	def putNonZero(value, row, column)
		if value == 0
			return
		end

		if @val_row.include? row and @val_col.include? column and @val_row.index(row) == @val_col.index(column)
			@values[@val_row.index(row)] = value
		else
			@values.push(value)
			@val_row.push(row)
			@val_col.push(column)
		end
	end
end
