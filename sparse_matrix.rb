require 'matrix'

class SparseMatrix

	attr_reader :full_matrix, :values, :val_row, :val_col, 
		:row_count, :column_count, :size

=begin
INITIALIZATION METHODS
=end
	def initialize(*data)
		@values = []
		@val_row = []
		@val_col = []
		@max_degree_of_sparsity = 0.5
		if !data[0].is_a? Array
			matrix_type = data[0]
			if matrix_type == "scalar"
				compress_store(Matrix.scalar(data[1], data[2]))
			elsif matrix_type == "columns"
				data.shift()
				compress_store(Matrix.columns(data))
			elsif matrix_type == "diagonal"
				data.shift()
				compress_store(Matrix.diagonal(*data))
			elsif matrix_type == "identity"
				compress_store(Matrix.identity(data[1]))
			elsif matrix_type == "zero"
				@row_count = data[1]
				@column_count = data[1]
				@size = @row_count * @column_count
			elsif matrix_type == "compressed"
				@values = data[1]
				@val_col = data[2]
				@val_row = data[3]
			end
		else
			compress_store(Matrix.rows(data, false))
		end
	end

	def method_missing(method, *args, &block) 
		full_m = self.full()
		if full_m.respond_to?(method)
			if method.to_s.eql?("collect")
				full_m.send(method, &block)
			else
				full_m.send(method, *args)
			end
		else
			super
		end
	end

	def SparseMatrix.[](*rows)
		SparseMatrix.new(*rows)
	end

	def SparseMatrix.zero(size)
		SparseMatrix.new("zero", size)
	end

	def SparseMatrix.diagonal(*elements)
		SparseMatrix.new("diagonal", *elements)
	end

	def SparseMatrix.identity(n)
		SparseMatrix.new("identity", n)
	end

	def SparseMatrix.scalar(n, value)
		SparseMatrix.new("scalar", n, value)
	end

	def SparseMatrix.rows(rows)
		if not rows.kind_of?(Array) or not rows[0].kind_of?(Array)
			raise Exception.new("Parameter must be Array of Arrays.")
		end
		SparseMatrix.new(*rows)
	end

	def SparseMatrix.columns(columns)
		#this method will overwrite existing rows
		if not columns.kind_of?(Array) or not columns[0].kind_of?(Array)
			raise Exception.new("Parameter must be Array of Arrays.")
		end
		SparseMatrix.new("columns", *columns)
	end

	def SparseMatrix.compressed_format(values, val_col, val_row)
		SparseMatrix.new("compressed", values, val_col, val_row)
	end

	def compress_store(matrix)
		# TODO make sure that original dimesions are saved? for column_count and row_count.
		if not matrix.is_a? Matrix
			raise Exception.new("Parameter must be a Matrix instance")
		end
		if matrix.empty?
			@row_count = 0
			@column_count = 0
			@size = 0
			return
			# raise Exception.new("Matrix can't be empty")
		end
		# puts ""
		# puts matrix
		for row in 0 ..matrix.row_count-1
			found_first_non_zero = false  # keep track if first non-zero row element was found. todo - what if row of zeros?
			for column in 0..matrix.column_count-1
				element = matrix.send(:element, row, column)
				if element != 0 and !element.nil?
					@values.push(element) # add non-zero values
					@val_col.push(column) # add col of each non-zero value														
					if(!found_first_non_zero)# check if it's the first non-zero value in row
						@val_row.push(@values.length-1)
						found_first_non_zero = true
					end
				end
			end
		end

		@row_count = matrix.row_count
		@column_count = matrix.column_count
		@size = @row_count * @column_count
	end

	def cofactor
		#stub
	end

	def nonzero_count
		return @values.size
	end

	def nonzeros
		return @values
	end

	def first_minor(row, col)
		#stub
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
		# The current implementation avoids the use of Array.index() method, which only returns the index of the first element it finds in the array, even if there are duplicate elements.
		# full() returns a Matrix object

		#handle empty matrices
		if @values.empty? and @size == 0
			return Matrix[[]]
		end 
		full_m = Array.new(@row_count) { |m| Array.new(@column_count) { |n| 0 }}
		row_index = 0
		if @values.empty?
			return Matrix.zero(@row_count)
		end
		for i in 0..@values.size-1 do
			row = @val_row[row_index]
			if i <= row 
				col = @val_col[i]
				full_m[row][col] = @values[i]
			end
			row_index += 1
		end
		return Matrix.rows(full_m)
	end

	def increase_all_values_by(number)
	end
 
	def *(numeric_arg)
	#stub
	end
	
	def /(numeric_arg)
	#stub
	end
	
	def **(numeric_arg)
	#stub
	end

end
