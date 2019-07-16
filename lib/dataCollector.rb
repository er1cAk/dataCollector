require '../lib/dataCollector/modbusRTUviaTCP'
require '../lib/dataCollector/raurora'
require 'socket'
require 'digest/crc16_qt'
require 'rmodbus'

module DataCollector
  class Error < StandardError; end
  # auroraProtocol = AuroraProtocol.new('192.168.24.10')
  # auroraProtocol.connect
  # puts auroraProtocol.send(11, 50)
  # # ModBus::TCPClient.new('192.168.20.10') do |cl|
  #   # cl.with_slave(3) do |slave|
  # #     puts slave.input_registers[1949]
  # #   end
  # # end

end
