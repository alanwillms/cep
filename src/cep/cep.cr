module Cep
  class Cep
    getter :value

    def initialize(@value : String)
    end

    def valid?
      /^[0-9]{8}$/ =~ @value
    end
  end
end
