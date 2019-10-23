module Cep
  class Cache
    EXPIRATION_TIME = 500

    def initialize(@cep : Cep, @tmpdir : String)
    end

    def exists?
      file_exists? && !file_expired?
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
      "#{@tmpdir}#{ds}cep#{@cep.value}.json"
    end

    private def file_exists?
      File.exists? file_name
    end

    private def file_expired?
      if File.info(file_name).modification_time + EXPIRATION_TIME.seconds < Time.local
        File.delete file_name
        return true
      end
      false
    end
  end
end
