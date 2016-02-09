require_relative './sparse_matrix.rb'

class TridiagonalMatrix < SparseMatrix

  attr_reader :upper_diagonal, :mid_diagonal, :lower_diagonal, :n

  def initialize(*data)

    @max_degree_of_sparsity = 0.5
    @mid_diagonal = []
    @upper_diagonal = []
    @lower_diagonal = []

    method = data[0]
    data.shift()

    if method.is_a? Symbol
      if method == :diagonals
        @upper_diagonal, @mid_diagonal, @lower_diagonal = data
      else
        @mid_diagonal, @upper_diagonal, @lower_diagonal = compress_store(Matrix.send(method, *data))
      end
      @n = @mid_diagonal.size
    end
  end

  #equivalent to compressed_store()
  def TridiagonalMatrix.diagonals(upper_d, mid_d, lower_d)
    TridiagonalMatrix.new(:diagonals, upper_d, mid_d, lower_d)
  end


  def TridiagonalMatrix.[](*rows)
    TridiagonalMatrix.new(:[], *rows)
  end

  
  def TridiagonalMatrix.zero(rows, cols=rows)
    raise ScriptError.NotImplementedError.new('Single diagonal matrix not supported in Tridiagonal Matrix class')
  end

  def TridiagonalMatrix.diagonal(*elements)
    raise ScriptError.NotImplementedError.new('Single diagonal matrix not supported in Tridiagonal Matrix class')
  end

  def TridiagonalMatrix.identity(n)
    raise ScriptError.NotImplementedError.new('Single diagonal matrix not supported in Tridiagonal Matrix class')
  end

  def TridiagonalMatrix.scalar(n, value)
    raise ScriptError.NotImplementedError.new('Single diagonal matrix not supported in Tridiagonal Matrix class')
  end

  def TridiagonalMatrix.rows(rows)
    if not rows.kind_of?(Array) or not rows[0].kind_of?(Array)
      raise Exception.new('Parameter must be Array of Arrays.')
    end
    TridiagonalMatrix.new(:rows, rows)
  end

  def TridiagonalMatrix.columns(columns)
    #this method will overwrite existing rows
    if not columns.kind_of?(Array) or not columns[0].kind_of?(Array)
      raise Exception.new('Parameter must be Array of Arrays.')
    end
    TridiagonalMatrix.new(:columns, columns)
  end

  def full
    full_m = Array.new(@n) { |k| Array.new(@n) { |l| 0 }}
    @n.times do |i|
      if i-1 >= 0
        full_m[i-1][i] = @upper_diagonal[i-1]
      end
      full_m[i][i] = @mid_diagonal[i]
      if i+1 < @n
        full_m[i+1][i] = @lower_diagonal[i]
      end
    end
    Matrix.rows(full_m)
  end


  def compress_store(matrix)
    # returns values hash, row_count and column_count
    # storage of these values must be done manually in initialize if you want to do stuff with it.
    if not matrix.is_a? Matrix
      raise Exception.new('Parameter must be a Matrix instance')
    end

    if matrix.empty?
      return [], [], [] #empty hash
    end

    #store in hash
    mid_diagonal = []
    upper_diagonal = []
    lower_diagonal = []
    matrix.each_with_index do |element, row, column|
      if element != 0
        if row == column
          mid_diagonal[row] = element
        elsif column == row + 1
          upper_diagonal[row] = element
        elsif column + 1 == row
          lower_diagonal[column] = element
        else
          raise ArgumentError.new('Matrix contains elements outside of the tridiagonal')
        end
      end
    end
    if !(mid_diagonal.size-1 == upper_diagonal.size) or !(mid_diagonal.size-1 == lower_diagonal.size)
      raise Exception.new('Matrix diagonals are improper length')
    end
    return mid_diagonal, upper_diagonal, lower_diagonal
  end

  def extend_diagonal(upper, mid, lower)
    @mid_diagonal.push(mid)
    @upper_diagonal.push(upper)
    @lower_diagonal.push(lower)
    @n = @n+1
  end


  def method_missing(method, *args, &block)
    sparse_m = self.full()
    if sparse_m.respond_to?(method)
      puts "Trying sparse delegation"
      result = sparse_m.send(method, *args)
    elsif (full_m = sparse_m.full.respond_to?(method))
      puts "Trying matrix delegation"
      if method.to_s.eql?('collect')
        result = full_m.send(method, &block)
      else
        result = full_m.send(method, *args)
      end
    else
      super
    end
    if result.is_a?(Matrix)
      mid_diagonal, upper_diagonal, lower_diagonal = compress_store(result)
    elsif result.is_a?(SparseMatrix)
      mid_diagonal, upper_diagonal, lower_diagonal = compress_store(result.full)
    else
      return result
    end
    return TridiagonalMatrix.new(:diagonals, mid_diagonal, upper_diagonal, lower_diagonal)

  end

  def tridiagonal?
    return true
  end

  def sparsity
    #The fraction of non-zero elements over the total number of elements
    return (@mid_diagonal.size*3 -2).to_f / (@n*@n)
  end
end