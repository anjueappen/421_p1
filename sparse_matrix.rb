require 'matrix'

class SparseMatrix 

  @values
  @val_row 
  @val_col
  @full_matrix
  
  def initialize(rows)
    @full_matrix = Matrix(rows) 
    store(rows);  
  end
  
   def SparseMatrix.[](*rows)
    store(rows)
  end
 
  def store(matrix)
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
