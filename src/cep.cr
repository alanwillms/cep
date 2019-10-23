require "http/server"
require "file"
require "dir"
require "option_parser"
require "./cep/*"

port = 3000
tempdir = Dir.tempdir
start = false

parser = OptionParser.parse do |parser|
  parser.banner = "Usage: cep [arguments]"
  parser.on("-start", "Start the server") { start = true }
  parser.on("-p NUMBER", "--port=NUMBER", "Server port") { |number| port = number.to_i32 }
  parser.on("-t PATH", "--tempdir=PATH", "Temporary directory for cache") { |path| tempdir = path.to_s }
  parser.on("-h", "--help", "Show this help") { puts parser }
end

puts parser unless start

server = HTTP::Server.new do |context|
  application = Cep::Application.new(context.request, context.response, tempdir)
  application.run
end

address = server.bind_tcp port

puts "Listening on #{address}"

server.listen
