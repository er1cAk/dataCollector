require '../lib/dataCollector/protocols/raurora'
require '../lib/dataCollector/databaseAdapter'
require '../lib/dataCollector/protocols/auroraRTU'
require '../lib/dataCollector/protocols/modbusRTUviaTCP'

module DataCollector

  @devices = (DatabaseAdapter.new.get_devices(ARGV[0]))

  @devices.select do |device|
    if device["access_point"]
      case device["protocol"]
      when 1
        @protocol = AuroraRTU.new(device["address"])
        @protocol.connect
      when 2
        @protocol = ModbusRTUviaTCP.new(device["address"])
      else
        @protocol = nil
      end
      @devices.delete(device)
    end
  end

  @protocol.read_inverters(@devices)


end
