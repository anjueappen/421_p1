require './lazy_matrix_factory.rb'

class TridiagonalMatrix < LazyMatrixFactory

  attr_reader :upper_diagonal, :mid_diagonal, :lower_diagonal, :n

  def full
    full_m = Array.new(@n) { |k| Array.new(@n) { |l| 0 }}
    @n.times do |i|
      if i-1 >= 0
        full_m[i-1][i] = :upper_diagonal[i]
      end
      full_m[i][i] = @mid_diagonal[i]
      if i+1 < @n
        full_m[i+1][i] = :lower_diagonal[i]
      end
    end
  end

end