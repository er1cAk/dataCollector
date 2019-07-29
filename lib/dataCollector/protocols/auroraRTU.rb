require '../lib/dataCollector/protocols/raurora'
require '../lib/dataCollector/inverter'

module DataCollector
  class AuroraRTU
    def initialize(ip_address)
      @aurora_protocol = AuroraProtocol.new(ip_address)
    end

    def read_inverters(devices)
      devices.each do |device|
        puts device
        inverter = Inverter.new(device["device_id"])
        @address = device["address"].to_i
        inverter.state = read_state
        if inverter.state && @address
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
      read_dsp(1)
    end

    def read_current
      read_dsp(2)
    end

    def read_power
      read_dsp(3)
    end

    def read_state
      state = aurora_rtu_send(50)
      if state
        inverter_state(state)
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

    def inverter_state(code)
      case code
      when 0
        'Stand by'
      when 1
        'Checking grid'
      when 2
        'Run'
      when 3
        'Bulk OV'
      else
        'default'
      end
    end

    def alarm(code)
      case code
      when 1
        'Sun Low'
      when 2
        'Input OC'
      when 3
        'Input UV'
      when 4
        'Input OV'
      when 5
        'Sun Low'
      when 6
        'No Parameters'
      when 7
        'Bulk OV'
      when 8
        'Comm.Error'
      when 9
        'Output OC'
      when 10
        'IGBT Sat'
      when 11
        'Bulk UV'
      when 12
        'Internal error'
      when 13
        'Grid Fail'
      when 14
        'Bulk Low'
      when 15
        'Ramp Fail'
      when 16
        'Dc/Dc Fail'
      when 17
        'Wrong Mode'
      when 18
        'Ground Fault'
      when 19
        'Over Temp.'
      when 20
        'Bulk Cap Fail'
      when 21
        'Inverter Fail'
      when 22
        'Start Timeout'
      when 23
        'Ground Fault'
      when 24
        'Degauss error'
      when 25
        'Ileak sens.fail'
      when 26
        'DcDc Fail'
      when 27
        'Self Test Error 1'
      when 28
        'Self Test Error 2'
      when 29
        'Self Test Error 3'
      when 30
        'Self Test Error 4'
      when 31
        'DC inj error'
      when 32
        'Grid OV'
      when 33
        'Grid UV'
      when 34
        'Grid OF'
      when 35
        'Grid UF'
      when 36
        'Z grid Hi'
      when 37
        'Internal error'
      when 38
        'Riso Low'
      when 39
        'Vref Error'
      when 40
        'Error Meas V'
      when 41
        'Error Meas F'
      when 42
        'Error Meas Z'
      when 43
        'Error Meas Ileak'
      when 44
        'Error Read V'
      when 45
        'Error Read I'
      when 46
        'Table fail'
      when 47
        'Fan Fail'
      when 48
        'UTH'
      when 49
        'Interlock fail'
      when 50
        'Remote Off'
      when 51
        'Vout Avg error'
      when 52
        'Battery low'
      when 53
        'Clk fail'
      when 54
        'Input UC'
      when 55
        'Zero Power'
      when 56
        'Fan Stucked'
      when 57
        'DC Switch Open'
      when 58
        'Tras Switch Open'
      when 59
        'AC Switch Open'
      when 60
        'Bulk UV'
      when 61
        'Autoexclusion'
      when 62
        'Grid df/dt'
      when 63
        'Den switch Open'
      when 64
        'Jbox fail'
      else
        nil
      end
    end
  end
end