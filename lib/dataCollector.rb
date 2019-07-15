require '../lib/dataCollector/modbusRTUviaTCP'
require '../lib/dataCollector/raurora'
require 'socket'
require 'digest/crc16_qt'

module DataCollector
  class Error < StandardError; end
  auroraProtocol = AuroraProtocol.new('192.168.24.10')
  auroraProtocol.connect
  auroraProtocol.send(11, 50)
end
