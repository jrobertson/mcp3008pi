Gem::Specification.new do |s|
  s.name = 'mcp3008pi'
  s.version = '0.1.0'
  s.summary = 'Reads analog values from an MCP3008 10-bit Analog-to-Digital Converter (ADC) connected to a Raspberry Pi'  
  s.authors = ['James Robertson']
  s.files = Dir['lib/mcp3008pi.rb']
  s.add_runtime_dependency('pi_piper', '~> 1.9', '>=1.9.9')
  s.signing_key = '../privatekeys/mcp3008pi.pem'
  s.cert_chain  = ['gem-public_cert.pem']
  s.license = 'MIT'
  s.email = 'james@r0bertson.co.uk'
  s.homepage = 'https://github.com/jrobertson/mcp3008pi'
end
