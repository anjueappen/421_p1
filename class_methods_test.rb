require 'test/unit'
require 'spec_helper'
require_relative '../sparse_matrix.rb'

class ClassMethodsTest < Test::Unit::TestCase

  # Called before every test method runs. Can be used
  # to set up fixture information.
  def setup
    @sparse_matrix = SparseMatrix[[1,0], [0,2]]
  end

  # Called after every test method runs. Can be used to tear
  # down fixture information.

  def teardown
    # Do nothing
  end

  # Fake test
  def test_instance_of
    assert_true @sparse_matrix.instance_of? SparseMatrix
    assert_true @sparse_matrix.instance_of? Forwardable
  end

  def test_inspect
    assert_equal '[[1, 0]
                   [0, 2]]', @sparse_matrix.inspect
  end

  def test_display
    expect {@sparse_matrix.display}.to output("[[1, 0]\n[0, 2]]").to_stdout
  end

  def test_class
    assert_equal SparseMatrix, @sparse_matrix.class
  end

  def test_clone
    clone = @sparse_matrix.clone
    assert_true clone.is_a? SparseMatrix
    assert_false clone.__id__ == @sparse_matrix.__id__
  end

  def test_double_equals
    clone = @sparse_matrix.clone
    same = @sparse_matrix
    assert_true @sparse_matrix === same
    assert_false @sparse_matrix === clone
  end

  def test_arrow_equals
    clone = @sparse_matrix.clone
    same = @sparse_matrix
    assert_true @sparse_matrix <=> same
    assert_true @sparse_matrix <=> clone
  end

  def test_to_s
    string = @sparse_matrix.to_s
    assert_equal "[[1, 0],\n[0, 2]]", string
  end
end