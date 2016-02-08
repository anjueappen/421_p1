require 'matrix'

class LazyMatrixFactory

  [:scalar, :columns, :diagonal, :identity, :zero].each do |method|
    define_singleton_method method  do |args|
      if Matrix.respond_to? method
        LazyMatrixFactory.compress_store(Matrix.send(method, args)) #once this matrix is stored, its thrown away
      end
    end
  end


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