require '../lib/dataCollector/protocols/raurora'
require '../lib/dataCollector/databaseAdapter'
require '../lib/dataCollector/protocols/auroraRTU'
require '../lib/dataCollector/protocols/modbusRTUviaTCP'
require '../lib/dataCollector/protocols/modbusTCP'
require 'rmodbus'

module DataCollector

  @devices = (DatabaseAdapter.new.get_devices(ARGV[0]))

  @devices.select do |device|
    if device["access_point"]

      begin

        case device["protocol"]
        when 1
          @protocol = AuroraRTU.new(device["address"])
        when 2
          begin
            @protocol = ModbusRTUviaTCP.new(device["address"])
          rescue Errno::ECONNREFUSED
            puts 'errno 2'
          end
        when 3
          @protocol = ModBusTCP.new(device["address"])
        else
          @protocol = nil
        end

      rescue Errno::ECONNREFUSED
        puts "Device \"#{device["device_id"]}\" with address #{device["address"]} conn refused!"
      end

      @devices.delete(device)
    end
  end

  if @protocol
    @protocol.read_inverters(@devices)
  end

end
