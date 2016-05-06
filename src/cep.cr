require "http/server"
require "file"
require "tempfile"
require "option_parser"
# require "./cep/*"

# Written into a single file for learning purposes (easier to read together)
module Cep
  class Application
    private getter :request, :response, :tempdir

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
        data = Cep::ViaCep.new(cep).get_json
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
      @cep ||= Cep::Cep.new(request.path.to_s[1..-1])
    end

    private def cache
      @cache ||= Cache.new(cep, tempdir)
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

  class Cache
    def initialize(@cep : Cep, @tmpdir : String)
    end

    def exists?
      File.exists? file_name
    end

    def set(content)
      File.write file_name, content
      nil
    end

    def get
      File.read file_name
    end

    private def file_name
      ds = File::SEPARATOR_STRING
      "#{@tmpdir}#{ds}#{@cep.value}.json"
    end
  end

  class ViaCep
    def initialize(@cep : Cep)
    end

    def get_json : String
      response = HTTP::Client.get "http://viacep.com.br/ws/#{@cep.value}/json/"
      response.body
    end
  end
end

port = 3000
tempdir = Tempfile.dirname
start = false

parser = OptionParser.parse! do |parser|
  parser.banner = "Usage: cep [arguments]"
  parser.on("start", "Start the server") { start = true }
  parser.on("-p NUMBER", "--port=NUMBER", "Server port") { |number| port = number.to_i32 }
  parser.on("-t PATH", "--tempdir=PATH", "Temporary directory for cache") { |path| tempdir = path.to_s }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

if start
  puts "Listening on http://0.0.0.0:#{port}"

  server = HTTP::Server.new(port) do |context|
    Cep::Application.new(context.request, context.response, tempdir).run
  end

  server.listen
else
  puts parser
end
