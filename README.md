# Introducing the mcp3008pi gem

Read analog values from an MCP3008 10-bit Analog-to-Digital Converter (ADC) connected to a Raspberry Pi.

## Usage

    require 'mcp3008pi'

    adc = Mcp3008Pi.new(pin: 0, clock: 18, dout: 23, din: 24, cs: 25)
    adc.read


mcp3008 mcp3008pi gem adc
