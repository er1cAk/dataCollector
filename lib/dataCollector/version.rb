require './lib/auroraRTU/auroraRTU'

module DataCollector
  include Helpers
  include AuroraRTU
  VERSION = "0.1.1"
end
