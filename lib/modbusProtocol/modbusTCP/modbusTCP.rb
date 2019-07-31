require 'rmodbus'
module ModBusProtocol
  class ModBusTCP
    def initialize(ip_address)
      @cl = ModBus::TCPClient.connect(ip_address, 502)
    end

    def read_inverters(devices)
      puts 'here'
      slave = @cl.with_slave(2)
      puts slave.input_registers[1107]
      puts slave.input_registers[1949]
      puts slave.input_registers[1103]
    end

  end
end
