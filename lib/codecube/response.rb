module CodeCube
  class Response
    def initialize(data)
      @data = data
    end

    def duration
      @data["duration_ms"]
    end

    def timed_out?
      @data["timed_out"]
    end

    def output
      @data["output"]
    end

    def text_output
      @data["output"].select { |l| %w(stdout stderr).include?(l["stream"]) }
                     .map { |l| l["body"] }
                     .join("\n")
    end
  end
end
