require 'forwardable'

class LazyMatrixFactory < Forwardable

  def initialize(matrix)
    @matrix = matrix
  end

  def full #an abstract method for sub class overriding
    fail "Lazy Matrix must implement full!"
  end
  #def_delegators --finish with method to delegate

  @values
  @val_row
  @val_col

  @row_count
  @col_count

  @max_degree_of_sparsity = 0.5

  attr_reader :full_matrix, :values, :val_row, :val_col

  def initialize(*rows)
    @full_matrix = Matrix.rows(rows, false)

    # stub values below, TODO: code actual functionality with compress_store
    @values = []
    @val_col = []
    @val_row = []

    @row_count = rows.size
    @col_count = rows[0].size if @row_count > 0 else 0
    #compress_store(@full_matrix)
  end

  def method_missing(method, *args)
    full_matrix = full
    if full_matrix.respond_to?(method)
      full_matrix.send(method, *args)
    else
      super
    end
  end

  def initialize(matrix)
    @matrix = matrix
  end

  def full
    full_m = Array.new(@row_count) { |m| Array.new(@col_count) { |n| 0 }}
    @val_row.each do |i|
      @val_col.each do |j|
        full_m[i][j] = @values[@val_row.find_index(i)] if @val_row.find_index(i) != nil
      end
    end
  end
end