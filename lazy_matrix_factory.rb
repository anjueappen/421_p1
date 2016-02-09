require 'matrix'

class LazyMatrixFactory

  def method_missing(method, *args, &block)
    full_m = self.full()
    if full_m.respond_to?(method)
      if method.to_s.eql?("collect")
        full_m.send(method, &block)
      else
        full_m.send(method, *args)
      end
    else
      super
    end
  end

  def initialize(*rows)
    @values, @val_col, @val_row = compress_store(Matrix.rows(rows))
  end

  #some "abstract" methods below
  def full
    raise Exception.new('Method must be implemented by Lazy Matrix Factory subclasses.')
  end

  def LazyMatrixFactory.compress_store(matrix)
    raise Exception.new('Method must be implemented by Lazy Matrix Factory subclasses.')
  end

end