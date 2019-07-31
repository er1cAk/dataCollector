require 'excon'
require 'json'

module DataCollector
  module Helpers
    class DatabaseAdapter
      def initialize
        @config = JSON.parse(File.read('./config.json'))
        @token = get_token
      end

      def get_devices(pw_id)
        response = Excon.get(@config["API_URL"] + '/collectordevices?plant_id=eq.' + pw_id.to_s,
                             :headers => {:Authorization => 'Bearer ' + @token})
        JSON.parse(response.body)
      end

      def get_token
        JSON.parse(
            Excon.post(@config["API_URL"] + '/rpc/login',
                       :body => "{ \"email\": \"#{@config["email"]}\", \"pass\": \"#{@config["pass"]}\" }",
                       :headers => {"Content-Type" => "application/json"}
            ).body)[0]["token"]
      end
    end
  end
end