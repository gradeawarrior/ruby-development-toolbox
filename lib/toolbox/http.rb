require 'net/http'
require 'toolbox/boolean'
require 'toolbox/json'
require 'uri'

begin
  $SSL_AVAILABLE = true
  require 'net/https'
rescue Exception
  $SSL_AVAILABLE = false
end

module Toolbox

  ##
  # A simple testing client based on the Perl version found in:
  #
  #     https://github.com/gradeawarrior/QA-Perl-Lib/blob/master/QA/Test/WebService.pm
  #
  # An example usage would be the following:
  #
  #     require 'toolbox/http'
  #
  #     response = Toolbox::Http.request(:method => 'GET', :url => 'http://www.google.com')
  #     if response.code == 200.to_s
  #       puts "Yay! It worked!"
  #     else
  #       puts "Boo! Something broke!" unless response.code == 200.to_s
  #     end
  #
  class Http

    ##
    # Generate and display curl request
    #
    # == Parameters
    #     uri           : The URI you are performing the request on
    #     request       : The Net::HTTP Request object
    #
    # == Returns
    #     curl_request    : String representing the curl request
    #
    def self.generate_curl_request(uri, request)
      curl_request_str = "curl -v -X #{request.method} \"#{uri.scheme}://#{uri.host}:#{uri.port}#{request.path}\""

      # Generate headers
      request.each_header do |name, value|
        curl_request_str += " -H '#{name}: #{value}'" if (name !~ /user-agent/i && name !~ /accept/i)
      end

      curl_request_str += " -k" if (uri.scheme.to_s == "https")
      curl_request_str += " -d 'YOUR_REQUEST_BODY'" if state.nil? && state.get(:curl_file).nil?
      curl_request_str += " -d @#{state.get(:curl_file)}" if !state.nil? && !state.get(:curl_file).nil?
      curl_request_str
    end

    ##
    # Show details about request
    #
    # == Parameters
    #     uri                 : The URI you are performing the request on
    #     request             : The Net::HTTP Request object
    #     disable_print_body  : Disables printing body
    #
    def self.show_req(uri, request, disable_print_body=false)

      ## Print verbose output from RESTest
      puts "$ #{generate_curl_request(uri, request)}"
      puts '---[ Request ]----------------------------------------------------'
      puts "URI: #{uri.scheme}://#{uri.host}:#{uri.port}"
      puts "#{request.method} #{request.path}"

      request.each_header { |name, value| puts "#{name}: #{value}" }
      if disable_print_body
        puts "\n<!-- Disabled print body for Content-Type: #{request.content_type}-->\n"
      else
        puts "\n#{request.body}\n"
      end
      puts '------------------------------------------------------------------'

    end

    ##
    # Show details about response received
    #
    # == Parameters
    #     response            : The Net::HTTPResponse object
    #     disable_print_body  : Disables printing body
    #
    def self.show_response(response, disable_print_body=false)

      puts '---[ Response ]---------------------------------------------------'
      if response
        puts "#{response.code} #{response.message}"
        if (response.code.to_i > 0)
          response.each_header { |name, value| puts "#{name}: #{value}" }
        end
        if disable_print_body
          puts "\n<!-- Disabled print body for Content-Type: #{request.content_type}-->\n"
        else
          puts "\n#{response.body}\n"
        end
      else
        puts 'response object is nil!'
      end
      puts '------------------------------------------------------------------'

    end

    ##
    # A simple testing client based on the Perl version found in:
    #
    #     https://github.com/gradeawarrior/QA-Perl-Lib/blob/master/QA/Test/WebService.pm
    #
    # == Parameters
    #     :method                => (Required) Sets the request method to perform. The valid methods are GET, POST, PUT, & DELETE
    #     :url                   => (Required) This should be set to the exact service API (e.g. 'http://www.google.com'). Port,
    #                                          path, and query parameters should also be specified. NOTE: If you specified the
    #                                          :request option, then the URI path and query parameters will be configured there.
    #     :request               => (Optional) Default: nil - You can optionally setup your Net::HTTP::[Get|Post|Put|Delete]
    #                                                         operation here. Other request could also be specified here if
    #                                                         not supported via :method parameter.
    #     :timeout               => (Optional) Default: 60 - This is the default request timeout
    #     :basic_auth            => (Optional) Default: nil - This should be a hash containing 'user' and 'password' keys
    #     :headers               => (Optional) Default: {} - A Hash containing all the Request headers that need to be set
    #     :request_body          => (Optional) Default: nil - The request body for PUT and POST requests
    #     :content_type          => (Optional) Default: nil - Sets the 'Content-Type' header
    #     :debug                 => (Optional) Default: false - Enables debug output
    #     :disable_print_body    => (Optional) Default: false - This will hide the request/response body output
    #
    # == Returns
    #
    # A Net::HTTPResponse object is returned. This is the standard object returned from Net::HTTP
    #
    # == Throws (Exceptions)
    #
    # Any of the standard Net::HTTP::Exceptions could be returned if there is an error connecting
    # to the downstream server.
    #
    # Additionally, The method could return:
    # - ArgumentError
    # - URI parse error
    #
    def self.request(*args)

      args = args.nil? || args.empty? ? {} : args.pop
      args = {} unless args.is_a?(::Hash)
      raise ArgumentError, 'method is required!' if args[:method].nil? && args[:request].nil?
      raise ArgumentError, 'url is required!' if args[:url].nil?

      ## Options and defaults
      request = args[:request]
      args[:method] = request.method if request
      args[:timeout] = args[:timeout] ? args[:timeout] : 60
      args[:headers] = args[:headers] ? args[:headers] : {}
      args[:headers]['Content-Type'] = args[:content_type] if args[:content_type]
      args[:debug] = args[:debug].nil? ? false : args[:debug].to_bool
      args[:disable_print_body] = args[:disable_print_body].nil? ? false : args[:disable_print_body].to_bool

      puts "Requesting: #{args[:method]} #{uri.to_s}" if args[:debug]

      ## Set the request based on the URL
      if args[:url]
        uri = args[:url].is_a?(::URI) ? args[:url] : URI(args[:url])
        request_path = "#{uri.path}#{uri.query || ''}"
        request_path = request_path.empty? ? '/' : request_path

        if args[:method]
          request = case args[:method]
                      when 'GET'
                        Net::HTTP::Get.new(request_path, args[:headers])
                      when 'POST'
                        req = Net::HTTP::Post.new(request_path, args[:headers])
                        req.body = args[:request_body] if args[:request_body]
                        req
                      when 'PUT'
                        req = Net::HTTP::Put.new(request_path, args[:headers])
                        req.body = args[:request_body] if args[:request_body]
                        req
                      when 'DELETE'
                        Net::HTTP::Delete.new(request_path, args[:headers])
                      else
                        raise ArgumentError, "Invalid method #{args[:method]}!"
                    end
        end
      end

      ## Set Auth
      req.basic_auth(args[:basic_auth]['user'], args[:basic_auth]['password']) if args[:basic_auth]

      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = args[:timeout]

      if uri.scheme == 'https'
        raise RuntimeError, 'SSL required but not available!' unless $SSL_AVAILABLE
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end

      show_req(uri, request, state) if args[:debug]
      response = http.request(request)
      show_response(response) if args[:debug]
      response

    end

  end
end