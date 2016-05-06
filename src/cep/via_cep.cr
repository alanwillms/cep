module Cep
  class ViaCep
    def initialize(@cep : Cep)
    end

    def get_json : String
      response = HTTP::Client.get "http://viacep.com.br/ws/#{@cep.value}/json/"
      return "{\"erro\": true}" unless response.status_code == 200
      response.body
    end
  end
end
