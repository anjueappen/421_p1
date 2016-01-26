require 'matrix'

class SparseMatrix < Matrix
  
  #storage of matricies 
  def store(matrix)
    if not matrix.is_a? Matrix
      raise Exception.new("Parameter must be a Matrix instance")
    end
  end
  
end
