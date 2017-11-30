module Foo
  module Bar
    def baz
      if !!true
        return 'ok'
      else
        if true
          return 'ok again'
        else
          if true
            return '"d\'oh"'
          else
            if true
              return 'help'
            else
              return 'give up'
            end



          end
        end
      end
    end

    def single_line; raise StandardError.new; end
  end

  module Bar2

    DELTA = 1

    def alpha()
      1+2+3+4*5
      result = if true; 1 else 2 end
    end





    def beta(a, b, c, d: 1, e: 2, f: 3)
      case alpha
        when 1
          '1'
        when 2
          '2'
        else
          'else'
        end
    end

    GAMA = 1000000

  end
end
