require 'rmodbus'
module DataCollector
  class ModbusRTUviaTCP

    def initialize(ip_address)
      @ip_address = ip_address
    end

    def read_inverters(devices)
      puts @ip_address
      puts devices
    end

  end
end
