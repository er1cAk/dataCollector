require './lib/helpers/databaseAdapter'
require './lib/auroraRTU/auroraRTU'
require './lib/modbusProtocol/modbusTCP/modbusTCP'
require './lib/modbusProtocol/modbusRTUviaTCP/modbusRTUviaTCP'

module DataCollector
  include Helpers
  include AuroraRTU
  include ModBusProtocol
  VERSION = "0.1.0"
end
