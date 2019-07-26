require '../lib/dataCollector/protocols/raurora'

module DataCollector
  class AuroraRTU
    def initialize(ip_address)
      @aurora_protocol = AuroraProtocol.new(ip_address)
    end

    def connect
      @aurora_protocol.connect
    end

    def read_inverters(devices)
      devices.each do |inverter|
        puts inverter
        # read_state(inverter["address"].to_i)
        read_power(inverter["address"].to_i)
      end
    end

    def read_state(address)
      puts @aurora_protocol.send(address, 50)
    end


    def read_voltage(address)
      puts @aurora_protocol.send(address, 59, 1)
    end

    def read_current(address)
      puts @aurora_protocol.send(address, 59, 2)
    end

    def read_power(address)
      power = @aurora_protocol.send(address, 59, 3)
      print power
      puts
      print power[2..5].reverse
      result = power[2..5].reverse.pack('C*').unpack('F')
      puts result
    end
  end
end
