
require 'test/unit'
require './sparse_matrix.rb'

class UnitTest < Test::Unit::TestCase

  def test_initialize_square_brackets
    sparse_matrix = SparseMatrix[[1,0], [0,2]]
    assertEquals([1, 2], sparse_matrix.values)
    assertEquals([0, 1], sparse_matrix.rows)
    assertEquals([0, 1], sparse_matrix.columns)
  end

  def test_initialize_rows
    sparse_matrix = SparseMatrix.rows([[1,0], [0,2]])
    assertEquals([1, 2], sparse_matrix.values)
    assertEquals([0, 1], sparse_matrix.rows)
    assertEquals([0, 1], sparse_matrix.columns)
  end


  def test_initialize_scalar
    sparse_matrix = SparseMatrix.scalar(3, 2)
    assertEquals([2, 2, 2], sparse_matrix.values)
    assertEquals([0, 1, 2], sparse_matrix.rows)
    assertEquals([0, 1, 2], sparse_matrix.columns)
  end
  
  def test_initialize_columns
    sparse_matrix = SparseMatrix.columns([[1, 0, 1], [0, 2, 0]])
    assertEquals([1, 1, 2], sparse_matrix.values)
    assertEquals([0, 2, 1], sparse_matrix.rows)
    assertEquals([0, 0, 1], sparse_matrix.columns)
  end

  def test_initialize_diagonal
    sparse_matrix = SparseMatrix.diagonal([-9, 8, 3, 2, 1])
    assertEquals([-9, 8, 3, 2, 1], sparse_matrix.values)
    assertEquals([0, 1, 2, 3, 4], sparse_matrix.rows)
    assertEquals([0, 1, 2, 3, 4], sparse_matrix.columns)
  end

  def test_initialize_identity
    sparse_matrix = SparseMatrix.identity(5)
    assertEquals([1, 1, 1, 1, 1], sparse_matrix.values)
    assertEquals([0, 1, 2, 3, 4], sparse_matrix.rows)
    assertEquals([0, 1, 2, 3, 4], sparse_matrix.columns)
  end
  
  def test_initialize_identity
    sparse_matrix = SparseMatrix.zero(5)
    assertEquals([], sparse_matrix.values)
    assertEquals([], sparse_matrix.rows)
    assertEquals([], sparse_matrix.columns)
  end

  def test_initialize_row_vector
    sparse_matrix = SparseMatrix.row_vector([4, 0, 1])
    assertEquals([4, 1], sparse_matrix.values)
    assertEquals([0, 0], sparse_matrix.rows)
    assertEquals([0, 2], sparse_matrix.columns)
  end

  def test_initialize_column_vector
    sparse_matrix = SparseMatrix.column_vector([4, 0, 1])
    assertEquals([4, 1], sparse_matrix.values)
    assertEquals([0, 2], sparse_matrix.rows)
    assertEquals([0, 0], sparse_matrix.columns)
  end

end

=begin 
 Things to test for matricies: 
 1. test contents
 2. test type 
 3. test dimensions
 others?  
=end

