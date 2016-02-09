require_relative './sparse_matrix.rb'

class TridiagonalMatrix < SparseMatrix

  attr_reader :upper_diagonal, :mid_diagonal, :lower_diagonal, :n

  def initialize(*data)

    @upper_diagonal = []
    @mid_diagonal = []
    @lower_diagonal = []

    method = data[0]
    data.shift()

    if method == :diagonals
      @mid_diagonal, @upper_diagonal, @lower_diagonal = data
      return
    end

    @mid_diagonal, @upper_diagonal, @lower_diagonal = compress_store(Matrix.send(method, *data))
    @n = @mid_diagonal.size

  end

  #equivalent to compressed_store()
  def TridiagonalMatrix.diagonals(mid_d, upper_d, lower_d)
    TridiagonalMatrix.new(:diagonals, mid_d, upper_d, lower_d)
  end


  def full
    full_m = Array.new(@n) { |k| Array.new(@n) { |l| 0 }}
    @n.times do |i|
      if i-1 >= 0
        full_m[i-1][i] = @upper_diagonal[i]
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
      return {}, 0, 0 #empty hash
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

    if !(mid_diagonal.size == upper_diagonal.size-1) and !(mid_diagonal.size == lower_diagonal.size-1)
      raise Exception.new('Matrix diagonals are improper length')
    end
    return mid_diagonal, upper_diagonal, lower_diagonal
  end

  def extend_diagonal(mid, upper, lower)
    @mid_diagonal.push(mid)
    @upper_diagonal.push(upper)
    @lower_diagonal.push(lower)
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
        mid_diagonal, upper_diagonal, lower_diagonal = compress_store(result)
        return TridiagonalMatrix.new(:diagonals, mid_diagonal, upper_diagonal, lower_diagonal)
      else
        return result
      end
    else
      super
    end
  end
end