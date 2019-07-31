require 'rmodbus'

module ModBusProtocol
  class ModbusRTUviaTCP
    def initialize(ip_address)
      @cl = ModBus::RTUViaTCPClient.connect(ip_address, 1001)
    end

    def read_inverters(devices)
      puts devices
      if @cl
        slave = @cl.with_slave(2)
        puts slave.input_registers[1107]
        puts slave.input_registers[1949]
        puts slave.input_registers[1103]
      end
    end

    def read_power

    end

    def read_voltage

    end

    def read_current

    end
    
    def alarm_one

    end

    def alarm_two

    end

    def alarm_one_description

    end

    def alarm_two_description

    end
  end
end
