require 'forwardable'

class LazyMatrixFactory < Forwardable

  def initialize(matrix)
    @matrix = matrix
  end

  def full #an abstract method for sub class overriding
    fail "Lazy Matrix must implement full!"
  end
  #def_delegators --finish with method to delegate
end