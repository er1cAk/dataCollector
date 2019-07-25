require '../lib/dataCollector/raurora'
require '../lib/dataCollector/databaseAdapter'
require '../lib/dataCollector/auroraRTU'
require '../lib/dataCollector/modbusRTUviaTCP'

module DataCollector

  @devices = (DatabaseAdapter.new.get_devices(ARGV[0]))

  @devices.select do |device|
    if device["access_point"]
      case device["protocol"]
      when 1
        @protocol = AuroraRTU.new(device["address"])
      when 2
        @protocol = ModbusRTUviaTCP.new(device["address"])
      else
        @protocol = nil
      end
      @devices.delete(device)
    end
  end

  puts @protocol.read_inverters(@devices)


end
