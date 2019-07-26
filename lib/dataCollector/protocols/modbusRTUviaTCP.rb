require 'rmodbus'

module DataCollector
  class ModbusRTUviaTCP
    def initialize(ip_address)
      begin
        @cl = ModBus::RTUViaTCPClient.connect(ip_address, 1001)
      rescue Errno::ECONNREFUSED, ModBus::Errors::ModBusTimeout
        puts 'conn refused'
      end
    end

    def read_inverters(devices)
      puts devices
      if @cl
        slave = @cl.with_slave(1)
        puts slave.read_input_registers 1949, 1
      end
    end
  end
end
