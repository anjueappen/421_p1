require 'matrix'

class SparseMatrix

=begin
Do we want attr_readers and writers at this point?
Don't see need for them yet, therefore not adding right now.
=end

  @values
  @val_row
  @val_col

  attr_reader :full_matrix
=begin
INITIALIZATION METHODS - may change on what we choose to support
=end
  def initialize(rows)
    @full_matrix = Matrix.new(rows)
    compress_store(@full_matrix)
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




 
end
