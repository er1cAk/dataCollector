module DataCollector
  class Inverter
    attr_accessor :id, :power, :voltage, :current, :state, :alarms

    def initialize(id)
      @id = id
    end

    def print_data
      puts "[ #{id} ] State: #{state}"
      puts "[ #{id} ] Power: #{power}"
      puts "[ #{id} ] Voltage: #{voltage}"
      puts "[ #{id} ] Current: #{current}"
      puts "[ #{id} ] Alarms: #{alarms}"
    end
  end
end
