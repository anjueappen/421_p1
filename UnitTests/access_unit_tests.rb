
require 'test/unit'
require '../sparse_matrix.rb'

class AccessUnitTests < Test::Unit::TestCase

  def test_non_zero_count
    #pre
    sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]

    #post
    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals(4, sparse_matrix.nonZeroCount())
    assertEquals(4, sparse_matrix.values.size)
  end

  def test_zero_count
    #pre
    sparse_matrix = SparseMatrix[[1,0,0,0], [0,2,0,0], [3,0,0,0], [0,0,0,4]]

    #post
    assert_true(sparse_matrix.is_a? Matrix)
    assertEquals(12, sparse_matrix.zeroCount())
  end

end #end class

