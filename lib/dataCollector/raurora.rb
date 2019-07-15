# frozen_string_literal: true
require 'digest/crc16_qt'

module DataCollector
  class AuroraProtocol

    RESPONSE_SIZE = 8

    def initialize(hostname, port = 4001)
      @hostname = hostname
      @port = port
    end

    def connect
      @socket = TCPSocket.open(@hostname, @port)
      #   handle timeout
    end

    def disconnect
      @socket.close
    end

    def send(address, command, type = 0, global = 0)
      msg = [address, command, type, global, 0, 0, 0, 0]
      crc_16(msg)
      @socket.write(msg.pack('C*'))
      receive
    end

    def receive
      msg = @socket.read(RESPONSE_SIZE).unpack('C*')
      puts control_check_sum(msg)
    end

    def crc_16(msg)
      crc = Digest::CRC16QT.new.update(msg.pack('C*')).checksum
      msg.push(crc & 0xFF)
      msg.push((crc & 0xFF00) >> 8)
    end

    def control_check_sum(received_msg)
      crc = received_msg[0..5]
      crc_16(crc)
      received_msg == crc
    end
  end
end