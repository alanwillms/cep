module Cep
  class ViaCep
    def initialize(@cep : Cep)
    end

    def get_json : String
      response = HTTP::Client.get "http://viacep.com.br/ws/#{@cep.value}/json/"
      response.body
    end
  end
end
