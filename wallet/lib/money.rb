require 'bigdecimal'

class Money < BigDecimal
end

def Money(*args)
  Money.new(*args)
end
