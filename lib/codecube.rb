require "json"
require "uri"
require "typhoeus"
require "codecube/response"

module CodeCube
  class AuthenticationError < StandardError; end
  class ApiError < StandardError; end

  API_BASE_URL = "http://api.codecube.io/"

  class << self
    attr_accessor :api_key

    def run_sync(args = {})
      require_args!(args, [:language, :code])
      check_api_key!

      response = Typhoeus.post(api_url("/sync-run/").to_s,
                               body: JSON.dump(args),
                               headers: { 'Authorization' => api_key })
      case response.code
      when 200 then return Response.new(JSON.parse(response.body))
      when 401 then raise AuthenticationError, response.body
      else raise ApiError, response.body
      end
    end

    private

    def check_api_key!
      raise AuthenticationError, "no api_key set" if api_key.nil?
    end

    def require_args!(args, required_args)
      Array(required_args).each do |arg|
        if args[arg].nil?
          raise ArgumentError, "missing required argument '#{arg}'"
        end
      end
    end

    def api_url(path)
      uri = URI(API_BASE_URL)
      uri.path = path
      uri
    end
  end
end
