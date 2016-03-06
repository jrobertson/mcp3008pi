#!/usr/bin/env ruby

# file: mcp3008pi.rb

require 'pi_piper'

# To use this gem you will need the following:
# 
# * a Raspberry Pi
# * an MCP3008 10-bit Analog-to-Digital Converter (ADC)
# * an analog sensor e.g. photocell


class Mcp3008Pi

  def initialize(pin: 0, pins: [pin]; clock: 18, dout: 23, din: 24, cs: 25)

    @adc_pins = pins

    a = [clock, dout, din, cs]
    unexport_all a
    
    @clock = PiPiper::Pin.new :pin => clock, :direction => :out
    @adc_out = PiPiper::Pin.new :pin => dout
    @adc_in = PiPiper::Pin.new :pin => din, :direction => :out
    @cs = PiPiper::Pin.new :pin => cs, :direction => :out
    
    at_exit do
      
      # to avoid "Device or resource busy @ fptr_finalize - /sys/class/gpio/export"
      # we unexport the pins we used
      
      unexport_all a
    end      

  end

  def read()
    
    a = @adc_pins.map { read_adc(@adc_pin, @clock, @adc_in, @adc_out, @cs) }
    return a.first if a.length == 1
    
    return a
  end

  private

  def read_adc(adc_pin, clockpin, adc_in, adc_out, cspin)

    cspin.on
    clockpin.off
    cspin.off
    
    command_out = adc_pin
    command_out |= 0x18
    command_out <<= 3

    (0..4).each do
      adc_in.update_value((command_out & 0x80) > 0)
      command_out <<= 1
      clockpin.on
      clockpin.off
    end

    result = 0

    (0..11).each do
      clockpin.on
      clockpin.off
      result <<= 1
      adc_out.read
      if adc_out.on?
        result |= 0x1
      end
    end 

    cspin.on

    result >> 1
  end
  
  def unexport_all(pins)
    
    pins.each do |pin|
      
      next unless File.exists? '/sys/class/gpio/gpio' + pin.to_s

      File.write '/sys/class/gpio/unexport', pin

    end
    
  end  
end
