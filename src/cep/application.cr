module Cep
  class Application
    private getter :request, :response, :tempdir

    @cep : Cep | Nil
    @cache : Cache | Nil

    def initialize(@request : HTTP::Request, @response : HTTP::Server::Response, @tempdir : String)
    end

    def run
      if cep.valid?
        print_json
      else
        print_instructions
      end
    end

    private def print_json
      if cache.exists?
        data = cache.get
      else
        data = ViaCep.new(cep).get_json
        cache.set data
      end

      response.content_type = "text/json; charset=UTF-8"
      response.print data
    end

    private def print_instructions
      response.content_type = "text/plain; charset=UTF-8"
      if cep.value == ""
        response.print "Usage: /89805640"
      else
        response.print "CEP inválido: #{cep.value}"
      end
    end

    private def cep
      @cep ||= Cep.new(request.path.to_s[1..-1])
    end

    private def cache
      @cache ||= Cache.new(cep, tempdir)
    end
  end
end
