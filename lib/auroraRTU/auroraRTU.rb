require './lib/auroraRTU/constants'

module AuroraRTU
  class AuroraRTU
    include Helpers

    def initialize(ip_address)
      @aurora_protocol = AuroraProtocol.new(ip_address)
    end

    def read_inverters(devices)
      devices.each do |device|
        puts device
        inverter = Inverter.new(device["device_id"])
        @address = device["address"].to_i
        state = read_state
        inverter.state = STATES[state[2]]
        inverter.alarms = ALARMS[state[5]]
        if inverter.state
          inverter.power = read_power
          inverter.voltage = read_voltage
          inverter.current = read_current
          inverter.print_data
        else
          puts 'Comm error write to DB'
        end
      end
    end

    def read_voltage
      read_dsp(GRID_VOLTAGE)
    end

    def read_current
      read_dsp(GRID_CURRENT)
    end

    def read_power
      read_dsp(GRID_POWER)
    end

    def read_state
      state = aurora_rtu_send(50)
      if state
        state
      else
        nil
      end
    end

    def read_dsp(type)
      dsp = aurora_rtu_send(59, type)
      if dsp
        dsp[2..5].reverse.pack('C*').unpack('f')
      end
    end

    def aurora_rtu_send(command, type = 0)
      begin
        @aurora_protocol.send(@address, command, type)
      rescue Timeout::Error
        puts 'aurora send timeout'
        nil
      end
    end

  end
end