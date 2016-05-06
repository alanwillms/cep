module Cep
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
end
