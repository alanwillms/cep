require "http/server"
require "./cep/*"

# Written into a single file for learning purposes (easier to read together)
module Cep
  class Application
    private getter :request, :response

    def initialize(@request : HTTP::Request, @response : HTTP::Server::Response)
    end

    def run
      cep = Cep::Cep.new(request.path.to_s[1..-1])
      if cep.valid?
        response.content_type = "text/json; charset=UTF-8"
        response.print Cep::ViaCep.get(cep)
      else
        response.content_type = "text/plain; charset=UTF-8"
        if cep.value == ""
          response.print "Usage: /89805640"
        else
          response.print "CEP inválido: #{cep.value}"
        end
      end
    end
  end

  class Cep
    getter :value

    def initialize(@value : String)
    end

    def valid?
      /^[0-9]{8}$/ =~ @value
    end
  end

  class ViaCep
    def self.get(cep : Cep) : String
      response = HTTP::Client.get "http://viacep.com.br/ws/#{cep.value}/json/"
      response.body
    end
  end
end

server = HTTP::Server.new(3000) do |context|
  Cep::Application.new(context.request, context.response).run
end

puts "Listening on http://0.0.0.0:3000"
server.listen
